class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable

  enum role: [:user, :admin]

  acts_as_tagger
  has_many :questions
  has_many :answers

  scope :non_admin, -> { where.not(:role => :admin) }
end
