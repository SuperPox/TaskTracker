class Task < ApplicationRecord
    belongs_to :project
    belongs_to :user

    validates_presence_of :task_description, :priority
    scope(:priority_search, -> (priority) {self.where("priority >= ?", priority)})
    scope :top_priority, -> {where(priority: 1)}

    
end
