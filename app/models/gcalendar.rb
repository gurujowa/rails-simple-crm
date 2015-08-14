require 'google/api_client'


class Gcalendar
  def initialize
  @client = Google::APIClient.new(
    application_name: 'Example Ruby application',
    application_version: '1.0.0'
  )
  end


  def api
  @client.key = "AIzaSyAbWTPLX_TI2zJ2C4R-iAsj9_HMsiDgsL0"
  @client.authorization = nil

  result = @client.execute(
    api_method: @client.discovered_api(:plus).activities.list,
    parameters: { collection: "public", userId: 101748015513264110691 }
  )


  return result
  end
end
