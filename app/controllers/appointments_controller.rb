class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  # GET /appointments or /appointments.json
  def index
    @appointments = Appointment.where(booked: true, booked_by_id: current_user.id)
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end


  # GET /appointments/1/edit
  def edit
  end

  def get_users
    date = Date.parse(params[:date])
    user_ids = Appointment.where(date: date).pluck(:user_id).uniq
    @users = User.where(id: user_ids)
  end

  def get_slots
    date = Date.parse(params[:date]) if params[:date].present?
    user_id = params[:user_id]
    if params[:id].present?
      @appointment = Appointment.find(params[:id])
      @available_slots = Appointment.where("(date = ? and user = ? or booked_by_id = ?) or (booked = ?)", date, user_id, current_user.id, false)
    else
      @available_slots = Appointment.where(date: date, user: user_id, booked: false)
    end
  end

  # POST /appointments or /appointments.json
  def create
    slot = params[:appointment][:slot]
    start_time = slot.split("-")[0].strip
    @appointment = Appointment.where(user_id: appointment_params[:user_id], date: appointment_params[:date], start_time: Time.parse(start_time))
    respond_to do |format|
      if @appointment.update(booked_by_id: current_user.id, booked: true)
        format.html { redirect_to appointments_path, notice: "Appointment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    if appointment_params[:slot].present?
      slot = appointment_params[:slot].split('-')
      @appointment.start_time = Time.parse(slot[0].strip)
      @appointment.end_time = Time.parse(slot[1].strip)
    end
    @appointment.date = appointment_params[:date]
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully updated." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.update(booked_by_id: nil, booked: false)

    respond_to do |format|
      format.html { redirect_to appointments_url, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:booked, :date, :start_time, :end_time, :user_id, :booked_by_id, :slot)
    end
end
