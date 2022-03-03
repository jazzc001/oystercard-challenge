require_relative 'journey'
require_relative 'journeylog'

class OysterCard
  attr_reader :balance

  LIMIT = 90

  def initialize
    @balance = 0
    @journeylog = JourneyLog.new
  end

  def top_up(amount)
    limit_error(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    
    insufficient_balance_error
    @journeylog.start(entry_station)
  end

  def touch_out(exit_station)
    deduct(@journeylog.to_charge)
    @journeylog.finish(exit_station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def limit_error(amount)
    raise "Balance exceeds the limit of £#{LIMIT}" if @balance + amount >= LIMIT
  end

  def insufficient_balance_error
    raise "The balance is insufficient. Minimum amount of £#{Journey::MINIMUM_FARE} required." if @balance < Journey::MINIMUM_FARE
  end
end