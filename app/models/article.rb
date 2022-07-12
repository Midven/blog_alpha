class Article < ApplicationRecord
    belongs_to :user
    has_many :article_categories
    has_many :categories, through: :article_categories
    # un article a plusieurs catégories a travers la table article_categories

    validates :title, presence:true, 
                        length: {minimum: 6, maximum: 100}
    # Cela veut dire que je m'assure que le champ title soit bien rempli
    validates :description, presence:true, 
                        length: {minimum: 10, maximum: 300}
end