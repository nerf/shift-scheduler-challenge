class Shift < ActiveRecord::Base
  MAXIMUM_HOURS_PER_DAY = 8
  MAXIMUM_HOURS_PER_WEEK = 40

  belongs_to :house
  belongs_to :employee
  # TODO: check if start time is after 7am and ends before 3am
  validate :check_for_overlaps, :check_hours_exceed_per_day, :check_hours_exceed_per_week

  def duration
    (ends_at.to_i - starts_at.to_i) / 60
  end

  private

  def check_for_overlaps
    if find_overlaps(starts_at, ends_at).any?
      errors.add(:starts_at, 'selected dates overlaps with another shift')
    end
  end

  def check_hours_exceed_per_day
    beginning_of_day = DateTime.current.beginning_of_day
    end_of_day = DateTime.current.end_of_day
    hours_today = 0

    (find_overlaps(beginning_of_day, end_of_day) + [self]).each do |shift|
      starts = shift.starts_at < beginning_of_day ? beginning_of_day : shift.starts_at
      ends = shift.ends_at > end_of_day ? end_of_day : shift.ends_at

      hours_today += duration_in_hours(starts, ends)
    end

    if hours_today > MAXIMUM_HOURS_PER_DAY
      errors.add(:starts_at, 'maximum allowed work hours per day exceeded')
    end
  end

  def check_hours_exceed_per_week
    beginning_of_week = DateTime.current.beginning_of_week
    end_of_week = DateTime.current.end_of_week
    hours_this_week = 0

    (find_overlaps(beginning_of_week, end_of_week) + [self]).each do |shift|
      starts = shift.starts_at < beginning_of_week ? beginning_of_week : shift.starts_at
      ends = shift.ends_at > end_of_week ? end_of_week : shift.ends_at

      hours_this_week += duration_in_hours(starts, ends)
    end

    if hours_this_week > MAXIMUM_HOURS_PER_WEEK
      errors.add(:starts_at, 'maximum allowed work hours per week exceeded')
    end
  end

  def find_overlaps(starts, ends)
    house.shifts.where('MAX(starts_at, ?) < MIN(ends_at, ?)', starts, ends)
  end

  def duration_in_hours(from, to)
    (to.to_i - from.to_i) / 60 / 60
  end
end
