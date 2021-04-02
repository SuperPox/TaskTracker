class ProjectsController < ApplicationController
  before_action(:set_project, except: [:index, :new, :create])

  def index
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      @projects = user.projects
    else
      @projects = Project.all
    end
  end

  def show
  end

  def new
    @project = Project.new
    @project.tasks.build
  end

  def create
    @project = Project.new(project_params)
    @project.tasks.each {|m| m.user = current_user}
    if @project.save
        redirect_to project_path(@project)
        #redirect_to new_project_task_path(@project)
    else
        @errors = @project.errors.full_messages
        render :new
    end
  end

  def edit
    @tasks = @project.tasks.where(user_id: current_user.id)
  end

  def update
    @project.tasks.each {|m| m.user = current_user}
    if @project.update(project_params)
      redirect_to(project_path(@project))
    else
      @errors = @project.errors.full_messages
      render :edit
    end
  end


  def destroy
    @project.delete
    redirect_to projects_path
  end


  private

    def project_params
      params.require(:project).permit(:name, :project_description, tasks_attributes: [:task_description, :priority, :user_id, :id])
    end

    def set_project
      @project = Project.find_by(id: params[:id])
    end


end
