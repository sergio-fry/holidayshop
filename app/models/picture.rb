class Picture < ActiveRecord::Base
  attr_accessible :file
  belongs_to :gallery, :polymorphic => true

  has_attached_file :file, { :styles => {
    :medium => ["500x500>", "jpeg"],
    :small => ["200x200>", "jpeg"],
    :thumb => ["32x32>", :jpeg],
  }, :default_url => "/assets/missing.png" }.merge(Rails.env.production? ? { :storage => :s3, :s3_credentials => File.join(Rails.root, "config/amazon_s3.yml"), :bucket => "#{Rails.application.class.to_s.underscore.parameterize}_#{Rails.env}" } : {})
end
