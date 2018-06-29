class ResourcesController < ApplicationController
	before_action :authorize, except: :index
	before_action :set_resource, only: %i[show edit destroy update]

	def index
    @resources = Resource.all
	end

  def new
    @resource = Resource.new
  end

	def create
    @resource = Resource.new(resource_params)
    if @resource.save
      flash[:success] = 'Resource created successfully!'
      redirect_to resource_path(@resource)
    else
      flash[:danger] = @resource.errors.full_messages
      render :new
    end
	end

  def show; end

  def edit; end

	def update
		@resource.remove_image! if params[:resource][:remove_image] == true
    if @resource.update_attributes(resource_params)
      flash[:success] = 'Resource updated successfully!'
      redirect_to resource_path(@resource)
    else
      flash[:danger] = @resource.errors.full_messages
      render :edit
    end
	end

	def destroy
    if @resource.destroy
      flash[:success] = 'Resource removed successfully.'
    else
      flash[:danger] = @resource.errors.full_messages
    end
    redirect_to resources_path
	end

	private

	def set_resource
		@resource = Resource.find params[:id]
	end

	def resource_params
		params.require(:resource).permit(:title, :description, :link_name, :link_uri, :image)
	end
end
