class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :tweet_hash_tags
  has_many :hash_tags, through: :tweet_hash_tags
  validates :post, presence: true
  


end
