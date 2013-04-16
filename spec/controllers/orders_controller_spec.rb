require 'spec_helper'

describe OrdersController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      order = FactoryGirl.create(:order)
      get 'show', :id => order.uuid
      response.should be_success
      assigns(:order).should eq(order)
    end
  end

end
