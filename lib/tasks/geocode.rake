namespace :geocode do
  desc "Geocode更新"
  task "update" => :environment do
    companies = Company.where(latitude:  nil)

      companies.each do |c|
        if (c.getAddress.blank?)
          next
        end
        p c.name
        p c.getAddress
        results = Geocoder.search(c.getAddress)
        c.update_attribute(:latitude,results.first.latitude)
        c.update_attribute(:longitude,results.first.longitude)

        p results.first.latitude
        p results.first.longitude
        p "---------------------"
      end
  end

end
