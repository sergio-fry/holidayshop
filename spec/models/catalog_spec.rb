require 'spec_helper'

describe Catalog do
  before(:each) do
    @catalog = FactoryGirl.build(:catalog)
    @catalog.stub_chain(:file, :path).and_return(File.join(Rails.root, "spec/fixtures/catalog.xls" ))

    Product.delete_all
  end

  it "should be called after create" do
    lambda do
      @catalog.save
    end.should change(Delayed::Job, :count).by(1)
  end

  context "is already saved" do
    before { @catalog.save! }

    describe "#process!" do
      context "real xls parsing" do
        before { Product.delete_all }

        it "should create new products" do
          lambda do
            @catalog.process!
          end.should change(Product, :count)
        end

        it "should be sum of found products" do
          @catalog.process!.should eq(9)
        end

        describe "#products_attrs" do
          it "should return non empty attributes" do
            @catalog.products_attrs.first.should be_present
          end
        end
      end

      context "products_attrs is stubbed" do
        before do
          @catalog.stub(:products_attrs) { (1..10).map{ |n| { :origin_id => n.to_s, :title => "Product ##{n}" } } }
        end
        before(:each) { Product.delete_all }

        describe "adding delayed job" do
          it "should add delayed job to process next batch if some left" do
            lambda do
              @catalog.process!(0, 5)
            end.should change(Delayed::Job, :count).by(1)
          end

          it "should not add delayed job if nothing left" do
            lambda do
              @catalog.process!(7, 5)
            end.should_not change(Delayed::Job, :count)
          end
        end

        it "should update existed product" do
          @product = FactoryGirl.create(:product, :origin_id => "1", :title => "Super Product")
          @catalog.process!(from=0, num=1)
          @product.reload.title.should eq("Product #1")
        end
      end
    end
  end
end
