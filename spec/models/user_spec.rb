require 'rails_helper'

RSpec.describe User, type: :model do

  it "userが正しく作成されること" do
    @user = FactoryBot.build(:user)
    expect(@user).to be_valid
  end

  context '何か不足している時はエラーになること' do
    it "emailがnilの時" do
      @user = FactoryBot.build(:user)
      @user.email = nil
      expect(@user).to be_invalid
      expect(@user.errors[:email]).to include("を入力してください")
    end

    it "emailがinvalidとき" do
      @user = FactoryBot.build(:user)
      @user.email = "aaaaiiiiiuuuuuuuu"
      expect(@user).to be_invalid
      expect(@user.errors[:email]).to include("は不正な値です")
    end

    it "emailが重複しているとき" do
      @user2 = FactoryBot.create(:user_email)
      @user = FactoryBot.build(:user_email)
      expect(@user).to be_invalid
      expect(@user.errors[:email]).to include("はすでに存在します")
    end

    it "passwordがnilの時" do
      @user = FactoryBot.build(:user)
      @user.password = nil
      expect(@user).to be_invalid
      expect(@user.errors[:password]).to include("を入力してください")
    end

    it "passwordが一致しないとき" do
      @user = FactoryBot.build(:user)
      @user.password_confirmation = "incorrect"
      expect(@user).to be_invalid
      expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  end
end
