# frozen_string_literal: true

# This is message_Spec
require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'validations' do
    noti = FactoryBot.build(:notification)
    it 'is valid with valid attributes' do
      expect(noti).to be_valid
    end
  end
  describe 'associations' do
    it 'belongs to sender' do
      association = described_class.reflect_on_association(:sender)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end
    it 'belongs to recipient' do
      association = described_class.reflect_on_association(:recipient)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end
  end
end
