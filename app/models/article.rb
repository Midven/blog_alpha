class Article < ApplicationRecord

    validates :title, presence:true, length: {minimum: 6, maximum: 100}
    # Cela veut dire que je m'assure que le champ title soit bien rempli
    validates :description, presence:true, length: {minimum: 10, maximum: 300}
end