namespace :user do
	desc "populate users"
	task :populate => :environment do
		names = %w{takamina jurina renachan chihiron tomonaga fuchigami mikichan hikari yuikari kazumin}
		names.each do |name|
			User.create!(name: name, email: "#{name}@akb48.com", password: name, password_confirmation: name)
		end
	end
end