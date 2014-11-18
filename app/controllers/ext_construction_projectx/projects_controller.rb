require_dependency "ext_construction_projectx/application_controller"

module ExtConstructionProjectx
  class ProjectsController < ApplicationController
    before_filter :require_employee
    before_filter :load_parent_record

    def index
      @title = t('Projects')
      @projects =  params[:ext_construction_projectx_projects][:model_ar_r]
      @projects = @projects.where(:customer_id => @customer.id) if @customer
      @projects = @projects.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('project_index_view', 'ext_construction_projectx')
    end

    def new
      @title = t('New Project')
      @project = ExtConstructionProjectx::Project.new
      @erb_code = find_config_const('project_new_view', 'ext_construction_projectx')
      @js_erb_code = find_config_const('project_new_js_view', 'ext_construction_projectx')
    end


    def create
      @project = ExtConstructionProjectx::Project.new(params[:project], :as => :role_new)
      @project.last_updated_by_id = session[:user_id]
      if @project.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        flash[:notice] = t('Data Error. Not Saved!')
        @erb_code = find_config_const('project_new_view', 'ext_construction_projectx')
        @js_erb_code = find_config_const('project_new_js_view', 'ext_construction_projectx')
        @customer = ExtConstructionProjectx.customer_class.find_by_id(params[:project][:customer_id]) if params[:project].present? && params[:project][:customer_id].present?
        render 'new'
      end
    end

    def edit
      @title = t('Edit Project')
      @project = ExtConstructionProjectx::Project.find_by_id(params[:id])
      @erb_code = find_config_const('project_edit_view', 'ext_construction_projectx')
      @js_erb_code = find_config_const('project_edit_js_view', 'ext_construction_projectx')
    end

    def update
        @project = ExtConstructionProjectx::Project.find_by_id(params[:id])
        @project.last_updated_by_id = session[:user_id]
        if @project.update_attributes(params[:project], :as => :role_update)
          redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
        else
          flash[:notice] = t('Data Error. Not Updated!')
          @erb_code = find_config_const('project_edit_view', 'ext_construction_projectx')
          @js_erb_code = find_config_const('project_edit_js_view', 'ext_construction_projectx')
          render 'edit'
        end
    end

    def show
      @title = t('Project Info')
      @project = ExtConstructionProjectx::Project.find_by_id(params[:id])
      @erb_code = find_config_const('project_show_view', 'ext_construction_projectx')
    end
    
    protected
    def load_parent_record
      @customer = ExtConstructionProjectx.customer_class.find_by_id(params[:customer_id]) if params[:customer_id].present?
      @customer = ExtConstructionProjectx.customer_class.find_by_id(ExtConstructionProjectx::Project.find_by_id(params[:id]).customer_id) if params[:id].present?
    end
  end
end
