require 'rails_helper'

RSpec.describe CreatePost, type: :service do
  subject { CreatePost }

  describe '.call' do
    let(:user) { User.create(login: 'TestLogin') } # no need to use FactoryBot for now
    let(:params) do
      {
        title:     'TestTitle',
        content:   'Test content string',
        login:     'TestLogin',
        author_ip: '127.0.0.1'
      }
    end

    context 'when user exist' do
      it 'create post' do
        expect { subject.new(params).call }.to change { Post.count }.from(0).to(1)
      end
      it 'return created post' do
        expect(subject.new(params).call).to eq Post.last
      end
    end

    context 'when user does not exist' do
      before { params[:login] = 'AnotherTestLogin' }
      it { expect { subject.new(params).call }.to change { User.count }.from(0).to(1) }
    end

    context 'when title is blank' do
      before { params[:title] = '' }
      it { expect { subject.new(params).call }.to raise_error PostValidationError, PostValidationError::TITLE }
    end

    context 'when content is blank' do
      before { params[:content] = '' }
      it { expect { subject.new(params).call }.to raise_error PostValidationError, PostValidationError::CONTENT }
    end

    context 'when login is blank' do
      before { params[:login] = '' }
      it { expect { subject.new(params).call }.to raise_error PostValidationError, PostValidationError::LOGIN }
    end

    context 'when author_ip is blank' do
      before { params[:author_ip] = '' }
      it { expect { subject.new(params).call }.to raise_error PostValidationError, PostValidationError::AUTHOR_IP }
    end
  end
end
