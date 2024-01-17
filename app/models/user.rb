class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validate :name, presence: true
  validate :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
