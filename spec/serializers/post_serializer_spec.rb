require 'rails_helper'

RSpec.describe PostSerializer, type: :serializer do
  subject { PostSerializer }

  describe 'serialized' do
    let(:post) { build :post }
    it { expect(subject.new(post).to_hash).to eq(title: post.title, content: post.content, author_ip: post.author_ip) }
  end
end
