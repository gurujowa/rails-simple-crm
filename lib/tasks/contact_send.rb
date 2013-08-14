class Tasks::ContactSend
  def self.execute()
      puts "contact send start"
      beginning =  DateTime.now.yesterday.beginning_of_day.utc.to_s(:db)
      
      contacts = Contact.where("STRFTIME('%Y-%m-%d %H:%M:%S', created_at) > ?", beginning).all
      
      puts beginning
      ContactsMailer.welcome_email(@user).deliver
  end
end