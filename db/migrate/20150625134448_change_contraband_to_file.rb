class ChangeContrabandToFile < ActiveRecord::Migration
  def change
    rename_column :contrabands, :contraband_file_name, :upload_file_name
    rename_column :contrabands, :contraband_content_type, :upload_content_type
    rename_column :contrabands, :contraband_file_size, :upload_file_size
    rename_column :contrabands, :contraband_updated_at, :upload_updated_at
  end
end
