class Post < ActiveRecord::Base
  include ExternalMetadata

  # Use Parole
  acts_as_commentable

  # Use Emotions
  acts_as_emotive

  # Use FriendlyId
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Associations
  belongs_to :user

  # Validations
  validates :url, presence: true, http: true
  validates :title, presence: true
  validates_with PostValidator

  # Scopes
  scope :newest, lambda { order('created_at DESC') }
  scope :popular, lambda { select('*, (comments_count + like_emotions_count) AS score').order('score DESC') }
end
