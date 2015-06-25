require 'spec_helper'

describe 'routing' do
  describe 'GET /' do
    it 'responds with hello world' do
      expect(last_response.body).to eq('{"hello":"world"}')
    end
  end
end
