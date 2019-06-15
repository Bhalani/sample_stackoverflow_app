class Question < ApplicationRecord
  include HasFriendlyId

  has_many :answers, dependent: :destroy
  belongs_to :user

  acts_as_taggable_on :tags
  validates :title, :description, presence: true
  validates_length_of :title, minimum: 15, maximum: 150, :allow_blank => true
  validates_length_of :description, minimum: 30, :allow_blank => true
end
