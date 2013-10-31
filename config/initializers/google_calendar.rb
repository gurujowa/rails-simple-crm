module CrmApi
  class Config
      def self.load path
        loaded = YAML::load(File.open(path))
        yml = loaded[Rails.env]
        setting = {username: yml["username"], calendar: yml["calendar"], password: yml["password"], app_name: yml["app_name"]}
        @cal = Google::Calendar.new(setting)
      end

      def self.cal
        return @cal
      end

  end
  class Calendar
    def self.instance
      return Config.cal
    end
  end

end

CrmApi::Config.load("#{Rails.root}/config/shared/calendar.yml")
