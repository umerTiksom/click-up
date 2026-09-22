 puts "Creating Users...."
 puts ""
 user= 5.times.map do
   User.create(
     name: Faker::Name.name,
     email_address: Faker::Internet.unique.email,
     password: "Password1234!"
   )
 end
 puts""
 puts" Creating project..."
 projects = 10.times.map do
   Project.create(
     name: Faker::Company.unique.name,
     description: Faker::Lorem.paragraph,
     user_id: User.ids.sample
   )
 end
puts "creating task of each project"
puts ""
priority = %w[low medium high]
status = %w[in-progress pending completed]
Project.find_each do |project|
  10.times.map do
    Task.create(
      tittle: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      priority: priority.sample,
      status: status.sample,
      projects_id: project.id,
      assign_to_id: User.order("RANDOM()").ids.sample,
      user_id: project.user.id,
    )
  end
end