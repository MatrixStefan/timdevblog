require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid when not approved" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is valid when approved" do
    user = FactoryBot.build(:user, :is_approved)
    expect(user).to be_valid
  end
  
  it "is not dev by default" do
    expect(FactoryBot.build(:user, :is_approved)).to_not be_dev
  end

  it "can be made a dev" do
    expect(FactoryBot.build(:user, :is_approved, :is_dev)).to be_dev
  end

  it "is valid without dev priveleges" do
    user = FactoryBot.build(:user, :is_approved)
    expect(user).to be_valid
  end

  it "is valid with dev priveleges" do
    user = FactoryBot.build(:user, :is_approved, :is_dev)
    expect(user).to be_valid
  end

  it "is invalid without first_name" do
    user = FactoryBot.build(:user, :without_first_name)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without last_name" do
    user = FactoryBot.build(:user, :without_last_name)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without job_title" do
    user = FactoryBot.build(:user, :without_job_title)

    user.valid?
    expect(user.errors[:job_title]).to include("can't be blank")
  end

  it "is invalid without email" do
    user = FactoryBot.build(:user, :without_email)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "returns first name only when preferred_name is 0" do
    user = FactoryBot.build(:user, :preferred_name_test, :pref_name_0)
    expect(user.pref_name).to eq "Dwayne"
  end

  it "returns last name only when preferred_name is 1" do
    user = FactoryBot.build(:user, :preferred_name_test, :pref_name_1)
    expect(user.pref_name).to eq "Johnson"
  end

  it "returns nickname only when preferred_name is 2" do
    user = FactoryBot.build(:user, :preferred_name_test, :pref_name_2)
    expect(user.pref_name).to eq "The Rock"
  end

  it "returns name ('first_name last_name') when preferred_name is 3" do
    user = FactoryBot.build(:user, :preferred_name_test, :pref_name_3)
    expect(user.pref_name).to eq "Dwayne Johnson"
  end

  it "returns full name (first_name 'nickname' last_name) when preferred_name is 4" do
    user = FactoryBot.build(:user, :preferred_name_test, :pref_name_4)
    expect(user.pref_name).to eq 'Dwayne "The Rock" Johnson'
  end

  it "returns concat name (nickname first_name) when preferred_name is 5" do
    user = FactoryBot.build(:user, :preferred_name_test, :pref_name_5)
    expect(user.pref_name).to eq "The Rock Dwayne"
  end

  it "returns concat name (nickname last_name) when preferred_name is 6" do
    user = FactoryBot.build(:user, :preferred_name_test, :pref_name_6)
    expect(user.pref_name).to eq "The Rock Johnson"
  end

  it "returns concat name (first_name nickname) when preferred_name is 7" do
    user = FactoryBot.build(:user, :preferred_name_test, :pref_name_7)
    expect(user.pref_name).to eq "Dwayne The Rock"
  end

  it "returns concat name (last_name nickname) when preferred_name is 8" do
    user = FactoryBot.build(:user, :preferred_name_test, :pref_name_8)
    expect(user.pref_name).to eq "Johnson The Rock"
  end

  it "only returns dev user through the dev scope" do

    dev_user = FactoryBot.create(:user, :is_dev)
    non_dev_user = FactoryBot.create(:user, :is_not_dev)

    expect(User.dev).to include(dev_user)
    expect(User.dev).to_not include(non_dev_user)
  end

  it "only returns end users through the end_user scope" do

    dev_user = FactoryBot.create(:user, :is_dev)
    non_dev_user = FactoryBot.create(:user, :is_not_dev)

    expect(User.end_user).to include(non_dev_user)
    expect(User.end_user).to_not include(dev_user)
  end

  it "only returns approved users through the approved scope" do

    dev_user_good = FactoryBot.create(:user, :is_dev, :is_approved)
    dev_user_bad = FactoryBot.create(:user, :is_dev, :is_not_approved)
    non_dev_user_good = FactoryBot.create(:user, :is_not_dev, :is_approved)
    non_dev_user_bad = FactoryBot.create(:user, :is_not_dev, :is_not_approved)

    expect(User.approved).to include(dev_user_good, non_dev_user_good)
    expect(User.approved).to_not include(dev_user_bad, non_dev_user_bad)
  end

  it "only returns unapproved users through the not_approved scope" do

    dev_user_bad = FactoryBot.create(:user, :is_dev, :is_approved)
    dev_user_good = FactoryBot.create(:user, :is_dev, :is_not_approved)
    non_dev_user_bad = FactoryBot.create(:user, :is_not_dev, :is_approved)
    non_dev_user_good = FactoryBot.create(:user, :is_not_dev, :is_not_approved)

    expect(User.not_approved).to include(dev_user_good, non_dev_user_good)
    expect(User.not_approved).to_not include(dev_user_bad, non_dev_user_bad)
  end

end
