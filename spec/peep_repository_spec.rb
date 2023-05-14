#file: spec/peep_repository_spec.rb

require 'spec_helper'
require 'peep_repository'


RSpec.describe PeepRepository do
      
  before(:each)do
    reset_all_tables
  end
  
  it 'returns a list of users' do
    repo = PeepRepository.new
    peeps = repo.all

    expect(peeps.length).to eq(4)
    expect(peeps[0].id).to eq(1)
    expect(peeps[0].message).to eq('My name is Ken YoohaaaYoo.')
    expect(peeps[0].timestamp).to eq('2023-05-11 09:09:08')
    expect(peeps[1].id).to eq(2)
    expect(peeps[1].message).to eq('What a lovely peep.')
    expect(peeps[1].timestamp).to eq('2023-05-11 09:08:08')
  end

  it 'creates a new peep' do
    peep = Peep.new
    peep.message = ('What a lovely day!')
    peep.timestamp = peep.timestamp
    peep.user_id = (2)

    repo = PeepRepository.new
    repo.create(peep)
    peeps = repo.all

    expect(peeps[-1].id).to eq(5)
    expect(peeps[-1].message).to eq('What a lovely day!')
    expect(peeps[-1].timestamp).to eq peep.timestamp
    expect(peeps[-1].user_id).to eq(2)
  end

  it 'finds a peep by id' do
    repo = PeepRepository.new
    peep = repo.find_by_id(1)

    expect(peep.id).to eq(1)
    expect(peep.message).to eq('My name is Ken YoohaaaYoo.')
    expect(peep.timestamp).to eq peep.timestamp
    expect(peep.user_id).to eq(1)
  end
end