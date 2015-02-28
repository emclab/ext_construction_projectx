Rails.application.routes.draw do

  mount ExtConstructionProjectx::Engine => "/ext_construction_projectx"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  mount Kustomerx::Engine => '/customer'
  mount Searchx::Engine => '/search'
  mount SimpleContractx::Engine => '/contract'
  mount PaymentRequestx::Engine => '/pr'
  mount BillOfMaterialx::Engine => '/BOM'
  mount StateMachineLogx::Engine => '/sm_log'
  mount BizWorkflowx::Engine => '/biz_wf'
  mount Supplierx::Engine => '/supplierx'
  mount Manufacturerx::Engine => '/mfg'
  
  
  root :to => "authentify/sessions#new"
  get '/signin',  :to => 'authentify/sessions#new'
  get '/signout', :to => 'authentify/sessions#destroy'
  get '/user_menus', :to => 'user_menus#index'
  get '/view_handler', :to => 'authentify/application#view_handler'
end
