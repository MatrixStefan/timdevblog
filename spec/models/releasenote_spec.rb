require 'rails_helper'

RSpec.describe ReleaseNote, type: :model do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  it "is valid with a user_id, title and release date" do
    release_note = ReleaseNote.new(
        title: "Test Title",
        release_date: "23-05-2018",
        intro: "Intro text",
        outro: "Outro text",
        user_id: @user.id
    )
    expect(release_note).to be_valid
  end

  it "is valid without an intro" do
    release_note = ReleaseNote.new(
        title: "Test Title",
        release_date: "23-05-2018",
        outro: "Outro text",
        user_id: @user.id
    )
    expect(release_note).to be_valid
  end

  it "is valid without an outro" do
    release_note = ReleaseNote.new(
        title: "Test Title",
        release_date: "23-05-2018",
        intro: "Intro text",
        user_id: @user.id
    )
    expect(release_note).to be_valid
  end

  it "is invalid without a title" do
    release_note = ReleaseNote.new(
        release_date: "23-05-2018",
        intro: "Intro text",
        outro: "Outro text",
        user_id: @user.id
    )

    release_note.valid?
    expect(release_note.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a release date" do
    release_note = ReleaseNote.new(
        title: "Has no release date",
        intro: "Intro text",
        outro: "Outro text",
        user_id: @user.id
    )

    release_note.valid?
    expect(release_note.errors[:release_date]).to include("can't be blank")
  end

  it "is invalid without a user_id" do
    release_note = ReleaseNote.new(
        title: "Test Title",
        release_date: "23-05-2018",
        intro: "Intro text",
        outro: "Outro text"
    )
    release_note.valid?
    expect(release_note.errors[:user_id]).to include("can't be blank")
  end

  it "is invalid when a user with the given user id does not exist" do
    release_note = ReleaseNote.new(
        title: "Test Title",
        release_date: "23-05-2018",
        intro: "Intro text",
        outro: "Outro text",
        user_id: 0
    )
    release_note.valid?
    expect(release_note.errors[:user]).to include("must exist")

  end

  it "is valid without release_note_items" do
    @release_note = FactoryBot.create(:release_note, user_id: @user.id)

    expect(@release_note).to be_valid
  end

  it "is valid with one release_note_item" do
    @release_note = FactoryBot.create(:release_note, user_id: @user.id)
    @change_type = FactoryBot.create(:change_type)

    1.times do
      FactoryBot.create(:release_note_item, change_type_id: @change_type.id, user_id: @user.id, release_note_id: @release_note.id)
    end

    expect(@release_note).to be_valid
  end

  it "is valid with multiple release_note_items" do
    @release_note = FactoryBot.create(:release_note, user_id: @user.id)
    @change_type = FactoryBot.create(:change_type)

    rand(2..5).times do
      FactoryBot.create(:release_note_item, change_type_id: @change_type.id, user_id: @user.id, release_note_id: @release_note.id)
    end

    expect(@release_note).to be_valid
  end

end
