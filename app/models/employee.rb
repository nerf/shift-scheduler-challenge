class Employee < ActiveRecord::Base
  belongs_to :house
  has_many :shifts
end
