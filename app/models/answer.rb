class Answer < ApplicationRecord
  paginates_per 3

  belongs_to :question, counter_cache: true
  belongs_to :user

  default_scope { order(created_at: :desc) }

  validates_length_of :body, minimum: 30
end
