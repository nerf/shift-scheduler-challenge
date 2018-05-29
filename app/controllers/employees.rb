class Employees < Sinatra::Base
  get '/employees' do
    employees = Employee.all

    employees.to_json(only: [:id, :name, :house_id])
  end

  post '/employees' do
    employee = Employee.new(name: params[:name], house_id: params[:house_id])

    if employee.save
      employee.to_json(only: [:id, :name, :house_id])
    else
      employee.errors.full_messages.to_json
    end
  end
end
