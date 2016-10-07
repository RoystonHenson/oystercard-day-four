require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }
  # let(:start_journey) { double :start_journey }
  # let(:end_journey) { double :end_journey }
  # let(:entry_station) { double :entry_station }
  # let(:journey_history) { double :journey_history }
  # let(:current_journey) { double(entry_station: nil, exit_station: nil) }

  it 'has a starting balance of 0' do
    oystercard.deduct(10)
    expect(oystercard.balance).to eq(0)
  end

  before :each do
    oystercard.top_up(10)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up balance' do
      top_up_value = 10
      expect { oystercard.top_up(top_up_value) }
        .to change { oystercard.balance }.by top_up_value
    end

    it 'enforces maximum balance' do
      error = 'Maximum balance exceeded'
      top_up_value = 125
      expect { oystercard.top_up(top_up_value) }.to raise_error error
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deducts balance' do
      deducted_value = Oystercard::MIN_CHARGE
      expect { oystercard.deduct(deducted_value) }
        .to change { oystercard.balance }.by(- deducted_value)
    end
  end

  describe '#touch_in' do

    it { is_expected. to respond_to(:touch_in) }

    it 'checks minimum balance' do
      oystercard.deduct(10)
      error = 'Insuficient balance'
      expect { oystercard.touch_in }.to raise_error error
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    it 'deducts balance when touching out' do
      deducted_value = 1.5
      expect { oystercard.touch_out }
        .to change { oystercard.balance }.by(- deducted_value)
    end
end

describe 'journey history' do
  it 'checks that journey history is empty when card is created' do
  expect(oystercard.journey_history).to eq []
end

  xit 'checks that touching in and out stores a journey' do
    oystercard.starting_journey('southwark')
    oystercard.ending_journey('aldgate')
    expect(oystercard.journey_history).to eq [{entry_station: 'southwark', exit_station: 'aldgate'}]
  end
end
end
