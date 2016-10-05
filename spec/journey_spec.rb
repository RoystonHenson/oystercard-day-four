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
  it { is_expected. to respond_to(:starting_journey) }
  it 'changes the status of the card when touching in' do
    expect(journey.starting_journey(start_journey)).to be true
  end

  it 'record entry station' do
    journey.starting_journey('southwark')
    expect(journey.current_journey[:entry_station]).to eq 'southwark'
  end
end

describe '#ending_journey' do
  it { is_expected.to respond_to(:ending_journey) }

  it 'changes the status of the card when touching out' do
    journey.starting_journey(start_journey)
    expect(journey.ending_journey(end_journey)).to be false
  end
end

describe '#in_journey?' do
  it { is_expected.to respond_to(:in_journey?) }
  it 'confirms that the customer is not on a journey' do
    expect(journey).not_to be_in_journey
  end
end

describe 'journey history' do
  it 'checks that journey history is empty when card is created' do
  expect(journey.journey_history).to eq []
end

  it 'checks that touching in and out stores a journey' do
    journey.starting_journey('southwark')
    journey.ending_journey('aldgate')
    expect(journey.journey_history).to eq [{entry_station: 'southwark', exit_station: 'aldgate'}]
  end
end
end
