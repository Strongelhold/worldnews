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

  describe '#index' do
    it do
      create_list :post, 10, :with_ratings
      get :index, params: { limit: 10 }
      expect(response.status).to eq 200
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0].keys.sort).to eq ['content', 'title']
    end
  end

  describe '#authors_with_same_ip' do
    it do
      authors_posts = create_list :post, 5, author_ip: '192.168.0.231'
      control_sample = [{ authors_posts[0][:author_ip] => authors_posts.map { |post| post.user.login } }]

      get :authors_with_same_ip
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response).to eq control_sample
    end
  end
end
