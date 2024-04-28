require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone(phone)
  phone = phone.to_s.gsub(/\D/, '')
  if phone.size == 10
    phone
  elsif phone.size == 11 && phone[0] == '1'
    phone[1..]
  end
end

def legislators_by_zipcode(zip) # rubocop:disable Metrics/MethodLength
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output') # rubocop:disable Lint/NonAtomicFileOperation

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def peak_hours(regdates)
  registration_hours = Hash.new(0)

  regdates.each do |regdate|
    date_time = DateTime.strptime(regdate, '%m/%d/%y %H:%M')
    registration_hours[date_time.hour] += 1
  end
  registration_hours.max_by { |_, count| count }
end

def peak_days(regdates)
  registration_days = Hash.new(0)

  regdates.each do |regdate|
    date_time = DateTime.strptime(regdate, '%m/%d/%y %H:%M')
    registration_days[date_time.wday] += 1
  end

  registration_days.max_by { |_, count| count }
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

regdates = []
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone(row[:homephone])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)

  regdates << row[:regdate]
end

peak_hours = peak_hours(regdates)
puts "The peak registration hour is #{peak_hours[0]}:00 with #{peak_hours[1]} registrations."

peak_days = peak_days(regdates)
day_names = Date::DAYNAMES
puts "The peak registration day is #{day_names[peak_days[0]]} with #{peak_days[1]} registrations."
