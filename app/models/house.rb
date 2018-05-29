class House < ActiveRecord::Base
  has_many :employees
  has_many :shifts

  validates :name, presence: true, uniqueness: true

  def find_shifts(from, to)
    shifts.where('MAX(starts_at, ?) < MIN(ends_at, ?)', from, to)
  end
end
