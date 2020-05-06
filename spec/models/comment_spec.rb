require 'rails_helper'

RSpec.describe Comment, type: :model do
  # let(:micropost) { FactoryBot.create(:micropost) }
  # let(:user) { FactoryBot.create(:user) }

  it "コメントを正しく作成できること" do
    comment = FactoryBot.build(:comment)
    expect(comment).to be_valid
  end

  it "コメントがnilの時" do
    comment = FactoryBot.build(:comment, content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include("を入力してください")
  end

  it "コメントが20文字以上の時" do
    comment = FactoryBot.build(:comment, content: "a"*25)
    comment.valid?
    expect(comment.errors[:content]).to include("は20文字以内で入力してください")
  end

end
