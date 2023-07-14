# frozen_string_literal: true

# This is Product Model
class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  validates :title, presence: { message: "Title can't be null" }
  validates :description, presence: { message: "Description can't be null" }
  validates :phone_number, length: { minimum: 8, maximum: 10, message: 'Invalid phone number' },
                           presence: { message: "Phone number can't be empty" }
  validates :user_name, presence: { message: "Name can't be null" }
  validates :price, presence: { message: "Price can't be null" }
  validates :location, presence: { message: "Location can't be null" }
  belongs_to :user
  belongs_to :category
  belongs_to :sub_category
  has_many :reviews
  has_many_attached :images

  scope :approved_sellers, ->(id) { where.not(approved_by: nil).where(role: 'Seller').where.not(user_id: id) }
  scope :approved_buyers, ->(id) { where.not(approved_by: nil).where(role: 'Buyer').where.not(user_id: id) }
  scope :unapproved_sellers, -> { where(approved_by: nil, role: 'Seller') }
  scope :unapproved_buyers, -> { where(approved_by: nil, role: 'Buyer') }
  scope :seller, -> { where(role: 'Seller') }
  scope :buyer, -> { where(role: 'Buyer') }

  def self.index_data
    __elasticsearch__.create_index! force: true
    __elasticsearch__.import
  end
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :title, type: 'text'
      indexes :location, type: 'text'
      indexes :price, type: 'text'
      indexes :created_at, type: 'text'
      indexes :updated_at, type: 'text'
      indexes :sub_category_name, type: 'text'
      indexes :category_name, type: 'text'
      indexes :approved_by, type: 'keyword'
    end
  end
  # rubocop:disable Metrics/MethodLength,Style/HashSyntax
  def as_indexed_json(_options = {})
    {
      id: id,
      title: title,
      description: description,
      location: location,
      created_at: created_at,
      updated_at: updated_at,
      category_name: category.items,
      sub_category_name: sub_category.items,
      price: price,
      approved_by: approved_by
    }
  end

  def self.search_published(query)
    search({
             query: {
               bool: {
                 must: [
                   {
                     query_string: {
                       query: "*#{query}*",
                       fields: %i[title price location category_name sub_category_name]
                     }
                   }
                 ],
                 filter: [
                   {
                     exists: {
                       field: :approved_by
                     }
                   }
                 ]
               }
             }
           })
  end
  index_data
end
# rubocop:enable Metrics/MethodLength,Style/HashSyntax
