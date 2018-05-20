require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  describe '#create' do
    let(:post_obj) { create :post }
    it do
      post :create, params: { post_id: post_obj.id, rate: 4 }
      expect(response.status).to eq 200
      control_sample = { 'average_rate' => 4 }
      expect(JSON.parse(response.body)).to eq control_sample
    end

    context 'when value is incorrect' do
      it do
        post :create, params: { post_id: post_obj.id, rate: 6 }
        expect(response.status).to eq 422
        expect(response.body).to include 'error'
      end
    end
  end
end
