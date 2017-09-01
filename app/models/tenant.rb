class Tenant < ApplicationRecord

  has_many :tenantsrequests

  before_create :generate_api_key
  
  def count_requests
    Tenantsrequest
      .where(['tenant_id = ? and created_at >= ?', self.id, Time.current.utc.beginning_of_day]).count
  end

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end

  

end
