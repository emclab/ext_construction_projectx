require "ext_construction_projectx/engine"

module ExtConstructionProjectx
  mattr_accessor :customer_class, :show_customer_path, :index_contract_path, :contract_resource, :index_team_member_path, :team_member_resource,
                 :index_payment_request_path, :payment_request_resource, :index_bom_path, :bom_resource
  
  def self.customer_class
    @@customer_class.constantize
  end
end
