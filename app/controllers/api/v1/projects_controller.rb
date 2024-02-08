class Api::V1::ProjectsController < Api::V1::BaseController
  before_action :set_project, only: [:show, :update, :destroy]

  def index
    @projects = Project.includes(:tasks).all
    render json: @projects, include: { tasks: { only: [:id, :name, :description, :status] } }
  end

  def show
    render json: @project, include: { tasks: { only: [:id, :name, :description, :status] } }
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: :created, location: api_v1_project_url(@project)
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    head :no_content
  end

  private

  def set_project
    @project = Project.includes(:tasks).find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :user_id)
  end
end
