require_dependency "ext_construction_projectx/application_controller"

module ExtConstructionProjectx
  class ProjectsController < ApplicationController
    before_action :require_employee
    before_action :load_parent_record
    after_action :info_logger, :except => [:new, :edit, :event_action_result, :wf_edit_result, :search_results, :stats_results, :acct_summary_result]

    def index
      @title = t('Projects')
      @projects =  params[:ext_construction_projectx_projects][:model_ar_r]
      @projects = @projects.where(:customer_id => @customer.id) if @customer
      @projects = @projects.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('project_index_view', session[:fort_token], 'ext_construction_projectx')
    end

    def new
      @title = t('New Project')
      @project = ExtConstructionProjectx::Project.new
      @erb_code = find_config_const('project_new_view', session[:fort_token], 'ext_construction_projectx')
      @js_erb_code = find_config_const('project_new_js_view', session[:fort_token], 'ext_construction_projectx')
    end


    def create
      @project = ExtConstructionProjectx::Project.new(new_params)
      @project.last_updated_by_id = session[:user_id]
      @project.fort_token = session[:fort_token]
      if @project.save
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
      else
        flash[:notice] = t('Data Error. Not Saved!')
        @erb_code = find_config_const('project_new_view', session[:fort_token], 'ext_construction_projectx')
        @js_erb_code = find_config_const('project_new_js_view', session[:fort_token], 'ext_construction_projectx')
        @customer = ExtConstructionProjectx.customer_class.find_by_id(params[:project][:customer_id]) if params[:project].present? && params[:project][:customer_id].present?
        render 'new'
      end
    end

    def edit
      @title = t('Edit Project')
      @project = ExtConstructionProjectx::Project.find_by_id(params[:id])
      @erb_code = find_config_const('project_edit_view', session[:fort_token], 'ext_construction_projectx')
      @js_erb_code = find_config_const('project_edit_js_view', session[:fort_token], 'ext_construction_projectx')
    end

    def update
        @project = ExtConstructionProjectx::Project.find_by_id(params[:id])
        @project.last_updated_by_id = session[:user_id]
        if @project.update_attributes(edit_params)
          redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
        else
          flash[:notice] = t('Data Error. Not Updated!')
          @erb_code = find_config_const('project_edit_view', session[:fort_token], 'ext_construction_projectx')
          @js_erb_code = find_config_const('project_edit_js_view', session[:fort_token], 'ext_construction_projectx')
          render 'edit'
        end
    end

    def show
      @title = t('Project Info')
      @project = ExtConstructionProjectx::Project.find_by_id(params[:id])
      @erb_code = find_config_const('project_show_view', session[:fort_token], 'ext_construction_projectx')
    end
    
    def destroy
      @project = ExtConstructionProjectx::Project.find_by_id(params[:id])
      @project.transaction do
        wf = find_config_const('project_delete_related', session[:fort_token], params[:controller])  #code for all deleting related records in, for ex, payment_requestx
        eval(wf) if wf.present?
        Commonx::Log.where("resource_id = ? AND resource_name = ? AND fort_token = ?", @project.id, params[:controller], session[:fort_token]).delete_all  #will trigger if error.
        @project.destroy
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Deleted!")
      end
    end
    
    protected
    def load_parent_record
      @customer = ExtConstructionProjectx.customer_class.find_by_id(params[:customer_id]) if params[:customer_id].present?
      @customer = ExtConstructionProjectx.customer_class.find_by_id(ExtConstructionProjectx::Project.find_by_id(params[:id]).customer_id) if params[:id].present?
    end
    
    private
    
    def new_params
      params.require(:project).permit(:awarded, :cancelled, :completed, :construction_address, :construction_finish_date, :construction_spec, :construction_start_date, :project_coordinator_id,
                    :customer_contact, :customer_id, :last_updated_by_id, :name, :note, :other_spec, :project_num, :status_id, :turn_over_date, :sales_id,
                    :turn_over_requirement, :category_id, :project_desp, :short_name)
    end
    
    def edit_params
      params.require(:project).permit(:awarded, :cancelled, :completed, :construction_address, :construction_finish_date, :construction_spec, :construction_start_date, :project_coordinator_id,
                    :customer_contact, :customer_id, :last_updated_by_id, :name, :note, :other_spec, :project_num, :status_id, :turn_over_date, :sales_id,
                    :turn_over_requirement, :category_id, :project_desp, :short_name)
    end
    
  end
end
