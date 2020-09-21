class IntercomSyncJob < ApplicationJob
  # Creates a user in intercom if it does not exist. If it does exist, it updates it
  def perform(user)
    # Creates the intercom client with that access token
    intercom = Intercom::Client.new(token: Rails.application.credentials.dig(:intercom, :api_token), handle_rate_limit: true)
    intercom_user = begin
      # tries to find user with this id
      intercom.contacts.find(id: user.metadata.dig('intercom_user_id')) if user.metadata&.dig('intercom_user_id').present?
      contacts = intercom.contacts.search(
        "query": {
          "field": 'external_id',
          "operator": '=',
          "value": user.id.to_s
        }
      )
      raise Intercom::ResourceNotFound, "fake raise" unless contacts.count == 1
      contacts.first
      # throws exception  
    rescue Intercom::ResourceNotFound
      # creates one with that user id
      intercom.contacts.create(external_id: user.id)
    end
    
    # We store intercom id and shopify metadata in our db
    metadata = { intercom_user_id: intercom_user.id }
    metadata = metadata.merge(shopify_data(user)) unless user.metadata&.dig('email').present?
    user.update metadata: metadata
  
    # Sometimes intercom knows time zone of user and we don’t so we use their information on the time zone
    #user_time_zone = intercom_user.try(:location_data).try(:timezone)
    #if user_time_zone.present?
    #  begin
        # Updates timezone to user
    #    Time.zone = user_time_zone
        # Saves timezone
    #    user.update! timezone: user_time_zone
    # rescue ArgumentError
    #    logger.error “Ignored invalid timezone #{user_time_zone}”
    #  end
    #end
  
    # Adds the teams the user belongs to, remove ones in intercom they no longer belong to as a user can be part of multiple teams on Upscope
    #intercom_user_companies_ids = intercom_user.companies.map(&:company_id)
    #user_teams_ids = user.teams.map(&:id)
    #intercom_user.companies = (intercom_user_companies_ids + user_teams_ids).uniq.map do |id|
    #{
    #  company_id: id,
    #  remove: !id.in?(user_teams_ids) || nil
    #}
    #end
  
  
    # Sometimes they sign up but we don’t have their name but sometimes we add it manually
    #if user.name?
    # If we have the name of the person in Upscope, set to intercom
    #intercom_user.name = user.name
    #elsif intercom_user.name.present? && intercom_user.name.length > 1 && !user.from_oauth?
    # If we have the name in intercom but not Upscope, update Upscope
    #user.update name: intercom_user.name
    #else
    ## Set intercom name to nil
    #intercom_user.name = nil
    #end
  
    # Grab phone number from intercom. If phone number is manually added to intercom, we grab it
    #if user.phone_number.nil? && intercom_user.phone.present? && !user.from_oauth?
    #user.update phone_number: intercom_user.phone
    #user.reload
    #end
  
    # Here we are updating Intercom from our records
    intercom_user.name = user.name
    #intercom_user.phone = user.phone_number
    intercom_user.created_at = user.created_at
  
    # Make sure that, in both intercom and our app, the last request is up to date
    #user.last_request_at = [user.last_request_at, intercom_user.last_request_at].compact.max
    #intercom_user.last_request_at = user.last_request_at
  
    # Add the custom attributes for that user to intercom, from our database
    intercom_user.email = user.metadata.dig('email') unless intercom_user.email.present?
    intercom_user.phone = user.metadata.dig('phone') unless intercom_user.phone.present?
    intercom_user.custom_attributes[:shop_owner] = user.metadata.dig('shop_owner') unless intercom_user.custom_attributes[:shop_owner].present?
    intercom_user.custom_attributes = intercom_user.custom_attributes.merge(user.custom_data)
  
    intercom.contacts.save(intercom_user)
  
    # Merge lead if exists. Sometimes there’s a lead in intercom which is not a user.If the user was created in the last 24 hours, it looks for a contact with the same email address and merges it.
    #if user.created_at > 24.hours.ago
    # Find lead
    #begin
    #  intercom_lead = intercom.contacts.find_all(email: user.email).first
    #  intercom.contacts.convert(intercom_lead, intercom_user) if intercom_lead
    #  logger.info ‘Merged contact into user’
    #rescue Intercom::ResourceNotFound
    #  nil
    #end
    #end
  
    #user.owned_teams.each do |team|
    #intercom_company = begin
    #           intercom.companies.find(company_id: team.id)
    #           rescue Intercom::ResourceNotFound
    #           intercom.companies.create(company_id: team.id)
    #           end
    #intercom_company.name = team.domain
    #intercom_company.created_at = team.created_at
    #intercom_company.monthly_spend = team.monthly_spend
    #intercom_company.custom_attributes = team.as_json(
    #  with_everything: true, except: [:created_at, :id, :_type]
    #).merge(deleted: false)
  
    #intercom.companies.save(intercom_company)
  
    #team.update metadata: { intercom_company_id: intercom_company.id }
    #end
  #ensure
  #  Time.zone = old_time_zone
  end

  private

  def shopify_data(shop)
    shop.with_shopify_session do
      @shop_data = ShopifyAPI::Shop.current
    end

    @shop_data.attributes.slice(:email, :shop_owner, :city, :country, :id, :phone, :address1, :address2, :zip)
  end
end