# passthrough_controller.rb
class PassthroughController < ApplicationController
  def index
    path = case current_user&.roles&.first&.name
      when 'Doctor'
        availabilities_path
      when 'Patient'
        appointments_path
      else
        user_session_path
    end

    redirect_to path     
  end
end