class User < ApplicationRecord
    before_save { self.email = email.downcase }
    # avant de sauvegarder un utilisateur, il me met tout les caractères du mail en minuscule
    has_many :articles, dependent: :destroy
    # si un utilisateur est supprimé alors toutes les entités dépendantes ( comme un article ) sont supprimées aussi
   
    validates :username, presence:true, 
                        uniqueness: { case_sensitive: false }, 
                        length: {minimum:3, maximum:25}
                        
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :email, presence:true, 
                        uniqueness: { case_sensitive: false }, 
                        length: {maximum:105},
                        format: {with: VALID_EMAIL_REGEX}
                            
    has_secure_password
    
end