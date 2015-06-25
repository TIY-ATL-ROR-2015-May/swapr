class FoldersController < ApplicationController
  before_action :authenticate_with_token!

  def index
  end

  def show
  end

  def create
    parent_id = params[:parent_id]
    if parent_id
      parent = current_user.curations.find(parent_id)
    end

    # @folder = Curation.create(name: params[:name],
    #                           user: current_user)
    @folder = current_user.curations.new(name: params[:name])

    if @folder.save
      @folder.move_to_child_of(parent) if parent_id && parent
      render json: { folder: @folder }, status: :created
    else
      render json: { errors: @folder.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def delete
  end
end
