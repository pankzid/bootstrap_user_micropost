namespace :micropost do
	desc "populate micropost"
	task :populate => :environment do
		users = User.all(limit: 6)
		20.times do
			content = Faker::Lorem.sentence(5)
			users.each do |user|
				user.microposts.create!(content: content)
			end
		end
	end

	desc "populate microposts 2"
	task :populate2 => :environment do
		users = User.find((7..(User.count)).to_a)
		users.each do |user|
			20.times do
				content = Faker::Lorem.sentence(5)
				user.microposts.create!(content: content)
			end
		end
	end
end