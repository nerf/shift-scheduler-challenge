class Shift < ActiveRecord::Base
  belongs_to :house
  belongs_to :employee
end
