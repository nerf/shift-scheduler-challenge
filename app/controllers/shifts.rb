class Shifts < Sinatra::Base
  get '/shifts/:house_id' do
    house = House.find(params[:house_id])
    scheduler = Scheduler.new(house)

    scheduler.shifts.to_json(only: [:id, :employee_id, :house_id, :starts_at, :ends_at, :duration])
  end

  post '/shifts' do
    house = House.find(params[:house_id])
    employee = Employee.find(params[:employee_id])
    scheduler = Scheduler.new(house)
    shift = scheduler.book(employee, from: params[:from], to: params[:to])

    if shift.errors.any?
      shift.errors.full_messages.to_json
    else
      shift.to_json(only: [:id, :employee_id, :house_id, :starts_at, :ends_at, :duration])
    end
  end
end
