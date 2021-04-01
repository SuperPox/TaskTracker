class TasksController < ApplicationController

    def index
        if params[:priority]
            @tasks = Task.priority_search(params[:priority])
        else
            @tasks = Task.all
        end
    end 
       
    def new
        if params[:project_id]
          @project = Project.find_by(id: params[:project_id])
          @task = @project.tasks.build
          @projects = Project.all
        else
          @task = Task.new
          @projects= Project.all
        end   
    end    
    
    
    def create
        @task = Task.create(task_params)
        @task.user = current_user
        if params[:project_id]
          @task.project_id = params[:project_id]
        end
        @task.save
        redirect_to projects_path
    end    
    
    private
    
    def task_params
        params.require(:task).permit(:description, :priority, :project_id)
    end
    
end
