# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username) }

  it { is_expected.to have_many(:rooms) }

  describe 'authenticate' do
    let(:user) { FactoryBot.create(:user) }
    it 'work with correct user - pass' do
      expect(User.authenticate(user.username, 'secret')).to eq(user)
    end

    it 'fail with incorrect password' do
      expect(User.authenticate(user.username, 'asd')).to be_falsey
      expect(User.authenticate(user.username, nil)).to be_falsey
    end
  end
end
