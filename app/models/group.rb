class Group < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :group_relationships
  has_many :members, through: :group_relationships, source: :user
  validates :title, presence: true
end
