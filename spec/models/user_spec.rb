require 'rails_helper'

RSpec.describe User, type: :model do

  it "ユーザーを新規作成できること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "emailがなければエラーになること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "passwordがなければエラーになること" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "passwordが一致しなければエラーになること" do
    user = FactoryBot.build(:user, password_confirmation: "invalid")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end

  it "重複したメールアドレスでは登録できないこと" do
    FactoryBot.create(:user, email: "duplicate@gmail.com")
    user = FactoryBot.build(:user, email: "duplicate@gmail.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

end
