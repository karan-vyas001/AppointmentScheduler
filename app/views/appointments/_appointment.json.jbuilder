json.extract! appointment, :id, :booked, :date, :start_time, :end_time, :user_id, :booked_by_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
