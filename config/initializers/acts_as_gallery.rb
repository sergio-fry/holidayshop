require 'active_record'

module ActsAsGallery
  extend ActiveSupport::Concern

  included do
    def self.acts_as_gallery
      has_many :pictures, :as => :gallery, :dependent => :destroy
      accepts_nested_attributes_for :pictures, :reject_if => :all_blank, :allow_destroy => true
    end
  end
end

class ActiveRecord::Base
  include ActsAsGallery
end
