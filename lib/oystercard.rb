# it describes Oystercard behaviour
require 'station'
require 'journey'

class Oystercard
  attr_reader :balance, :max_balance, :min_balance, :entry_station, :exit_station, :journey_history, :current_journey
  MAX_BALANCE = 90
  MIN_BALANCE = 1.5
  MIN_CHARGE = 1.5
  PENALTY_FARE = 6

  def initialize(balance = 0, travel = false)
    @balance = balance
  end

  def top_up(top_up_value)
    raise 'Maximum balance exceeded' if balance + top_up_value > MAX_BALANCE
    @balance += top_up_value
  end

  def deduct(deducted_value)
    @balance -= deducted_value
  end

  def touch_out

    deduct(MIN_CHARGE)
    # Need to add code for checking if there is an exit station; if not
    #deduct penaly fare rather than minimum fare

  end

  def touch_in
    raise 'Insuficient balance' if balance < MIN_BALANCE
  end


end
