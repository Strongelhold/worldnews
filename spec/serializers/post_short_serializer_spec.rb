require 'rails_helper'

RSpec.describe PostShortSerializer, type: :serializer do
  subject { PostShortSerializer }

  describe 'serialized' do
    it do
      post = build :post
      control_sample = { title: post.title, content: post.content }
      expect(PostShortSerializer.new(post).to_hash).to eq control_sample
    end
  end
end
