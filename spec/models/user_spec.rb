require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid when not approved" do
    @user = FactoryBot.create(:user)
    expect(@user).to be_valid
  end

  it "is valid when approved" do
    @user = FactoryBot.create(:user, approved: true)
    expect(@user).to be_valid
  end

  it "is valid without dev priveleges" do
    @user = FactoryBot.create(:user, approved: true, dev: false)
    expect(@user).to be_valid
  end

  it "is valid with dev priveleges" do
    @user = FactoryBot.create(:user, approved: true, dev: true)
    expect(@user).to be_valid
  end

  it "is invalid without first_name" do
    @user = User.new(
        email: Faker::Internet.email,
        last_name: Faker::Name.last_name,
        job_title: Faker::Job.title,
        password: "password",
        password_confirmation: "password"
    )

    @user.valid?
    expect(@user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without last_name" do
    @user = User.new(
        email: Faker::Internet.email,
        first_name: Faker::Name.first_name,
        job_title: Faker::Job.title,
        password: "password",
        password_confirmation: "password"
    )

    @user.valid?
    expect(@user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without job_title" do
    @user = User.new(
        email: Faker::Internet.email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        password: "password",
        password_confirmation: "password"
    )

    @user.valid?
    expect(@user.errors[:job_title]).to include("can't be blank")
  end

  it "is invalid without email" do
    @user = User.new(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        job_title: Faker::Job.title,
        password: "password",
        password_confirmation: "password"
    )

    @user.valid?
    expect(@user.errors[:email]).to include("can't be blank")
  end

  it "returns first name only when preferred_name is 0" do
    user = User.new(
                   first_name: "Heraldo",
                   last_name: "Bookworm",
                   nickname: "Cheesemeister",
                   email: Faker::Internet.email,
                   job_title: "Tester",
                   password: "password",
                   password_confirmation: "password",
                   preferred_name: 0
    )

    expect(user.pref_name).to eq "Heraldo"
  end

  it "returns last name only when preferred_name is 1" do
    user = User.new(
                   first_name: "Heraldo",
                   last_name: "Bookworm",
                   nickname: "Cheesemeister",
                   email: Faker::Internet.email,
                   job_title: "Tester",
                   password: "password",
                   password_confirmation: "password",
                   preferred_name: 1
    )

    expect(user.pref_name).to eq "Bookworm"
  end

  it "returns nickname only when preferred_name is 2" do
    user = User.new(
                   first_name: "Heraldo",
                   last_name: "Bookworm",
                   nickname: "Cheesemeister",
                   email: Faker::Internet.email,
                   job_title: "Tester",
                   password: "password",
                   password_confirmation: "password",
                   preferred_name: 2
    )

    expect(user.pref_name).to eq "Cheesemeister"
  end

  it "returns name ('first_name last_name') when preferred_name is 3" do
    user = User.new(
                   first_name: "Heraldo",
                   last_name: "Bookworm",
                   nickname: "Cheesemeister",
                   email: Faker::Internet.email,
                   job_title: "Tester",
                   password: "password",
                   password_confirmation: "password",
                   preferred_name: 3
    )

    expect(user.pref_name).to eq "Heraldo Bookworm"
  end

  it "returns full name (first_name 'nickname' last_name) when preferred_name is 4" do
    user = User.new(
                   first_name: "Heraldo",
                   last_name: "Bookworm",
                   nickname: "Cheesemeister",
                   email: Faker::Internet.email,
                   job_title: "Tester",
                   password: "password",
                   password_confirmation: "password",
                   preferred_name: 4
    )

    expect(user.pref_name).to eq 'Heraldo "Cheesemeister" Bookworm'
  end

  it "returns concat name (nickname first_name) when preferred_name is 5" do
    user = User.new(
                   first_name: "Heraldo",
                   last_name: "Bookworm",
                   nickname: "Cheesemeister",
                   email: Faker::Internet.email,
                   job_title: "Tester",
                   password: "password",
                   password_confirmation: "password",
                   preferred_name: 5
    )

    expect(user.pref_name).to eq 'Cheesemeister Heraldo'
  end

  it "returns concat name (nickname last_name) when preferred_name is 6" do
    user = User.new(
                   first_name: "Heraldo",
                   last_name: "Bookworm",
                   nickname: "Cheesemeister",
                   email: Faker::Internet.email,
                   job_title: "Tester",
                   password: "password",
                   password_confirmation: "password",
                   preferred_name: 6
    )

    expect(user.pref_name).to eq 'Cheesemeister Bookworm'
  end

  it "returns concat name (first_name nickname) when preferred_name is 7" do
    user = User.new(
                   first_name: "Heraldo",
                   last_name: "Bookworm",
                   nickname: "Cheesemeister",
                   email: Faker::Internet.email,
                   job_title: "Tester",
                   password: "password",
                   password_confirmation: "password",
                   preferred_name: 7
    )

    expect(user.pref_name).to eq 'Heraldo Cheesemeister'
  end

  it "returns concat name (last_name nickname) when preferred_name is 8" do
    user = User.new(
                   first_name: "Heraldo",
                   last_name: "Bookworm",
                   nickname: "Cheesemeister",
                   email: Faker::Internet.email,
                   job_title: "Tester",
                   password: "password",
                   password_confirmation: "password",
                   preferred_name: 8
    )

    expect(user.pref_name).to eq 'Bookworm Cheesemeister'
  end

end
