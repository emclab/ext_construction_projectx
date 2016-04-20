module ExtConstructionProjectx
  class Project < ActiveRecord::Base
    after_initialize :default_init, :if => :new_record?
    attr_accessor :project_name, :customer_name, :last_updated_by_name, :status_name, :category_name, :awarded_noupdate, :completed_noupdate, :cancelled_noupdate,
                  :sales_name, :project_coordinator_name, :customer_name_autocomplete

    belongs_to :status, :class_name => 'Commonx::MiscDefinition'
    belongs_to :category, :class_name => 'Commonx::MiscDefinition'
    belongs_to :customer, :class_name => ExtConstructionProjectx.customer_class.to_s
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :sales, :class_name => 'Authentify::User'
    belongs_to :project_coordinator, :class_name => 'Authentify::User'
    
    validates :name, :presence => true,
                     :uniqueness => {:case_sensitive => false, :message => I18n.t('Duplicate Name!')}
    validates :short_name, :uniqueness => {:case_sensitive => false, :message => I18n.t('Duplicate Short Name!')}, :if => 'short_name.present?'
    validates :construction_address, :construction_spec, :presence => true  #, :project_num 
    validates :customer_id, :presence => true,
                            :numericality => {:greater_than => 0, :only_integer => true} 
    validates :sales_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'sales_id.present?'
    validates :project_coordinator_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'project_coordinator_id.present?'
    validates :status_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'status_id.present?'
    validates :category_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'category_id.present?'
    validate :dynamic_validate 
    
    default_scope {where(fort_token: Thread.current[:fort_token])}
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate', self.fort_token, 'ext_construction_projectx')
      eval(wf) if wf.present?
    end
    
    def default_init
      project_num_time_gen = Authentify::AuthentifyUtility.find_config_const('project_num_time_gen', self.fort_token, 'ext_construction_projectx')
      self.project_num = eval(project_num_time_gen) if project_num_time_gen.present?
    end
    
    def customer_name_autocomplete
      self.customer.try(:name)
    end

    def customer_name_autocomplete=(name)
      self.customer = ExtConstructionProjectx.customer_class.find_by_name(name) if name.present?
    end                         
  end
end
