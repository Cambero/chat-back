# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:content) }

  it { is_expected.to be_embedded_in(:room) }
end
