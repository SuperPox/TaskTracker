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
            @projects = Project.all
        end   
    end    
    
    
    def create
        @task = Task.create(task_params)
        @task.user = current_user
        if params[:project_id]
          @task.project_id = params[:project_id]
        end
        if @task.save
            redirect_to project_path(@task.project_id)
        else 
            #@errors = @task.errors.full_messages
            #redirect_to new_task_path
            @tasks = Task.all
            render :new
        end
    end    

    def update
    end

    def edit
        @task = Task.find_by(id: params[:id])
        if @task.task_status == nil
            @task.task_status = 2
        elsif @task.task_status == 1
            @task.task_status = 2
        else @task.task_status == 2
            @task.task_status = 1
        end
        @task.save!
        @user = current_user
        redirect_to user_path(@user)
    end
    
    private
    
    def task_params
        params.require(:task).permit(:task_description, :priority, :project_id, :assigned, :task_status, :user_id, :id)
    end

end
