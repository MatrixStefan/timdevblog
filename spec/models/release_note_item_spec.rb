require 'rails_helper'

RSpec.describe ReleaseNoteItem, type: :model do

  before(:each) do
    @user = FactoryBot.create(:user)
    @change_type = FactoryBot.create(:change_type)
    @release_note = FactoryBot.create(:release_note, user_id: @user.id)

  end

  it "is valid with change_type_id, change_title, change_details, user_id and release_note_id" do

    rni = ReleaseNoteItem.new(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: @change_type.id,
          user_id: @user.id,
          release_note_id: @release_note.id
    )

    expect(rni).to be_valid
  end

  it "is invalid without change_type" do

    rni = ReleaseNoteItem.new(
          change_title: "Change Title",
          change_details: "Change Details",
          user_id: @user.id,
          release_note_id: @release_note.id
    )

    rni.valid?
    expect(rni.errors[:change_type]).to include("can't be blank")
  end


  it "is invalid without change_title" do

    rni = ReleaseNoteItem.new(
          change_details: "Change Details",
          change_type_id: @change_type.id,
          user_id: @user.id,
          release_note_id: @release_note.id
    )

    rni.valid?
    expect(rni.errors[:change_title]).to include("can't be blank")
  end

  it "is invalid without change_details" do

    rni = ReleaseNoteItem.new(
          change_title: "Change Title",
          change_type_id: @change_type.id,
          user_id: @user.id,
          release_note_id: @release_note.id
    )

    rni.valid?
    expect(rni.errors[:change_details]).to include("can't be blank")
  end

  it "is invalid without user" do

    rni = ReleaseNoteItem.new(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: @change_type.id,
          release_note_id: @release_note.id
    )

    rni.valid?
    expect(rni.errors[:user]).to include("can't be blank")
  end

  it "is invalid without release_note" do

    rni = ReleaseNoteItem.new(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: @change_type.id,
          user_id: @user.id
    )

    rni.valid?
    expect(rni.errors[:release_note]).to include("can't be blank")
  end

  it "is invalid when change_type does not exist" do

    rni = ReleaseNoteItem.new(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: 0,
          user_id: @user.id,
          release_note_id: @release_note.id
    )

    rni.valid?
    expect(rni.errors[:change_type]).to include("must exist")
  end

  it "is invalid when release_note does not exist" do

    rni = ReleaseNoteItem.new(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: @change_type.id,
          user_id: @user.id,
          release_note_id: 0
    )

    rni.valid?
    expect(rni.errors[:release_note]).to include("must exist")
  end

  it "is invalid when the user does not exist" do

    rni = ReleaseNoteItem.new(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: @change_type.id,
          user_id: 0,
          release_note_id: @release_note.id
    )

    rni.valid?
    expect(rni.errors[:user]).to include("must exist")
  end

end
