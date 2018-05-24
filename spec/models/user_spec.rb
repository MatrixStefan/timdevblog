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

end
