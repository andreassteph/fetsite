 Fetsite::Application.routes.draw do
   themes_for_rails
   devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
   resources :home, :only=>[:index] do

   end
   #get 'home',:controller=>home,:action=>:index,:as=>"home_index"
   scope '(:locale)/admin' do
     resources :users, :only=>[]  do 
       collection do
         get :index
         post :all_update
       end
     end
     get 'users/:id/add_role/:role', :controller=>:users, :action=>:add_role, :as=>'user_add_role'
     get 'users/:id/do_confirm', :controller=>:users, :action=>:do_confirm, :as=>'user_do_confirm'
     get 'config',:controller=>:config,:action=>:index , :as => 'config'

   end

   devise_for :users , :controllers=>{:omniauth_callbacks=> "users/omniauth_callbacks"}
   scope '(:locale)' do 
     scope '(t/:theme)' do
      
       get "wiki/:name", action: :wiki, controller: :wikis
       resources :wikis do
         member do
           
         end
       end  
     end
      
   end
 
  #  end
 #  end
   scope ':locale' do
     scope '(t/:theme)' do
     # Studien 
    
     scope '(:ansicht)' do
       resources :studien, :only=>[:new,:edit,:update,:destroy,:show] do
           member do
             get :edit_lvas
           end
         end
       end
     
     resources :modulgruppen,:only =>[:create,:index] do
       end
     
     resources :studien,:except=>[:show,:new,:edit,:update,:destroy], :shallow=>true do 
       resources :modulgruppen, :path => "(:locale)/modulgruppen"
       
     end
     get 'verwalten/studien', :controller=>:studien, :action=>:verwalten, :as=>'studien_verwalten'
     
     resources :fetzneditions
     resources :galleries do
       collection do
         get 'verwalten'
       end
       resources :fotos
     end
     
     resources :gremien do 
       collection do 
         get 'verwalten'
       end
     end
     resources :fetprofiles do
       collection do 
         get 'verwalten'
         get 'internlist'
       end
       resources :memberships, :only => [:new, :edit, :update,:destroy,:create] 
     end
     resources :lecturers
     resources :semesters
     resources :moduls do
         member do
           get 'edit_lvas'
           post 'update_lvas'       
           get 'load_tiss'
           post 'show_tiss'
         end
         collection do
           get 'edit_bulk'
           get 'new_bulk'
           post 'update_bulk'
         end
         
     end
     resources :beispiele#, :only=>[:show,:index,:create]
     resources :lvas  do 
         member do
           get 'compare_tiss'
           get 'load_tiss'
         end
         resources :beispiele#, :only=>[:show,:index,:create]

     end 
     
     resources :fragen
     # get 'rubriken/verwalten', :controller=>:rubriken, :action=>:alle_verwalten, :as=>'alle_verwalten_rubrik'
     #resources :neuigkeiten, :except => [:index] do
    
     #end
     resources :neuigkeiten, :only =>[:show] 
      
     resources :rubriken do
       collection do 
         get 'verwalten' , :action => :alle_verwalten
         get 'intern'
       end
       member do
         get 'verwalten'
         put 'addmoderator'
         get 'removemoderator'
       end
       resources :neuigkeiten, :except => [:index] do 
         member do
           get 'publish'
           get 'unpublish'
           get 'add_calentry'
           get 'rm_calentry'
           get 'create_link'
           get 'find_link'
         end
       end
     end
     
     # put 'rubriken/(:id)/addmoderator',:controller=>:rubriken,:action=>:addmoderator
     # get 'rubriken/:id/verwalten',:controller=>:rubriken,:action=>:verwalten, :as=>'verwalten_rubrik'
     # get 'rubriken/verwalten',:controller=>:rubriken,:action=>:alle_verwalten, :as=>'rubriken_verwalten'
     
     resources :home, :only=>[:index] do
      get :search, :on=>:collection
         collection do
        get 'intern'   
         get 'dev'
         get 'startdev'
         get 'linksnotimplemented'
         get 'kontakt' 
       end
    end
    
     resources :themen do
         member do
           get :attachments
           get :fragen
           get :verwalten
         end
         resources :attachments
     end
	 
     resources :themengruppen do
       get :verwalten 
       get :verwalten_all,:on=>:collection
       get :faqs, :on=>:collection
       post :sort_themen
       post :sort_themengruppen, :on=>:collection
       resources :themen, :only=>[:new, :show]
     end
     
     resources :calendars
     get 'verwalten/calendars', :controller=>:calendars, :action=>:verwalten, :as=>'calendars_verwalten'
     
     resources :calentries
   end
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
 
