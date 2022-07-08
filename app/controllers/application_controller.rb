class ApplicationController < ActionController::Base
    
    helper_method :current_user, :logged_in?
    # grace helper_method je stipule que la méthode current_user sera aussi disponible dans mon helper, pour mes vues
    
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
        # si nous avons déjà véfirié l'utilisateur dans la session alors nous renvoyonss @current_user ou 
        # si nous ne l'avons pas fait nous effectuons une requête dans la table des users pour le trouver puis on la renvoie
    end
    
     
    def logged_in?
    !!current_user
    # le double !! veut dire qu'il va renvoyer un boolen dans ce cas, y a t'il un user connecté ou non
    end
    
    def require_user
       if !logged_in?
        flash[:alert] = "You must be logged in to perform that action"
        redirect_to login_path
       end 
    end
    
end
