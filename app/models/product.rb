# frozen_string_literal: true

# This is Product Model
class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  belongs_to :approved_by_user, class_name: 'User', foreign_key: :approved_by, optional: true
  belongs_to :rejected_by_user, class_name: 'User', foreign_key: :rejected_by, optional: true
  belongs_to :category
  belongs_to :sub_category

  has_many :reviews
  has_many_attached :images

  validates :title, presence: { message: 'Title can\'t be null' }
  validates :description, presence: { message: 'Description can\'t be null' }
  validates :phone_number, length: { minimum: 8, maximum: 10, message: 'Invalid phone number' },
                           presence: { message: 'Phone number can\'t be empty' },
                           numericality: { greater_than: 0, message: 'Enter valid phone number' }
  validates :user_name, presence: { message: 'Name can\'t be null' }
  validates :price, presence: { message: 'Price can\'t be null' },
                    numericality: { greater_than: 0, message: 'Enter valid price' }
  validate :positive_number_validation
  validates :category_id, presence: { message: 'Category can\'t be null' }
  validates :sub_category_id, presence: { message: 'Sub Category can\'t be null' }
  validates :location, presence: { message: 'Location can\'t be null' }
  validates :images, content_type: {
    in: ['image/png', 'image/jpg', 'image/jpeg'],
    message: 'must be a PNG, JPG, or JPEG image'
  }
  validates :images, size: { less_than: 1.megabytes, message: 'file size must be less than 1MB' }

  scope :approved_sellers, lambda { |id|
                             where.not(approved_by: nil).where(rejected_by: nil, role: 'Seller').where.not(user_id: id)
                           }
  scope :approved_buyers, lambda { |id|
                            where.not(approved_by: nil).where(rejected_by: nil, role: 'Buyer').where.not(user_id: id)
                          }
  scope :unapproved_sellers, -> { where(approved_by: nil, rejected_by: nil, role: 'Seller') }
  scope :unapproved_buyers, -> { where(approved_by: nil, rejected_by: nil, role: 'Buyer') }
  scope :rejected_sellers, -> { where(approved_by: nil, role: 'Seller').where.not(rejected_by: nil) }
  scope :rejected_buyers, -> { where(approved_by: nil, role: 'Buyer').where.not(rejected_by: nil) }
  scope :seller, -> { where(role: 'Seller', rejected_by: nil) }
  scope :buyer, -> { where(role: 'Buyer', rejected_by: nil) }

  def positive_number_validation
    return if price.blank?
    return if price.to_f.positive? && price[0].to_f.positive?

    errors.add(:price, 'Price Only Except Number no special character.')
  end

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
