User.create!(name:  "ようへい",
             email: "9oclockyohey@gmail.com",
             password:              "password",
             password_confirmation: "password",
             admin: true, sex: 0)

99.times do |n|
  name  = Faker::Name.name
  email = "user#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password, sex: 0)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content, title: "筋トレ大好き") }
end