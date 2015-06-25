require 'spec_helper'
require 'crepe/application'

describe Crepe::Application do
  let!(:app) { Class.new(Crepe::Application) }

  it 'has an instance' do
    expect(app).to eq(Crepe.application)
  end

  it 'does not override existing instances automatically' do
    expect { Class.new(Crepe::Application) }.not_to change { Crepe.application }
  end

  it 'can override the existing instance manually' do
    Crepe.application = Class.new(Crepe::Application)

    expect(Crepe.application).not_to eq(app)
  end

  it 'has a configuration' do
    expect(app.config).to be_a(Crepe::Application::Configuration)
  end

  describe 'initialize!' do
    it 'loads routes and an environment file based on Crepe.env' do
      environment_file = Crepe.root.join('config', 'environments', Crepe.env)
      routes_file      = Crepe.root.join('config', 'routes')
      expect(app).to receive(:require).with(environment_file)
      expect(app).to receive(:require).with(routes_file)

      app.initialize!
    end

    it 'loads initializers' do
      initializers = Crepe.root.join('config', 'initializers', '*.rb')

      expect(Dir).to receive(:[]).with(initializers).and_return(['file.rb'])
      allow(app).to  receive(:require)
      expect(app).to receive(:require).with('file.rb')

      app.initialize!
    end
  end

  after { Crepe.application = nil }
end
