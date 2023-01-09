class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    unless current_user.has_role?("Doctor")
      redirect_to root_path
      flash[:notice] = "You are not authorized to access this page."
    end
  end

  def booked_appointments
    @appointments = Appointment.where(user_id: current_user.id, booked: true)
  end

  def create
    day_availability = params[:day_availability]
    start_time = Time.parse(day_availability[:start_time])
    end_time = Time.parse(day_availability[:end_time])
    date = Date.today.beginning_of_week + Date::DAYNAMES.rotate(1).find_index(day_availability[:name]).days

    appointment = Appointment.find_by(user_id: day_availability["user_id"], date: date, start_time: start_time, end_time: end_time)
    if appointment.present?
      appointment.destroy
    else
      Appointment.create(user_id: day_availability["user_id"], date: date, start_time: start_time, end_time: end_time)
    end
  end
end
