class Task < ApplicationRecord
    belongs_to :project
    belongs_to :user

    validates_presence_of :description, :priority
    scope(:priority_search, -> (priority) {self.where("priority >= ?", priority)})
end
