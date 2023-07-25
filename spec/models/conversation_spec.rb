# frozen_string_literal: true

# This is conversation_Spec
require 'rails_helper'
# rubocop: disable Metrics/BlockLength
RSpec.describe Conversation, type: :model do
  conversation = FactoryBot.build(:conversation)
  sender = conversation.sender
  recipient = conversation.recipient
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(conversation).to be_valid
    end
  end

  describe 'associations' do
    it 'has many messages with dependent destroy' do
      association = described_class.reflect_on_association(:messages)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
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

  describe '#opposed_user' do
    it 'returns the recipient when given the sender' do
      opposed_user = conversation.opposed_user(sender)
      expect(opposed_user).to eq(recipient)
    end

    it 'returns the sender when given the recipient' do
      opposed_user = conversation.opposed_user(recipient)
      expect(opposed_user).to eq(sender)
    end
  end
  # rubocop: enable Metrics/BlockLength
end
