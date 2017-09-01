class BaseApiController < ApplicationController
  
  before_action :check_tenant_api_key

  private

    def check_key
      params[:tenantkey].present?
    end

    # Check_tenant_api_key: Checks if Tenant API key is present or not
    def check_tenant_api_key

      # If key is not present or is not valid, return 401: Not Authorized
      if !check_key || !Tenant.exists?(api_key: params[:tenantkey])
        
        head(401)
        #redirect_to '/404.html'

      # If Tenant API Key exists
      elsif Tenant.exists?(api_key: params[:tenantkey])

        # Getting Tenant
        tenant = Tenant.where(['tenants.api_key = ?', params[:tenantkey]]).first

        # Create a new Tenantsrequest
        trequest = Tenantsrequest.new(:tenant_id => tenant.id)
        trequest.save

        # count teantsrequests per tenant api key
        @t = Tenant.left_outer_joins(:tenantsrequests)
          .distinct.select('tenants.id, COUNT(tenantsrequests.id) AS tcounter')
          .where(['tenants.api_key = ?', params[:tenantkey]])
          .group('tenants.id').first

      end
    end
  end