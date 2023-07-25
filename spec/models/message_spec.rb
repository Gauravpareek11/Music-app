# frozen_string_literal: true

# This is message_Spec
require 'rails_helper'
# rubocop: disable Metrics/BlockLength
RSpec.describe Message, type: :model do
  describe 'validations' do
    message = FactoryBot.build(:message)
    it 'is valid with valid attributes' do
      expect(message).to be_valid
    end

    it 'is not valid without a body' do
      message.body = nil
      expect(message).not_to be_valid
    end
  end
  describe 'associations' do
    it 'belongs to conversation' do
      association = described_class.reflect_on_association(:conversation)
      expect(association.macro).to eq(:belongs_to)
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

  describe 'scopes' do
    user = FactoryBot.build(:user)
    it 'returns unread messages where reciever is current user' do
      unread_messages_from_sender = Message.where(read: false).where.not(sender_id: user.id)

      expect(Message.unread_from_sender(user)).to match_array(unread_messages_from_sender)
    end
  end
end
# rubocop: enable Metrics/BlockLength
