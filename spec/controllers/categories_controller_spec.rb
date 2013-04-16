require 'spec_helper'

describe CategoriesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      category = FactoryGirl.create(:category)
      get 'show', :id => category.id
      response.should be_success
      assigns(:category).should eq(category)
    end
  end

end
