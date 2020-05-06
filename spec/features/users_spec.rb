require 'rails_helper'

RSpec.feature "Users", type: :feature do

  scenario "ユーザーの新規作成のテスト" do
    user = FactoryBot.build(:user)
    visit root_path
    click_link "今すぐサインアップ！", match: :first
    fill_in "ユーザーネーム", with: user.name
    fill_in "Eメール", with: user.email
    fill_in "exampleInputPassword1", with: user.password
    fill_in "user_password_confirmation", with: user.password
    click_button "アカウントを新規作成する"
    expect(page).to have_content "Fit Smartへようこそ！"
    new_user = User.last
    expect(new_user.name).to eq(user.name)
    expect(new_user.email).to eq(user.email)
  end

  scenario "ユーザーの編集のテスト" do
    visit root_path
    user = FactoryBot.create(:user)
    sign_in_as(user)
    visit edit_user_path(user)
    fill_in "ユーザーネーム", with: "new name"
    fill_in "Eメール", with: "newemail@gmail.com"
    find("input[name='user[sex]'][value='man']").set(true)
    click_button "アカウント情報を更新する"
    expect(page).to have_content "プロフィール情報が更新されました"
    expect(page).to have_content "new nameさんの投稿一覧"
    new_user = User.find_by(email: "newemail@gmail.com")
    expect(new_user.sex).to eq("man")
  end

  scenario "ログアウトのテスト" do
    visit root_path
    user = FactoryBot.create(:user)
    sign_in_as(user)
    click_link "ログアウト", match: :first
    expect(page).to have_content "ログイン"
  end

end
