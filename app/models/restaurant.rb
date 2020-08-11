class Restaurant < ApplicationRecord
    has_many :reviews, dependent: :destroy

    validates :name, :address, :category, presence: true
    validates :category, inclusion: { 
        # case_sensitive: false,
        in: ["chinese", "italian", "japanese", "french", "belgian"], 
        message: "%{value} is not a valid category" }

    before_validation :downcaseCategory, only: [:create]

    private

    def downcaseCategory
        self.category.downcase!
    end
    
end
