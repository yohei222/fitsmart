require 'rails_helper'

RSpec.feature "Microposts", type: :feature do
  include LoginSupport

  scenario "ログインから新規投稿までの一連のテスト" do
    user = FactoryBot.create(:user)
    Exercise.create(name: "ベンチプレス")
    sign_in_as(user)
    expect {
      click_link "新規投稿"
      fill_in "タイトル", with: "タイトル"
      fill_in "振り返り", with: "振り返り"
      select 'ベンチプレス', from: 'micropost[records_attributes][0][exercise_id]'
      fill_in "重量", with: 15
      fill_in "回数", with: 15
      fill_in "セット数", with: 15
      click_button "新規投稿"
    }.to change(user.microposts, :count).by(1)

    new_micropost = Micropost.last
    expect(new_micropost.user_id).to eq(user.id)
    expect(new_micropost.title).to eq("タイトル")
    expect(new_micropost.content).to eq("振り返り")
    expect(new_micropost.records.count).to eq(1)
  end

  scenario "recordがnilの時" do
    user = FactoryBot.create(:user)
    Exercise.create(name: "ベンチプレス")
    sign_in_as(user)
    expect {
      click_link "新規投稿"
      fill_in "タイトル", with: "タイトル"
      fill_in "振り返り", with: "振り返り"
      click_button "新規投稿"
    }.to change(user.microposts, :count).by(0)
    expect(page).to have_content "トレーニング名を入力してください"
    expect(page).to have_content "重量を入力してください"
    expect(page).to have_content "回数を入力してください"
    expect(page).to have_content "セット数を入力してください"
  end

  scenario "投稿で全てがnilの時" do
    user = FactoryBot.create(:user)
    Exercise.create(name: "ベンチプレス")
    sign_in_as(user)
    expect {
      click_link "新規投稿"
      click_button "新規投稿"
    }.to change(user.microposts, :count).by(0)
    expect(page).to have_content "タイトルを入力してください"
    expect(page).to have_content "振り返りを入力してください"
    expect(page).to have_content "トレーニング名を入力してください"
    expect(page).to have_content "重量を入力してください"
    expect(page).to have_content "回数を入力してください"
    expect(page).to have_content "セット数を入力してください"
  end

end