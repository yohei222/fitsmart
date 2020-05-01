require 'rails_helper'

RSpec.describe Micropost, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @exercise1 = Exercise.create(name: "スミスマシン")
    @exercise2 = Exercise.create(name: "ダンベル")
    @micropost = @user.microposts.build(title: "title", content: "content")
  end

  it "正常に投稿を作成できること" do
    expect(@micropost).to be_valid
  end

  it "titleが不足しているとき" do
    @micropost.title = ""
    expect(@micropost).to be_invalid
    expect(@micropost.errors[:title]).to include("を入力してください")
  end

  it "contentが不足しているとき" do
    @micropost.content = ""
    expect(@micropost).to be_invalid
    expect(@micropost.errors[:content]).to include("を入力してください")
  end

  context "recordsのテスト" do
    it "recordを保存できること" do
      @micropost.records.build(exercise_id: @exercise1.id, weight: 30, times: 5, sets: 3)
      expect(@micropost).to be_valid
    end

    describe "recordでカラムの値が不足していたとき" do

      it "recordsのエラー" do
        @micropost.records.build(exercise_id: @exercise1.id, weight: "", times: 5, sets: 3)
        expect(@micropost).to be_invalid
        expect(@micropost.errors[:"records.weight"]).to include("を入力してください")
      end

      it "recordsのエラー" do
        @micropost.records.build(exercise_id: @exercise1.id, weight: 20, times: "", sets: 3)
        expect(@micropost).to be_invalid
        expect(@micropost.errors[:"records.times"]).to include("を入力してください")
      end

      it "recordsのエラー" do
        @micropost.records.build(exercise_id: @exercise1.id, weight: 20, times: 3, sets: "")
        expect(@micropost).to be_invalid
        expect(@micropost.errors[:"records.sets"]).to include("を入力してください")
      end
    end
  end

end
