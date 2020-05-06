require 'rails_helper'

RSpec.describe Record, type: :model do
  let(:micropost) { FactoryBot.create(:micropost) }

  it "レコードを正しく作成できること" do
    record = FactoryBot.build(:record, micropost: micropost)
    expect(record).to be_valid
  end

  it "timesがnilの時" do
    record = FactoryBot.build(:record, micropost: micropost, times: nil)
    record.valid?
    expect(record.errors[:times]).to include("を入力してください")
  end

  it "weightがnilの時" do
    record = FactoryBot.build(:record, micropost: micropost, weight: nil)
    record.valid?
    expect(record.errors[:weight]).to include("を入力してください")
  end

  it "setsがnilの時" do
    record = FactoryBot.build(:record, micropost: micropost, sets: nil)
    record.valid?
    expect(record.errors[:sets]).to include("を入力してください")
  end

end
