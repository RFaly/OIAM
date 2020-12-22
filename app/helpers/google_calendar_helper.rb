module GoogleCalendarHelper
	class GoogleCalendar
	  def initialize
	    authorize
	  end

	  def service
	    @service
	  end
	  
	  def events(reload=false)
	    @events = nil if reload
	    @events ||= service.list_events(calendar_id, max_results: 2500).items
		@events.each do |event|
		  start = event.start.date || event.start.date_time
		  puts "- #{event.summary} (#{start})"
		end
	  end

	  def create_event(summary, location, description, start_date_time, end_date_time, time_zone, attendees_email = [])
	  	event = Google::Apis::CalendarV3::Event.new(
		  summary: summary,
		  location: location,
		  description: description,
		  start: Google::Apis::CalendarV3::EventDateTime.new(
		    date_time: start_date_time,
		    time_zone: time_zone
		  ),
		  end: Google::Apis::CalendarV3::EventDateTime.new(
		    date_time: end_date_time,
		    time_zone: time_zone
		  ),
		  # recurrence: [
		  #   'RRULE:FREQ=DAILY;COUNT=2'
		  # ],
		  # attendees: [
		  #   Google::Apis::CalendarV3::EventAttendee.new(
		  #     email: attendees_email[0]
		  #   ),
		  #   Google::Apis::CalendarV3::EventAttendee.new(
		  #     email: attendees_email[1]
		  #   )
		  # ],
		  reminders: Google::Apis::CalendarV3::Event::Reminders.new(
		    use_default: false,
		    overrides: [
		      Google::Apis::CalendarV3::EventReminder.new(
		        reminder_method: 'email',
		        minutes: 24 * 60
		      ),
		      Google::Apis::CalendarV3::EventReminder.new(
		        reminder_method: 'popup',
		        minutes: 10
		      )
		    ]
		  )
		)
		result = service.insert_event(calendar_id, event)
	  end

	private

	  def calendar_id
	    @calendar_id ||= "c_7lgk2p928ejof1vf22itnggcsg@group.calendar.google.com"
	  end

	  def authorize
	    calendar = Google::Apis::CalendarV3::CalendarService.new
	    calendar.client_options.application_name = 'One in a million' # This is optional
	    calendar.client_options.application_version = '0.0.0.1' # This is optional
	    ENV['GOOGLE_APPLICATION_CREDENTIALS'] = File.join(Rails.root, 'app', 'helpers', 'credential_google.json')
	    scopes = [Google::Apis::CalendarV3::AUTH_CALENDAR]
	    calendar.authorization = Google::Auth.get_application_default(scopes)
	    @service = calendar
	  end
	end

	def self.insert_event_to_google_calendar(summary,location,description,start_date_time,end_date_time,time_zone,attendees_email=[])
		calendar = GoogleCalendar.new
		calendar.create_event(
			summary = summary,
	        location = location,
	        description = description,
	        start_date_time = start_date_time,
	        end_date_time = end_date_time,
	        time_zone = time_zone,
	        attendees_email = attendees_email
		)
	end

	def self.list_event_in_google_calendar
		calendar = GoogleCalendar.new
		calendar.events
	end

end

=begin
a.strftime('%I:%M:%S')

2020-04-28T17:00:00-07:00
irb(main):047:0> a.strftime('%Y-%m-%dT%H:%M:%S')

<iframe src="https://calendar.google.com/calendar/embed?src=c_7lgk2p928ejof1vf22itnggcsg%40group.calendar.google.com&ctz=Africa%2FNairobi" style="border: 0" width="800" height="600" frameborder="0" scrolling="no"></iframe>

=end