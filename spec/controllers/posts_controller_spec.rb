require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe '#create' do
    let(:post_obj) { build :post }
    let(:params) do
      {
        title: post_obj.title,
        content: post_obj.content,
        login: 'TestLogin'
      }
    end
    it 'create post and return it' do
      post :create, params: params
      expect(response.status).to eq 200
      created_post = Post.last
      expect(JSON.parse(response.body)).to eq('title' => created_post.title,
                                              'content' => created_post.content,
                                              'author_ip' => '0.0.0.0',
                                              'id' => created_post.id)
    end

    context 'when validation failed' do
      it do
        post :create, params: {}
        expect(response.status).to eq 422
        expect(response.body).to include('error')
      end
    end
  end
end
