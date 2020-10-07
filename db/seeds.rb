User.create!(name: 'バッハ',
  email: 'kitchen.number@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
  )

10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password,
                admin: false
                )
end

10.times do |n|
  name = "タスク#{n + 1}"
  content = "タスク内容#{n + 1}"
  status = rand(0..2)
  priority = rand(0..2)
  limit = Faker::Date.between(from: '2020-09-28', to: '2020-12-31')
  user_id = User.last.id
  Task.create!(name: name,
               content: content,
               status: status,
               limit: limit,
               priority: priority,
               user_id:  user_id
               )
end

10.times do |n|
  name = "ラベル#{n + 1}"
  Label.create!(name: name)
end