require 'spec_helper'

RSpec.describe Scheduler do
  let(:employee) { create(:employee) }
  let(:house) { create(:house) }
  let(:scheduler) { Scheduler.new(house) }

  describe '#book' do
    it 'creates and return shift' do
      shift = scheduler.book(employee, from: DateTime.current, to: 1.hour.from_now)

      expect(shift).to be_persisted
      expect(shift.house).to eq(house)
      expect(shift.employee).to eq(employee)
      expect(shift.duration).to eq(60)
    end
  end

  describe '#shifts' do
    it 'lists booked shifts for period of time' do
      start_of_the_day = DateTime.current.beginning_of_day
      first_shift = scheduler.book(employee, from: start_of_the_day, to: start_of_the_day + 1.hour)
      second_shift = scheduler.book(employee, from: start_of_the_day + 8.hours, to: start_of_the_day + 10.hours)
      third_shift = scheduler.book(employee, from: start_of_the_day + 1.day, to: start_of_the_day + 1.day + 1.hour)

      shifts = scheduler.shifts

      aggregate_failures do
        expect(shifts.length).to eq(2)
        expect(shifts).to include(first_shift, second_shift)
      end
    end
  end
end
