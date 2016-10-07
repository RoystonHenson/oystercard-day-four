require 'station'
require 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station, :journey_history, :current_journey

  def initialize(travel = false)
    @journey_history = []
    @entry_station = nil
    @exit_station = nil
    @current_journey = {entry_station: nil, exit_station: nil}
    @travel = travel
  end

  def starting_journey(station)
    @entry_station = station
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
