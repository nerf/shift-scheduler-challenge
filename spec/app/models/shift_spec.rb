require 'spec_helper'

RSpec.describe Shift do
  describe '#duration' do
    it 'returns shift duration in minutes' do
      shift = Shift.new(starts_at: DateTime.current, ends_at: 15.minutes.from_now)

      expect(shift.duration).to eq(15)
    end
  end

  context 'validations' do
    let(:house) { create(:house) }
    let(:first_employee) { create(:employee) }
    let(:second_employee) { create(:employee) }

    describe 'checks for overlaps' do
      it 'sets error on overlapping shifts' do
        house.shifts.create(employee: first_employee, starts_at: 1.hour.from_now, ends_at: 3.hours.from_now)
        shift = house.shifts.create(employee: second_employee, starts_at: 2.hour.from_now, ends_at: 4.hours.from_now)

        expect(shift).not_to be_persisted
        expect(shift.errors[:starts_at]).to include('selected dates overlaps with another shift')
      end

      it 'does not set errors for between shifts' do
        house.shifts.create(employee: first_employee, starts_at: 1.hour.from_now, ends_at: 3.hours.from_now)
        first_shift = house.shifts.create(employee: second_employee, starts_at: 3.hour.from_now, ends_at: 4.hours.from_now)
        second_shift = house.shifts.create(employee: first_employee, starts_at: 4.hour.from_now, ends_at: 5.hours.from_now)

        aggregate_failures do
          expect(first_shift.errors).to be_empty
          expect(first_shift).to be_persisted
          expect(second_shift.errors).to be_empty
          expect(second_shift).to be_persisted
        end
      end
    end

    describe 'check daily hours limit' do
      let(:start_of_the_day) { DateTime.current.beginning_of_day }
      it 'sets error if exceeded in multiple shifts' do
        house.shifts.create(employee: first_employee, starts_at: start_of_the_day, ends_at: start_of_the_day + 4.hours)
        shift = house.shifts.new(employee: first_employee, starts_at: start_of_the_day + 6.hours, ends_at: start_of_the_day + 11.hours)

        expect(shift).not_to be_valid
        expect(shift.errors[:starts_at]).to include('maximum allowed work hours per day exceeded')
      end

      it 'sets error if is exceed in single shift' do
        shift = house.shifts.new(employee: first_employee, starts_at: start_of_the_day, ends_at: start_of_the_day + 9.hours)

        expect(shift).not_to be_valid
        expect(shift.errors[:starts_at]).to include('maximum allowed work hours per day exceeded')
      end

      it 'does not set errors if shift is in multiple days and does not exceed single day limit' do
        house.shifts.create(employee: first_employee, starts_at: start_of_the_day, ends_at: start_of_the_day + 4.hours)
        shift = house.shifts.new(employee: first_employee, starts_at: start_of_the_day + 20.hours, ends_at: start_of_the_day + 26.hours)

        expect(shift).to be_valid
      end
    end

    describe 'check weekly hours limit' do
      let(:start_of_the_week) { DateTime.current.beginning_of_week }
      it 'sets error if exceeded' do
        5.times do |i|
          start_date = start_of_the_week.advance(days: i)
          house.shifts.create(employee: first_employee, starts_at: start_date, ends_at: start_date + 8.hours)
        end

        start_date = start_of_the_week.advance(days: 6)
        shift = house.shifts.new(employee: first_employee, starts_at: start_date, ends_at: start_date + 8.hours)

        expect(shift).not_to be_valid
        expect(shift.errors[:starts_at]).to include('maximum allowed work hours per week exceeded')
      end
    end
  end
end
