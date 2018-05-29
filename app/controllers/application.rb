require 'sinatra/base'
require './app/controllers/houses'
require './app/controllers/employees'
require './app/controllers/shifts'

class Application < Sinatra::Base
  before do
    content_type 'application/json'
  end

  use Houses
  use Employees
  use Shifts

  get '/' do
<<EOF
GET /houses
POST /houses params: name, address
GET /employees
POST /employees params: name, house_id
GET /shifts
POST /shifts params: house_id, employee_id, from(DATETIME), to(DATETIME)
EOF
  end
end
