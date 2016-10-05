require 'station'
require 'oystercard'

class Journey

  attr_reader :balance, :entry_station, :exit_station, :journey_history, :current_journey

  def initialize(travel = false)
    @journey_history = []
    @current_journey = {entry_station: nil, exit_station: nil}
    @travel = travel
    @oystercard = Oystercard.new(@balance=0)

  end

  def starting_journey(start_journey)
    @current_journey[:entry_station] = start_journey
    @travel = true if @travel == false
  end

  def ending_journey(end_journey)
    @current_journey[:exit_station] = end_journey
    store_journey
    reset_journey
    @travel = false if @travel == true
  end

  def store_journey
    @journey_history << @current_journey
  end

  def journey_history
    @journey_history
  end

  def in_journey?
    !!entry_station
  end

  def reset_journey
    @entry_station = nil
    @exit_station = nil
  end

end
