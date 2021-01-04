class AdminAgendasController < ApplicationAdminController
  include GoogleCalendarHelper
  def agenda
  	require 'googleauth'
    require 'google/apis/calendar_v3'
    @list_events = GoogleCalendarHelper.list_event_in_google_calendar
    
    puts "~~~~~~"
    @list_events.each do |event|
		  start = event.start.date || event.start.date_time
		  ends = event.end.date || event.end.date_time

		  puts "title: #{event.summary}\n
		  debut: (#{start}) \n
		  find: (#{ends}) \n
		  location: #{event.location} \n
		  description: #{event.description}"
    	puts "~~~~~~"
		end
		
  end
end
