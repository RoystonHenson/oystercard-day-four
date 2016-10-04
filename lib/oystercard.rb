# it describes Oystercard behaviour
class Oystercard
  attr_reader :balance, :max_balance, :min_balance, :entry_station, :exit_station, :journey_history
  MAX_BALANCE = 90
  MIN_BALANCE = 1.5
  MIN_CHARGE = 1.5

  def initialize(max_balance = MAX_BALANCE, min_balance = MIN_BALANCE, travel = false)
    @balance = 0
    @max_balance = max_balance
    @min_balance = min_balance
    @travel = travel
    @journey_history = []
    @current_journey = {entry_station: nil, exit_station: nil}
  end

  def top_up(top_up_value)
    raise 'Maximum balance exceeded' if balance + top_up_value > MAX_BALANCE
    @balance += top_up_value
  end

  def deduct(deducted_value)
    @balance -= deducted_value
  end

  def touch_in(start_journey)
    @entry_station = start_journey
    raise 'Insuficient balance' if balance < MIN_BALANCE
    @travel = true if @travel == false
  end

  def touch_out(end_journey)
    deduct(MIN_CHARGE)
    @exit_station = end_journey
    @entry_station = nil
    @travel = false if @travel == true
  end

  def store_journey(start_journey, end_journey)
    @journey_history << {
      entry_station: start_journey,
      exit_station: end_journey
    }
  end

  

  def in_journey?
    !!entry_station
  end
end
