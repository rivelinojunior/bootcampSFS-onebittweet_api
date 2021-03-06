class User < ApplicationRecord
  mount_base64_uploader :photo, PhotoUploader
  has_secure_password
  validates_length_of :password,
                      maximum: 72,
                      minimum: 8,
                      allow_nil: true,
                      allow_blank: false

  validates_presence_of :name, :email

  acts_as_voter
  acts_as_followable
  acts_as_follower
  has_many :tweets, dependent: :destroy

  searchkick

  def search_data
    { name: name, email: email }
  end

  def timeline
    users_ids = [id] + (all_following.pluck(:id) || [])
    Tweet.where(user_id: users_ids).order(created_at: :desc)
  end
end
