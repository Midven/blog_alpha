class PagesController < ApplicationController

    
    def home
        redirect_to articles_path if logged_in?
        # si je suis connecté je veux que ma homepage me redirige directement sur mes articles
    end


    def about
        
    end

end