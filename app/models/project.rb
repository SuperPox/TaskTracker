class Project < ApplicationRecord

    validates :name, presence: true, uniqueness: true
    validate :is_title_case
    before_validation :make_title_case

    has_many :tasks
    has_many :users, through: :tasks
  
    accepts_nested_attributes_for :tasks


    def is_title_case
        if self.name != self.name.titlecase
            self.errors.add(:name, "must be tilecase")
        end
    end
    
    def make_title_case
        self.name = self.name.titlecase
    end
end
