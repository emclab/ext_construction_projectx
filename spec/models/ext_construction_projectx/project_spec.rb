require 'spec_helper'

module ExtConstructionProjectx
  describe Project do
    it "should be OK" do
      c = FactoryGirl.build(:ext_construction_projectx_project)
      c.should be_valid
    end
    
    it "should reject nil customer_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :customer_id => nil)
      c.should_not be_valid
   end
    
    it "should reject duplicate project name" do
      c0 = FactoryGirl.create(:ext_construction_projectx_project, :name => 'A name')
      c = FactoryGirl.build(:ext_construction_projectx_project, :name => 'a name')
      c.should_not be_valid
    end
    
    it "should accept nil status_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :status_id => nil)
      c.should be_valid
    end
    
    it "should reject 0 status_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :status_id => 0)
      c.should_not be_valid
    end
    
    it "should accept nil category_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :category_id => nil)
      c.should be_valid
    end
    
    it "should reject 0 category_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :category_id => 0)
      c.should_not be_valid
    end
    
    it "should reject nil construction spec" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :construction_spec => nil)
      c.should_not be_valid
    end
    
    it "should reject nil construction address" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :construction_address => nil)
      c.should_not be_valid
    end
    
    it "should take nil category_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :category_id => nil)
      c.should be_valid
    end
    
    it "should reject 0 category_id" do
      c = FactoryGirl.build(:ext_construction_projectx_project, :category_id => 0)
      c.should_not be_valid
    end
  end
end
