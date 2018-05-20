require 'rails_helper'

RSpec.describe PostSerializer, type: :serializer do
  subject { PostSerializer }

  describe 'serialized' do
    let(:post) { build :post }
    it do
      expect(subject.new(post).to_hash)
        .to eq(id: post.id, title: post.title, content: post.content, author_ip: post.author_ip)
    end
  end
end
