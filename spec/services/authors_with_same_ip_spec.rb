require 'rails_helper'

RSpec.describe AuthorsWithSameIp, type: :service do
  subject { AuthorsWithSameIp }

  describe '#call' do
    it 'returns user logins grouped by ip' do
      first_author_posts = create_list :post, 10, author_ip: '192.168.0.231'
      second_author_posts = create_list :post, 10, author_ip: '192.168.0.232'

      control_sample = [
        { first_author_posts[0][:author_ip] => first_author_posts.map { |post| post.user.login }.uniq },
        { second_author_posts[0][:author_ip] => second_author_posts.map { |post| post.user.login }.uniq }
      ]
      expect(subject.new.call).to eq control_sample
    end

    it 'returns empty array' do
      result = subject.new.call
      expect(result).to be_empty
      expect(result.class).to eq Array
    end
  end
end
