require 'spec_helper'
require 'crepe/application'
require 'stringio'
require 'pry'

describe Crepe::Application::Configuration do
  let(:config) { Crepe::Application::Configuration.new }

  before do
    config.foo = :bar
    config.bar = nil

    config.thin = false
    def config.thin?() true end

    config.time = Proc.new { Time.now }
  end

  it 'is initialized to use Crepe.logger' do
    expect(config.logger).to eq(Crepe.logger)
  end

  it 'returns values' do
    expect(config.foo).to eq(:bar)
  end

  it 'handles booleans' do
    expect(config.foo?).to eq(true)
    expect(config.bar?).to eq(false)
  end

  it 'allows method overrides' do
    expect(config.thin).to eq(false)
    expect(config.thin?).to eq(true)
  end

  it 'calls blocks' do
    expect(Time).to receive(:now).and_return('Hello, world!')
    expect(config.time).to eq('Hello, world!')
  end

  it 'warns about missing keys' do
    config.logger = Logger.new(log = StringIO.new)

    expect { config.missing }.to change { log.length }

    log.rewind

    expect(log.read).to include("warning: undefined setting `missing'")
  end
end
