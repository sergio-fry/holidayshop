class Picture < ActiveRecord::Base
  attr_accessible :file
  belongs_to :gallery, :polymorphic => true

  has_attached_file :file, { :styles => {
    :large => ["300x300>", "jpeg"],
    :slider => ["220x170#", "jpeg"],
    :medium => ["150x150>", "jpeg"],
    :thumb => ["32x32>", :jpeg],
    :thumb2 => ["120x37#", :jpeg]
  }, :default_url => "/assets/missing.png" }.merge(Rails.env.production? ? { :storage => :s3, :s3_credentials => File.join(Rails.root, "config/amazon_s3.yml"), :bucket => "brand_monkeys_#{Rails.env}" } : {})
end
