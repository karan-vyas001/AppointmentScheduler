module AvailabilitiesHelper
  def availability_created?(day, arr_object)
    check_date = Date.today.beginning_of_week + Date::DAYNAMES.rotate(1).find_index(day).days
    current_user.appointments.where(date: check_date).pluck(:start_time).map{|app| app.localtime.strftime("%I:%M %p")}.include?(arr_object.split("-").first.strip) if current_user.appointments.where(date: check_date).present?
  end

  def check_day(day)
    check_date = Date.today.beginning_of_week + Date::DAYNAMES.rotate(1).find_index(day).days
    check_date < Date.today
  end
end
