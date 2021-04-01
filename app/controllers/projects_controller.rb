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
    if @project.save
        redirect_to project_path(@project)
    else
        @errors = @project.errors.full_messages
        render :new
    end
  end

  def edit
  end

  def update
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
      params.require(:project).permit(:name, tasks_attributes: [:description, :priority])
    end

    def set_project
      @project = Project.find_by(id: params[:id])
    end


end
