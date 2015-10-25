ExtConstructionProjectx::Engine.routes.draw do

  resources :projects do
    collection do
      get :search
      get :search_results
      get :acct_summary
      get :acct_summary_result 
    end
  end
  
  root :to => 'projects#index'
end
