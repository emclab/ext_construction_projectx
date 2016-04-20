require 'rails_helper'

RSpec.describe "LinkTests", type: :request do
  describe "GET /ext_construction_projectx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link',
         'right-span#'         => '2', 
               'left-span#'         => '6', 
               'offset#'         => '2',
               'form-span#'         => '4'
        }
    before(:each) do
      @project_num_time_gen = FactoryGirl.create(:engine_config, :engine_name => 'ext_construction_projectx', :engine_version => nil, :argument_name => 'project_num_time_gen', :argument_value => ' ExtConstructionProjectx::Project.last.nil? ? (Time.now.strftime("%Y%m%d") + "-"  + 112233.to_s + "-" + rand(100..999).to_s) :  (Time.now.strftime("%Y%m%d") + "-"  + (ExtConstructionProjectx::Project.last.project_num.split("-")[-2].to_i + 555).to_s + "-" + rand(100..999).to_s)')
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      config_entry = FactoryGirl.create(:engine_config, :engine_name => 'rails_app', :engine_version => nil, :argument_name => 'SESSION_TIMEOUT_MINUTES', :argument_value => 30)
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'ext_construction_projectx_projects', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "ExtConstructionProjectx::Project.where(:cancelled => false).order('id')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'ext_construction_projectx_projects', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'ext_construction_projectx_projects', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "record.last_updated_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'ext_construction_projectx_projects', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'create_project', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      
      @cust = FactoryGirl.create(:kustomerx_customer)
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login'
      
    end
    it "works! (now write some real specs)" do
      qs = FactoryGirl.create(:ext_construction_projectx_project, :cancelled => false, :last_updated_by_id => @u.id, :customer_id => @cust.id)
      
      visit ext_construction_projectx.projects_path
      click_link qs.id.to_s
      expect(page).to have_content('Project Info')
      click_link 'New Log'
      expect(page).to have_content('Log')
      #save_and_open_page
      visit ext_construction_projectx.projects_path() 
      save_and_open_page
      click_link 'Edit'
      #save_and_open_page
      expect(page).to have_content('Edit Project')
      fill_in 'project_name', :with => 'new name'
      click_button 'Save'
      save_and_open_page
      #wrong data
      visit ext_construction_projectx.projects_path() 
      click_link 'Edit'
      expect(page).to have_content('Edit Project')
      fill_in 'project_name', :with => ''
      click_button 'Save'
      save_and_open_page
      
      visit ext_construction_projectx.projects_path(:customer_id => @cust.id)
      save_and_open_page
      expect(page).to have_content('Projects')
      click_link 'New Project'
      #save_and_open_page
      expect(page).to have_content('New Project')
      fill_in 'project_name', :with => 'new project'
      #fill_in 'project_customer_id', :with => @cust.id
      fill_in 'project_construction_address', :with => 'this is the address for the project'
      fill_in 'project_construction_spec', :with => 'this is the construction spec'
      click_button 'Save'
      save_and_open_page
      #wrong data
      visit ext_construction_projectx.projects_path(:customer_id => @cust.id)
      save_and_open_page
      expect(page).to have_content('Projects')
      click_link 'New Project'
      save_and_open_page
      expect(page).to have_content('New Project')
      fill_in 'project_name', :with => ''
      #fill_in 'project_customer_id', :with => @cust.id
      fill_in 'project_construction_address', :with => 'this is the address for the project'
      fill_in 'project_construction_spec', :with => 'this is the construction spec'
      click_button 'Save'
      save_and_open_page
    end
  end
end
