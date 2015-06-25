class Curation < ActiveRecord::Base
  belongs_to :user
  has_many :contrabands

  acts_as_tree order: 'name'

  validates :name, presence: true, uniqueness: {
    scope: :parent_id, message: "only one per folder"
  }
end
