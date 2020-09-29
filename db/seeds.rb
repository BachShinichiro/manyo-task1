
10.times do |n|
  Task.create!(name: "Task-#{n}",
               content: "ghi",
               limit: Faker::Date.between(from: '2020-09-28', to: '2020-12-31'),
               status: rand(0..2),
               priority: rand(0..2),
)
end