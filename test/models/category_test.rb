require 'test_helper'
# requis pour tous les fichiers de test

# je défini ma classe de  qui se rapport a ma vraie classe Category
class CategoryTest < ActiveSupport::TestCase
    
    def setup
        @category = Category.new(name: "Sports")
    end
    # la fonction setup va permettre de lancer le code avant chaque test, ce qui fait qu'il
    # n'est pas nécessaire de déclarer ce qu'il y a dedans dans chaque tests
    
    test "category should be valid" do
        assert @category.valid?
    end
    
    test "name should be present" do
        @category.name = " "
        assert_not @category.valid?
        # assert_not affirme que la catégorie n'est pas valide
    end
      
    
    test "name should be unique" do
        @category.save
        # j'enregistre la catégorie que j'ai setup dans la db test et ensuite
        @category2 = Category.new(name: "Sports")
        # je recrée une categorie qui a le même nom que celle en db
        assert_not @category2.valid?
        # category2 n'est pas valide
    end
    
    test "name should not be too long" do
        @category.name = "a" * 26
        assert_not @category.valid?
    end
    
    test "name should not be too short" do
        @category.name = "a" * 2
        assert_not @category.valid?
    end
end