# it describes Oystercard behaviour
require 'station'
require 'journey'

class Oystercard

  attr_reader :balance, :journey_history, :current_journey

  MAX_BALANCE = 90
  MIN_BALANCE = 1.5

  def initialize(balance = 0)
    @balance = balance
    @current_journey = false
    @journey_history = []
  end

  def top_up(value)
    raise 'Maximum balance exceeded' if balance + value > MAX_BALANCE
    @balance += value
  end

  def touch_in(station)
    raise 'Insuficient balance' if balance < MIN_BALANCE
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    journey(station)
    deduct(@current_journey.fare)
    store_journey
  end

  def store_journey
    @journey_history << @current_journey
  end

  def journey(station)
    @current_journey = Journey.new if @current_journey == false
    @current_journey.ending_journey(station)
  end

  #private

  def deduct(value)
    @balance -= value
  end

end
