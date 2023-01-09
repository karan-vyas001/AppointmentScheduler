module AppointmentsHelper
  def get_slot(start_time, end_time, appointment)
    (appointment.start_time.localtime.strftime("%I:%M %p") == start_time) && (appointment.end_time.localtime.strftime("%I:%M %p") == end_time)
  end
end
