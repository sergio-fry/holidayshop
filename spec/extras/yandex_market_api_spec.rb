# encoding: utf-8
require 'spec_helper'

describe YandexMarketApi do
  describe "#generate_yml" do
    it "should generate valid yml" do
      @category = FactoryGirl.create(:category)
      @product = FactoryGirl.create(:product, :category => @category)

      xml = YandexMarketApi.generate_yml
      xml.should be_present

      doc = Nokogiri.XML(xml)

      doc.root["date"].should eq(Time.now.strftime("%Y-%m-%d %H:%M"))
    end
  end

  describe "#utf8_to_cp1251" do
    it "should remove unsupported symbols" do
      YandexMarketApi.utf8_to_cp1251("☀").should eq("")
    end

    it "should convert cyrilic chars" do
      YandexMarketApi.utf8_to_cp1251("Праздник дества").encode("UTF-8").should eq("Праздник дества")
    end

    it "should not convert digits chars" do
      YandexMarketApi.utf8_to_cp1251("0123456789").should eq("0123456789")
    end
  end

  describe "#category_xml" do
    before do
      @category = FactoryGirl.create(:category)
    end

    it "should include category id" do
      Nokogiri.XML(YandexMarketApi.category_xml(@category)).root["id"].to_i.should eq(@category.id)
    end

    it "should include category title" do
      Nokogiri.XML(YandexMarketApi.category_xml(@category)).root.content.to_s.should eq(@category.title)
    end
  end

  describe "#product_xml" do
    before do
      @product = FactoryGirl.create(:product)
    end

    it "should include id" do
      Nokogiri.XML(YandexMarketApi.product_xml(@product)).root["id"].to_i.should eq(@product.id)
    end

    it "should remove CAPS from title" do
      @product.update_attributes!(:title => "Titlte with CAPS")
      name = Nokogiri.XML(YandexMarketApi.product_xml(@product)).xpath("//offer/name").text
      name.should_not include("CAPS")

      @product.update_attributes!(:title => "Titlte with ЗАГОЛОВОК")
      name = Nokogiri.XML(YandexMarketApi.product_xml(@product).encode("UTF-8")).xpath("//offer/name").text
      name.should_not include("ЗАГОЛОВОК")
    end

    it "should remove CAPS from description" do
      @product.update_attributes!(:description => "Description with CAPS")
      description = Nokogiri.XML(YandexMarketApi.product_xml(@product)).xpath("//offer/description").text
      description.should_not include("CAPS")

      @product.update_attributes!(:description => "Titlte with ЗАГОЛОВОК")
      description = Nokogiri.XML(YandexMarketApi.product_xml(@product).encode("UTF-8")).xpath("//offer/description").text
      description.should_not include("ЗАГОЛОВОК")
    end
  end
end
