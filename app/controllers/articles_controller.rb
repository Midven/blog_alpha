class ArticlesController < ApplicationController
   before_action :set_article, only: [:show, :edit, :update, :destroy]
   # Pour les méthode citée, avant qu'il ne se passe quoi que ce soit, j'utilise la méthode set_article
   # afin d'avoir un article, cela permet d'éviter de déclarer la méthode dans chaque méthode
   before_action :require_user, except: [:show, :index]
   # a l'inverse du only, ici j'applique la fonction  pour tout excepté pour shox et index
   before_action :require_same_user, only: [:edit, :update, :destroy]
   
   def show
   end
   
   def index
      @articles = Article.all
   end
   
   def new
      @article = Article.new
      # J'instancie un nouvel article au chargement de la page car elle a besoin d'un objet article pour fonctionner
   end
   
   # A VOIR : Je n'ai pas le retour des erreurs lorsque je fais un edit
   def edit
      # Je fais ça pour qu'il sache quel Article je veux modifier
   end

   def update

      # if @article.update(params.require(:article).permit(:title, :description))
      # vu que je devais passer :
      # params.require(:article).permit(:title, :description)
      # à la fois dans update et dans create, je l'ai passé dans une fonction et je l'appelle directement
      
      if @article.update(article_params)
         flash[:notice] = "Article was updated successfully"
         redirect_to @article
      else
         render 'edit'
         # sinon je réaffiche le formulaire d'édition re l'article
      end
   end
   
   def create
      # render plain: params[:article]
      @article = Article.new(article_params)
      # Cela signifie que je reqcuière la clé :article dans les paramètres et j'utilise les éléments :title et :description
      # pour créer une instance de l'objet article
      # render plain: @article.inspect # je vérifie si j'ai un objet article
      @article.user = current_user
      if @article.save
         flash[:notice] = "Article was created successfully."
         # redirect_to article_path(@article)
         redirect_to @article # on peut aussi faire un redirect plus rapide comme ça
         # Une fois que mon article est enregistré en DB, je suis redirigé vers la page de l'article créé
      else
         render 'new'
      end
   end
   
   def destroy
      @article.destroy
      redirect_to articles_path
   end
   
   private
   
   def set_article
      @article = Article.find(params[:id])
   end 
   
   def article_params
      params.require(:article).permit(:title, :description, category_ids: [])
      # je dois mettre un s à category_ids parce que je dois passer deux id ( table relationnelle )
   end
   
   def require_same_user
      if current_user != @article.user && !current_user.admin?
         flash[:alert] = "You can only edit or delete your own article"
         redirect_to @article
      end
   end
   
end