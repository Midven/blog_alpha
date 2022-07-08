class SessionsController < ApplicationController
   
   def new
   end
   
   def create
       user = User.find_by(email: params[:session][:email].downcase)
    #   pour trouver l'user je vais dans les params de ce que j'ai passé dans le form, dans session,
    #   je me sers de l'email passé dans le form pour trouver l'user
    
    if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        # session est la méthode d'instance de session par laquelle je peux accéder a l'objet de session de l'utlisateur
        # je donne à l'user_id de la session l'id de l'utilisateur qui c'est connecté, il va le garder en mémoire le long de la session
        # c'est grâce à ça qu'il sera authentifié
        flash[:notice] = "logged in successfully"
        redirect_to user
    else
        flash.now[:alert] = "There was something wrong with your login details"
        # je fais un flash.now car je ne fais pas de redirect_to derrière, ce n'est pas une nouvelle page
        render 'new'
    end
        
   end
   
   def destroy
       session[:user_id] = nil
       flash[:notice] = "Logout"
       redirect_to root_path
   end
  
    
end