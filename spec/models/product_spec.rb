require 'spec_helper'

describe Product do
  describe "new product" do
    subject { FactoryGirl.build(:product, :origin_id => "foo") }

    context "origin_id = 'foo' is already taken" do
      before do
        Product.delete_all
        FactoryGirl.create(:product, :origin_id => "foo")
      end

      it { should_not be_valid }
    end
  end
end
