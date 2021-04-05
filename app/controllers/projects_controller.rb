class ProjectsController < ApplicationController
  before_action(:set_project, except: [:index, :new, :create])
  before_action(:require_login)

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
    @project.project_creator = current_user.username
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
    @project.tasks.each {|m| m.task_status = params[:project][:task_status].to_i}
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
      params.require(:project).permit(:name, :project_description, tasks_attributes: [:task_description, :priority, :user_id, :id, :assigned, :task_status])
    end

    def set_project
      @project = Project.find_by(id: params[:id])
    end

    def checkbox_params
      params.require(:project).permit(tasks_attributes: [:task_status])
    end


end
