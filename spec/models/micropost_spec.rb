require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it "新規投稿を作成できること" do
    micropost = FactoryBot.build(:micropost, user: user)
    expect(micropost).to be_valid
  end

  it "titleが空欄の時" do
    micropost = FactoryBot.build(:micropost, user: user, title: nil)
    micropost.valid?
    expect(micropost.errors[:title]).to include("を入力してください")
  end

  it "contentが空欄の時" do
    micropost = FactoryBot.build(:micropost, user: user, content: nil)
    micropost.valid?
    expect(micropost.errors[:content]).to include("を入力してください")
  end

end
