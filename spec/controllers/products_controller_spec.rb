require 'spec_helper'

describe ProductsController do

  describe "GET 'show'" do
    it "returns http success" do
      product = FactoryGirl.create(:product)
      get 'show', :id => product.id
      response.should be_success
      assigns(:product).should eq(product)
    end
  end

end
