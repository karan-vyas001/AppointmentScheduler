class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :booked_by, class_name: "User", optional: true
end
