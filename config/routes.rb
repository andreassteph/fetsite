 Fetsite::Application.routes.draw do
    
   devise_for :users
   resources :home, :only=>[:index]
   #get 'home',:controller=>home,:action=>:index,:as=>"home_index"
   scope '(:locale)/admin' do
     resources :users
     get 'config',:controller=>:config,:action=>:index , :as => 'config'
     get 'config/get_git_update',:controller=>:config,:action=>:get_git_update, :as=>'config_getgitupdate'
     get 'config/get_git_update',:controller=>:config,:action=>:get_git_update
   end

   devise_for :users

   resources :pages, :except => [:index] do
     member do
       post 'preview'
     end
   end
   get 'pages', :to =>'pages#show'
   scope '(:locale)' do
     
     resources :studien, :only=>[:new,:edit,:update,:destroy]
     scope '(:ansicht)' do
       resources :studien, :only=>[:show]
     end
     resources :modulgruppen,:only =>[:create,:index]

     resources :studien,:except=>[:show,:new,:edit,:update,:destroy], :shallow=>true do 
       resources :modulgruppen, :path => "(:locale)/modulgruppen"
       
     end
     get 'verwalten/studien', :controller=>:studien, :action=>:verwalten, :as=>'studien_verwalten'
     resources :semesters
     resources :moduls
     resources :lvas
     resources :neuigkeiten
     get 'rubriken/verwalten', :controller=>:rubriken, :action=>:alle_verwalten, :as=>'alle_verwalten_rubrik'

     resources :rubriken do
       resources :neuigkeiten, :only=>[:new, :show]
     end
     put 'rubriken/(:id)/addmoderator',:controller=>:rubriken,:action=>:addmoderator
     get 'rubriken/:id/verwalten',:controller=>:rubriken,:action=>:verwalten, :as=>'verwalten_rubrik'
     resources :home, :only=>[:index]
     get 'home/dev', :controller=>:home, :action=>:dev, :as=>'home_dev'
     resources :beispiele
 
  resources :calendars
  resources :calentries
   end

   # The priority is based upon order of creation:
   # first created -> highest priority.

   # Sample of regular route:
   #   match 'products/:id' => 'catalog#view'
   # Keep in mind you can assign values other than :controller and :action

   # Sample of named route:
   #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
   # This route can be invoked with purchase_url(:id => product.id)

   # Sample resource route (maps HTTP verbs to controller actions automatically):
   #   resources :products

   # Sample resource route with options:
   #   resources :products do
   #     member do
   #       get 'short'
   #       post 'toggle'
   #     end
   #
   #     collection do
   #       get 'sold'
   #     end
   #   end

   # Sample resource route with sub-resources:
   #   resources :products do
   #     resources :comments, :sales
   #     resource :seller
   #   end

   # Sample resource route with more complex sub-resources
   #   resources :products do
   #     resources :comments
   #     resources :sales do
   #       get 'recent', :on => :collection
   #     end
   #   end

   # Sample resource route within a namespace:
   #   namespace :admin do
   #     # Directs /admin/products/* to Admin::ProductsController
   #     # (app/controllers/admin/products_controller.rb)
   #     resources :products
   #   end

   # You can have the root of your site routed with "root"
   # just remember to delete public/index.html.

   root :to => 'home#index'

   # See how all your routes lay out with "rake routes"

   # This is a legacy wild controller route that's not recommended for RESTful applications.
   # Note: This route will make all actions in every controller accessible via GET requests.
   # match ':controller(/:action(/:id))(.:format)'
 end
