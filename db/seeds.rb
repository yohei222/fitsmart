User.create!(name:  "ようへい",
             email: "9oclockyohey@gmail.com",
             password:              "password",
             password_confirmation: "password",
             admin: true, sex: 0, status: 1)

User.create!(name:  "ゲストユーザー",
             email: "guest1234@gmail.com",
             password:              "password",
             password_confirmation: "password", admin: false, sex: 0, status: 1)

2.times do |n|
  name  = Faker::Name.name
  email = "user-public#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password, sex: 0, status: 1, admin: false)
end

2.times do |n|
  name  = Faker::Name.name
  email = "user-private#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password, sex: 1, status: 0, admin: false)
end

exercise_names = ["ベンチプレス", "ダンベルフライ", "ペックフライ", "ローイング", "ラットプルダウン", "スクワット", "レッグエクステンション", "レッグカール"]
exercise_names.each { |name| Exercise.create!(name: name) }
exercise_nums = [*1..8]
weight_candidates = [15,20,25,30,35,40,45,50]

users = User.order(:created_at).take(6)
10.times do |n|
  content = ["習慣","気持ち良い","疲れる","楽しい","自分との戦い","健康への道"]
  photos = ["./app/assets/images/man-slide1.jpg", "./app/assets/images/man-slide5.jpg", "./app/assets/images/slide5.jpg"]
  users.each do |user|
    user.microposts.create!(content: "筋トレは#{content.sample}！", title: "筋トレ#{n+1}日目だよ", picture: File.open("#{photos.sample}"))
  end
end

microposts = Micropost.all
microposts.each do |micropost|
  exercise_id = exercise_nums.sample
  exercise_id2 = exercise_nums.sample
  weight = weight_candidates.sample
  weight2 = weight_candidates.sample
  times = [7,10,12,15].sample
  times2 = [7,10,12,15].sample
  sets = [1,2,3,4,5].sample
  sets2 = [1,2,3,4,5].sample
  micropost.records.create!(exercise_id: exercise_id, weight: weight, times: times, sets: sets)
  micropost.records.create!(exercise_id: exercise_id2, weight: weight2, times: times2, sets: sets2)
end