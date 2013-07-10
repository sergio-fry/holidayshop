class Page < ActiveRecord::Base
  validate :permalink, :presence => true, :uniqness => true
  validate :title, :presence => true
end
