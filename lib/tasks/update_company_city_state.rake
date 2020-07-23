namespace :company do
  desc "Updates the city and state of the companies if zipcode is present."
  task :update_city_states => :environment do
    # Skip double callback running
    puts "Updating city and states"
    Company.skip_callback(:save, :before, :update_city_and_state)
    Company.find_each do |co|
      if co.zip_code.present? && (!co.city.present? || !co.city.present?)
        co.update_city_and_state
        co.save
      end
    end
    # Restore callback
    Company.set_callback(:save, :before, :update_city_and_state)
  end
end
