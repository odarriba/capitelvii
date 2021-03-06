Rails.application.routes.draw do

  devise_for :users, path: "admin"

  authenticate :user do
    mount Ckeditor::Engine => '/ckeditor'
  end

  namespace :admin do
    get "/" => "base#index"

    resources :galleries, except: [:show]

    resources :contact_requests, only: [:index, :show, :destroy]
    resources :pages, except: [:show]
    resources :users, except: [:show]
  end

  # Routes for contact requests
  get "/#{Rails.configuration.x.cms['routes']['contact_requests']}", to: 'contact_requests#new', as: :new_contact
  post "/#{Rails.configuration.x.cms['routes']['contact_requests']}", to: 'contact_requests#create'

  # Routes for galleries
  get "/#{Rails.configuration.x.cms['routes']['galleries']}/*slug", to: 'galleries#show', as: :gallery
  get "/#{Rails.configuration.x.cms['routes']['galleries']}", to: 'galleries#show'

  get "sitemap.xml", to: 'sitemaps#generate'

  # Routes for pages
  get '*slug', to: 'pages#show', as: :page
  root 'pages#show', defaults: { slug: "/" }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
