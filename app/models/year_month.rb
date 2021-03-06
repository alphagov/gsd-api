class YearMonth
  class Serializer < ActiveRecord::Type::Value
    def type
      :year_month
    end

    def cast(value)
      value
    end

    def serialize(value)
      value = YearMonth.admin_value(value)
      value ? value.date : nil
    end

    def deserialize(value)
      case value
      when Date
        YearMonth.new(value.year, value.month)
      when String
        date = Date.parse(value)
        YearMonth.new(date.year, date.month)
      end
    end
  end

  include Comparable

  def initialize(year, month)
    @year = year.to_i
    @month = month.to_i
    @date = Date.new(@year, @month)
  end

  attr_reader :year, :month, :date

  def self.admin_value(value)
    if value.class == String
      d = Date.parse(value)
      YearMonth.new(d.year, d.month)
    else
      value
    end
  end

  def <=>(other)
    other = YearMonth.admin_value(other)
    (year <=> other.year).nonzero? || month <=> other.month
  end

  alias_method :eql?, :==

  def hash
    date.hash
  end

  def next
    if month == 12
      self.class.new(year + 1, 1)
    else
      self.class.new(year, month + 1)
    end
  end
  alias_method :succ, :next

  def day
    date.day
  end

  def starts_on
    date
  end

  def ends_on
    date.end_of_month
  end

  def to_s
    "#{date.strftime('%B')} #{date.year}"
  end

  def to_formatted_s(format = :long_day_month_year)
    if format == :long_day_month_year
      end_date = date.end_of_month
      "#{date.to_formatted_s(:day_excluding_leading_zero)} to #{end_date.to_formatted_s(:long_day_month_year)}"
    else
      date.to_formatted_s(format)
    end
  end
end
