class Houses < Sinatra::Base
  get '/houses' do
    houses = House.all

    houses.to_json(only: [:id, :name, :address])
  end

  post '/houses' do
    house = House.new(name: params[:name], address: params[:address])

    if house.save
      house.to_json(only: [:id, :name, :address])
    else
      house.errors.to_json
    end
  end
end
