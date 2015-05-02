module ExtConstructionProjectx
  class Project < ActiveRecord::Base
    after_initialize :default_init, :if => :new_record?
    attr_accessor :project_name, :customer_name, :last_updated_by_name, :status_name, :category_name, :awarded_noupdate, :completed_noupdate, :cancelled_noupdate,
                  :sales_name, :project_coordinator_name, :customer_name_autocomplete
=begin
    attr_accessible :awarded, :cancelled, :completed, :construction_address, :construction_finish_date, :construction_spec, :construction_start_date, :project_coordinator_id,
                    :customer_contact, :customer_id, :last_updated_by_id, :name, :note, :other_spec, :project_num, :status_id, :turn_over_date, :sales_id,
                    :turn_over_requirement, :category_id, :project_desp, :customer_name_autocomplete, :customer_name, :sales_name, :project_coordinator_name,
                    :as => :role_new
    attr_accessible :awarded, :cancelled, :completed, :construction_address, :construction_finish_date, :construction_spec, :construction_start_date, :sales_id,
                    :customer_contact, :customer_id, :last_updated_by_id, :name, :note, :other_spec, :project_num, :status_id, :turn_over_date, :project_coordinator_id,
                    :turn_over_requirement, :category_id, :project_desp, :customer_name_autocomplete, :last_updated_by_name, :sales_name, :project_coordinator_name,
                    :as => :role_update
    
    attr_accessor :project_id_s, :keyword_s, :start_date_s, :end_date_s, :customer_id_s, :status_s, :cancelled_s, :completed_s, :awarded_s, :sales_id_s, :project_coordinator_id_s,
                  :category_id_s, :time_frame_s

    attr_accessible :project_id_s, :keyword_s, :start_date_s, :end_date_s, :customer_id_s, :status_s, :cancelled_s, :completed_s, :sales_id_s, :project_coordinator_id_s,
                    :time_frame_s, :category_id_s, :awarded_s,  
                    :as => :role_search_stats
=end
    belongs_to :status, :class_name => 'Commonx::MiscDefinition'
    belongs_to :category, :class_name => 'Commonx::MiscDefinition'
    belongs_to :customer, :class_name => ExtConstructionProjectx.customer_class.to_s
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :sales, :class_name => 'Authentify::User'
    belongs_to :project_coordinator, :class_name => 'Authentify::User'
    
    validates :name, :presence => true,
                     :uniqueness => {:case_sensitive => false, :message => I18n.t('Duplicate Name!')}
    validates_presence_of :construction_address, :construction_spec  #, :project_num 
    validates :customer_id, :presence => true,
                            :numericality => {:greater_than => 0, :only_integer => true} 
    validates :sales_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'sales_id.present?'
    validates :project_coordinator_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'project_coordinator_id.present?'
    validates :status_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'status_id.present?'
    validates :category_id, :numericality => {:greater_than => 0, :only_integer => true}, :if => 'category_id.present?'
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate', 'ext_construction_projectx')
      eval(wf) if wf.present?
    end
    
    def default_init
      project_num_time_gen = Authentify::AuthentifyUtility.find_config_const('project_num_time_gen', 'ext_construction_projectx')
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
