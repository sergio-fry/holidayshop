require 'spec_helper'

describe Catalog do
  before(:each) do
    @catalog = FactoryGirl.create(:catalog)
    @catalog.stub_chain(:file, :path).and_return(File.join(Rails.root, "spec/fixtures/catalog.xls" ))

    Product.delete_all
  end

  describe "#process!" do
    it "should create new products" do
      lambda do
        @catalog.process!
      end.should change(Product, :count).by(1)
    end
  end

  describe "#products_attrs" do
    it "should return non empty attributes" do
      p @catalog.products_attrs.grep(0..3)
      @catalog.products_attrs.first.should be_present
    end
  end
end
