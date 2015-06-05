require 'spec_helper'
require 'crepe/application'

describe Crepe::Application do
  before do
    Crepe::Application.new unless Crepe.application
  end

  it 'has an instance' do
    expect(Crepe.application).to be_a(Crepe::Application)
  end

  it 'does not override existing instances automatically' do
    expect { Crepe::Application.new }.not_to change { Crepe.application }
  end

  it 'can override the existing instance manually' do
    Crepe.application = app = Crepe::Application.new

    expect(Crepe.application).to eq(app)
  end

  it 'has a configuration' do
    expect(Crepe.application.config).to be_a(Crepe::Application::Configuration)
  end
end
