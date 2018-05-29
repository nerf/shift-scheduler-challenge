class Scheduler
  def initialize(house)
    @house = house
  end

  def book(employee, from:, to:)
    house.shifts.create(employee: employee, starts_at: from, ends_at: to)
  end

  def shifts(from: DateTime.current.beginning_of_day, to: DateTime.current.end_of_day)
    house.find_shifts(from, to)
  end

  private

  attr_reader :house
end
