User.create!(name:  "ようへい",
             email: "9oclockyohey@gmail.com",
             password:              "password",
             password_confirmation: "password",
             admin: true, sex: 0, status: 1)

50.times do |n|
  name  = Faker::Name.name
  email = "user-public#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password, sex: 0, status: 1)
end

50.times do |n|
  name  = Faker::Name.name
  email = "user-private#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password, sex: 1, status: 0)
end

users = User.order(:created_at).take(6)
50.times do |n|
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content, title: "筋トレ#{n+1}だよ") }
end

exercise_names = ["ベンチプレス", "ダンベルフライ", "ペックフライ", "ローイング", "ラットプルダウン", "スクワット", "レッグエクステンション", "レッグカール"]
exercise_names.each { |name| Exercise.create!(name: name) }
