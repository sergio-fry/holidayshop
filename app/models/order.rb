class Order < ActiveRecord::Base
  belongs_to :product
  validates :phone, :presence => true
  validates :product, :presence => true

  before_create :generate_uuid
  after_commit :send_notification, :on => :create

  private

  def generate_uuid
    self.uuid = UUID.new.generate
  end

  def send_notification
    OrdersNotifier.new_order(self).deliver
  end
end
