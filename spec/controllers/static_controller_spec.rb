require 'spec_helper'

describe StaticController do
  describe "#show" do
    it "should display static page when exists" do
      page = FactoryGirl.create(:page)
      get :show, :permalink => page.permalink
      response.should be_success
    end

    it "should display error when page not found" do
      get :show, :permalink => "unknown permalink"
      response.should_not be_success
    end
  end

end
