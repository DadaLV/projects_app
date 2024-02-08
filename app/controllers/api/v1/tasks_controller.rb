class Api::V1::TasksController < Api::V1::BaseController
  before_action :set_project
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    tasks = cached_filtered_tasks(@project)
    render json: tasks, status: :ok
  end

  def show
    render json: @task
  end

  def create
    task = @project.tasks.build(task_params)

    if task.save
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :status)
  end

  def cached_filtered_tasks(project)
    Rails.cache.fetch("project_#{project.id}_tasks_#{params[:status]}", expires_in: 1.hour) do
      filtered_tasks(project)
    end
  end

  def filtered_tasks(project)
    tasks = project.tasks
    tasks = tasks.where(status: params[:status]) if params[:status].present?
    tasks
  end
end
