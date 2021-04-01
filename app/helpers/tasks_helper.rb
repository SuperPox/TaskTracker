module TasksHelper
    def show_project_name(m, index)
      m.project.name if index
    end
  
    def form_url_helper(project)
      project ? project_tasks_path(project) : tasks_path
    end
end
