module NotifyHelper
  def notify_service_link
    "https://www.notifications.service.gov.uk/services/022acc23-c40a-4077-bbd6-fc98b2155534"
  end

  def unregistered_user_template
    "#{notify_service_link}/templates/9ecac443-8cfd-49ac-ac59-e7ffa0ab6278"
  end

  def registered_user_template
    "#{notify_service_link}/templates/4da327dd-907a-4619-abe6-45f348bb2fa3"
  end
end
