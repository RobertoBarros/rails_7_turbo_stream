class Product < ApplicationRecord
  belongs_to :buyer, class_name: 'User', optional: true
  belongs_to :user
  has_many :bids, dependent: :destroy

  after_create_commit { broadcast_prepend_to :products }
  after_update_commit { broadcast_update_to :products }
  after_destroy_commit { broadcast_remove_to :products }

  scope :in_auction, -> { where(buyer: nil) }
end
