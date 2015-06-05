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

  describe 'initialize!' do
    it 'loads an environment file based on Crepe.env' do
      environment_file = Crepe.root.join('config', 'environments', Crepe.env)
      expect(Crepe.application).to receive(:require).with(environment_file)

      Crepe.application.initialize!
    end

    it 'loads initializers' do
      initializers = Crepe.root.join('config', 'initializers', '*.rb')

      expect(Dir).to receive(:[]).with(initializers).and_return(['file.rb'])
      allow(Crepe.application).to  receive(:require)
      expect(Crepe.application).to receive(:require).with('file.rb')

      Crepe.application.initialize!
    end
  end
end
