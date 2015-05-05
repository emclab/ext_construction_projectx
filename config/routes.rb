ExtConstructionProjectx::Engine.routes.draw do

  resources :projects do
    collection do
      get :search
      get :search_results
    end
  end
  
  root :to => 'projects#index'
end
