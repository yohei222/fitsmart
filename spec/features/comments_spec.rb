require 'rails_helper'

RSpec.feature "Comments", type: :feature do

  scenario "コメント投稿のテスト" do
    exercise = Exercise.create(name: "ベンチプレス")
    record = FactoryBot.create(:record, exercise_id: exercise.id)
    micropost = record.micropost
    user = micropost.user
    visit root_path
    sign_in_as(user)
    visit micropost_path(micropost)
    expect(page).to have_content micropost.title
    fill_in "comment_content", with: "コメントです！"
    click_button "投稿"
    expect(page).to have_content "コメントです！"
    expect(page).to have_content "コメントしました"
  end

end
