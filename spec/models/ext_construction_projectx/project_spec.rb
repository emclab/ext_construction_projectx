require 'rails_helper'

module ExtConstructionProjectx
  RSpec.describe Project, type: :model do
    it "should be OK" do
      c = FactoryGirl.build(:ext_construction_projectx_project)
      expect(c).to be_valid
    end
    
    it "should reject nil customer_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :customer_id => nil)
      expect(c).not_to be_valid
   end
    
    it "should reject duplicate project name" do
      c0 = FactoryGirl.create(:ext_construction_projectx_project, :name => 'A name')
      c = FactoryGirl.build(:ext_construction_projectx_project, :name => 'a name')
      expect(c).not_to be_valid
    end
    
    it "should take duplicate project name for different token" do
      c0 = FactoryGirl.create(:ext_construction_projectx_project, :name => 'A name')
      c = FactoryGirl.build(:ext_construction_projectx_project, :name => 'a name', fort_token: 'newtoken')
      expect(c).to be_valid
    end
    
    it "should accept nil status_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :status_id => nil)
      expect(c).to be_valid
    end
    
    it "should reject 0 status_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :status_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should accept nil category_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :category_id => nil)
      expect(c).to be_valid
    end
    
    it "should reject 0 category_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :category_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should reject nil construction spec" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :construction_spec => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject nil construction address" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :construction_address => nil)
      expect(c).not_to be_valid
    end
    
    it "should take nil category_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :category_id => nil)
      expect(c).to be_valid
    end
    
    it "should reject 0 category_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :category_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should not be duplicate with short name" do
      c0 = FactoryGirl.create(:ext_construction_projectx_project, :short_name => 'A name')
      c = FactoryGirl.build(:ext_construction_projectx_project, :short_name => 'a name', :name => 'a new')
      expect(c).not_to be_valid
    end
    
    it "should take duplicate with short name for different token" do
      c0 = FactoryGirl.create(:ext_construction_projectx_project, :short_name => 'A name')
      c = FactoryGirl.build(:ext_construction_projectx_project, :short_name => 'a name', :name => 'a new', fort_token: 'newtoken')
      expect(c).to be_valid
    end
  end
end
