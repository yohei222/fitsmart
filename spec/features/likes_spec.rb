require 'rails_helper'

RSpec.feature "Likes", type: :feature do

  scenario "like,unlikeのテスト" do
    exercise = Exercise.create(name: "ベンチプレス")
    record = FactoryBot.create(:record, exercise_id: exercise.id)
    micropost = record.micropost
    user = micropost.user
    visit root_path
    sign_in_as(user)
    visit micropost_path(micropost)
    expect(page).to have_content micropost.title
    click_button 0
    expect(page).to have_content "1"
    click_button 1
    expect(page).to have_content "0"
  end
end
