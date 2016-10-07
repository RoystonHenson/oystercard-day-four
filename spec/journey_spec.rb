require 'journey'
require 'oystercard'

describe Journey do
  subject(:journey) { Journey.new }
  let(:start_journey) { double :start_journey }
  let(:end_journey) { double :end_journey }
  let(:entry_station) { double :entry_station }
  let(:journey_history) { double :journey_history }
  let(:current_journey) { double(entry_station: nil, exit_station: nil) }
  let(:oystercard) { double :oystercard }

  before do
    oystercard = Oystercard.new
    oystercard.top_up(10)
  end

describe '#starting_journey' do

  it 'record entry station' do
    journey.starting_journey('southwark')
    expect(journey.entry_station).to eq 'southwark'
  end
end

describe '#ending_journey' do

end

describe '#in_journey?' do
  it { is_expected.to respond_to(:in_journey?) }
  it 'confirms that the customer is not on a journey' do
    expect(journey).not_to be_in_journey
  end
end



end
