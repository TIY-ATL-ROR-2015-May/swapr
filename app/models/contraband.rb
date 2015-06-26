class Contraband < ActiveRecord::Base
  belongs_to :user
  belongs_to :curation

  validates :user_id, presence: true
  validates :curation_id, presence: true

  has_attached_file :upload
  validates_attachment :upload, presence: true,
    size: { in: 0..10.megabytes }
  do_not_validate_attachment_file_type :upload

  validates :upload_file_name, uniqueness: { scope: :curation_id }
  ## TODO: Make sure file name conflicts aren't possible.

  def name
    # Note that we have to be clever here and use "direct access"
    # to avoid a stack overflow from recursion.

    # Alternative would be to have this "virtual attribute" named
    # something other than name, or change the database column name.
    self[:name].blank? ? self[:upload_file_name] : self[:name]
  end
end
