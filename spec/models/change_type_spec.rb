require 'rails_helper'

RSpec.describe ChangeType, type: :model do
  it "is valid with name, priority and icon" do
    change_type = FactoryBot.build(:change_type)
    expect(change_type).to be_valid
  end

  it "is invalid without a name" do
    change_type = FactoryBot.build(:change_type, :without_name)
    change_type.valid?
    expect(change_type.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an icon" do
    change_type = FactoryBot.build(:change_type, :without_icon)
    change_type.valid?
    expect(change_type.errors[:icon]).to include("can't be blank")
  end

  it "is invalid without a priority" do
    change_type = FactoryBot.build(:change_type, :without_priority)
    change_type.valid?
    expect(change_type.errors[:priority]).to include("can't be blank")
  end

  it "is invalid with a duplicate priority" do
    #change_type_1 = FactoryBot.create(:change_type, :bug_fix)

    change_type_2 = FactoryBot.build(:change_type, :bug_fix)

    change_type_2.valid?
    expect(change_type_2.errors[:priority]).to include("has already been taken")
  end
end
