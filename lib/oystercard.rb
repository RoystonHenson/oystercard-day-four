# it describes Oystercard behaviour
require 'station'
require 'journey'

class Oystercard

  attr_reader :balance, :journey_history

  MAX_BALANCE = 90
  MIN_BALANCE = 1.5
  MIN_CHARGE = 1.5
  PENALTY_FARE = 6

  def initialize(balance = 0)
    @balance = balance
    @current_journey = false
    @journey_history = []

  end

  def top_up(value)
    raise 'Maximum balance exceeded' if balance + value > MAX_BALANCE
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_out

    deduct(MIN_CHARGE)
    # Need to add code for checking if there is an exit station; if not
    #deduct penaly fare rather than minimum fare
    
  end

  def touch_in
    raise 'Insuficient balance' if balance < MIN_BALANCE
  end

  def journey_history
    @journey_history
  end

  def store_journey
    @journey_history << @current_journey
  end

end
