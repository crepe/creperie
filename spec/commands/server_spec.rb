require 'spec_helper'
require 'creperie/cli'
require 'creperie/commands/server'

describe Creperie::Commands::Server do
  context 'outside of a Crêpe app' do
    it 'is not detected' do
      expect(Creperie::CLI.find_subcommand('server')).to be_nil
    end
  end

  context 'inside of a Crêpe app' do
    let(:server) { Creperie::Commands::Server.new(Dir.pwd, {}) }

    before do
      @original_pwd = Dir.pwd
      Dir.chdir(dummy)
    end

    it 'runs rackup with no arguments' do
      expect(Kernel).to receive(:exec).with(
        "bundle exec rackup -p 9292 -o 0.0.0.0 -E development #{dummy}/config.ru"
      )

      server.run([])
    end

    it 'takes a --server (or -s) option' do
      expect(Kernel).to receive(:exec).with(
        "bundle exec rackup -s puma -p 9292 -o 0.0.0.0 -E development #{dummy}/config.ru"
      ).twice

      server.run(['--server', 'puma'])
      server.run(['-s',       'puma'])
    end

    it 'takes a --host (or -o) option' do
      expect(Kernel).to receive(:exec).with(
        "bundle exec rackup -p 9292 -o localhost -E development #{dummy}/config.ru"
      ).twice

      server.run(['--host', 'localhost'])
      server.run(['-o',     'localhost'])
    end

    it 'takes a --port (or -p) option' do
      expect(Kernel).to receive(:exec).with(
        "bundle exec rackup -p 3000 -o 0.0.0.0 -E development #{dummy}/config.ru"
      ).twice

      server.run(['--port', '3000'])
      server.run(['-p',     '3000'])
    end

    it 'takes a --env (or -E) option' do
      expect(Kernel).to receive(:exec).with(
        "bundle exec rackup -p 9292 -o 0.0.0.0 -E production #{dummy}/config.ru"
      ).twice

      server.run(['--env', 'production'])
      server.run(['-E',    'production'])
    end

    it 'takes a --pid (or -P) option' do
      expect(Kernel).to receive(:exec).with(
        "bundle exec rackup -p 9292 -o 0.0.0.0 -E development -P tmp/crepe.pid #{dummy}/config.ru"
      ).twice

      server.run(['--pid', 'tmp/crepe.pid'])
      server.run(['-P',    'tmp/crepe.pid'])
    end

    it 'takes a --daemonize (or -D) option' do
      expect(Kernel).to receive(:exec).with(
        "bundle exec rackup -p 9292 -o 0.0.0.0 -E development -D #{dummy}/config.ru"
      ).twice

      server.run(['--daemonize'])
      server.run(['-D'])
    end

    it 'takes a --config (or -c) options' do
      expect(Kernel).to receive(:exec).with(
        "bundle exec rackup -p 9292 -o 0.0.0.0 -E development crepe.ru"
      ).twice

      server.run(['--config', 'crepe.ru'])
      server.run(['-c',       'crepe.ru'])
    end

    after do
      Dir.chdir(@original_pwd)
    end
  end
end
