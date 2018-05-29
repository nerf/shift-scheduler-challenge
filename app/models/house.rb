class House < ActiveRecord::Base
  has_many :employees
  has_many :shifts

  def find_shifts(from, to)
    shifts.where('MAX(starts_at, ?) < MIN(ends_at, ?)', from, to)
  end
end
