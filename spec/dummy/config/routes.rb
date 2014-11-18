Rails.application.routes.draw do

  mount ExtConstructionProjectx::Engine => "/ext_construction_projectx"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  mount CustomerAuthentify::Engine => 'customer_login'
  mount Kustomerx::Engine => '/customer'
  mount Searchx::Engine => '/search'
  mount SimpleContractx::Engine => '/contract'
  mount PaymentRequestx::Engine => '/pr'
  mount BillOfMaterialx::Engine => '/BOM'
  mount StateMachineLogx::Engine => '/sm_log'
  mount BizWorkflowx::Engine => '/biz_wf'
  mount Supplierx::Engine => '/supplierx'
  mount Manufacturerx::Engine => '/mfg'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
