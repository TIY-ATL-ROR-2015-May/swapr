class Curation < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :user
  has_many :contrabands, dependent: :destroy


  validates :name, presence: true, uniqueness: {
    scope: :parent_id, message: "only one per folder"
  }
end
