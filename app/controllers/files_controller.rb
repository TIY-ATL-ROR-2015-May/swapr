class FilesController < ApplicationController

  before_action :authenticate_with_token!

  def create
    @folder = Curation.find(params[:folder_id])
    @upload = @folder.contrabands.new(user: current_user,
                                      upload: params[:upload])

    if @upload.save
      render json: { file: @upload }, status: :ok
    else
      render json: { errors: @upload.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def show
  end

  def update
  end

  def delete
  end
end
