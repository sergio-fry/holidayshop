require 'spec_helper'

describe Catalog do
  before(:each) do
    @catalog = FactoryGirl.build(:catalog)
    @catalog.stub_chain(:file, :path).and_return(File.join(Rails.root, "spec/fixtures/catalog.xls" ))

    Product.delete_all
  end

  describe "#process!" do
    it "should create new products" do
      lambda do
        @catalog.process!
      end.should change(Product, :count)
    end

    it "should be sum of found products" do
      @catalog.process!.should eq(9)
    end

    it "should be called after create" do
      @catalog.should_receive(:process!)
      @catalog.save
    end
  end

  describe "#products_attrs" do
    it "should return non empty attributes" do
      @catalog.products_attrs.first.should be_present
    end
  end
end
