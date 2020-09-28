
10.times do |n|
  Task.create!(name: "Task-#{n}",
               content: "ghi",
               limit: '2020-09-30 12:00:00',
               status: rand(0..2),
               priority: rand(0..2),
)
end