require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  
  setup do
    @admin_user = User.create(username:"johndoe", email:"johndoe@example.com", 
                              password: "password", admin: true)
    sign_in_as(@admin_user)
  end
  
  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name:"Sports"} }
      assert_response :redirect
    end
    follow_redirect!
    # une fois que la redirection arrive on veut voir ou elle nous mène
    assert_response :success
    # j'affirme la reponse success
    assert_match "Sports", response.body
    # je veux que le nom de la catégorie que je viens de créer apparaisse sur la page show
    # du coup si le mot "Sports" apparait sur la page c'est ok
  end
  
  
  test "get new category form and reject invalid category" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      # assert_no_difference parce que il y a rejet et donc pas d'augmentation du count
      post categories_path, params: { category: { name:" "} }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
    # le fait qu'il y ai le div.alert et le h.alert-heading indique que le message d'erreur est affiché
  end
  
end
