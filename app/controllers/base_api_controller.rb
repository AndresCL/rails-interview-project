class BaseApiController < ApplicationController
  
  # Defining a before action only for api/questions
  before_action :check_tenant_api_key, only: [:questions]

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

        # Getting Tenant by API Key
        tenant = Tenant.where(['tenants.api_key = ?', params[:tenantkey]]).first

        ######################
        # Throttle Middleware
        ######################

        # Total requests made for current date and tenant (count_requests: defined in model)
        ttlrequests = tenant.count_requests
        
        # Get last tenant request
        tenantrequest = 
          Tenantsrequest.where(['tenant_id = ?', tenant.id])
            .order('created_at desc').first

        # If request counter is greater than 100, throttle to 1 request per 10 seconds.
        if ttlrequests > 100
          
          # Time now UTC lower than last request saved + 10 seconds
          if Time.current.utc <= (tenantrequest.created_at + 10.seconds)
            head(503) # return Service Unavailable
          else
            # Create a new Tenantsrequest
            trequest = Tenantsrequest.new(:tenant_id => tenant.id)
            trequest.save
          end

        else
          # Create a new Tenantsrequest
          trequest = Tenantsrequest.new(:tenant_id => tenant.id)
          trequest.save
        end

      end
    end

  end