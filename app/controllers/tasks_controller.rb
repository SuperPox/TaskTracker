class TasksController < ApplicationController

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
