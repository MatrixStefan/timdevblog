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

  it "only returns bug fix items through the bug_fix scope" do
    max_priority = ChangeType.all.map(&:priority).max
    newfeature_type = ChangeType.create(name: 'New Feature', icon: 'fa-sun', priority: max_priority+1)
    enhancement_type = ChangeType.create(name: 'Enhancement', icon: 'fa-thumbs-up', priority: max_priority+2)
    bug_type = ChangeType.create(name: 'Bug Fix', icon: 'fa-bug', priority: max_priority+3)

    rni_newfeature = ReleaseNoteItem.create(
        change_title: "Change Title",
        change_details: "Change Details",
        change_type_id: newfeature_type.id,
        user_id: @user.id,
        release_note_id: @release_note.id
    )
    rni_enhancement = ReleaseNoteItem.create(
        change_title: "Change Title",
        change_details: "Change Details",
        change_type_id: enhancement_type.id,
        user_id: @user.id,
        release_note_id: @release_note.id
    )
    rni_bugfix = ReleaseNoteItem.create(
        change_title: "Change Title",
        change_details: "Change Details",
        change_type_id: bug_type.id,
        user_id: @user.id,
        release_note_id: @release_note.id
    )

    expect(ReleaseNoteItem.bug_fix).to include(rni_bugfix)
    expect(ReleaseNoteItem.bug_fix).to_not include(rni_newfeature, rni_enhancement)
  end

  it "only returns enhancement items through the enhancement scope" do
    max_priority = ChangeType.all.map(&:priority).max
    newfeature_type = ChangeType.create(name: 'New Feature', icon: 'fa-sun', priority: max_priority+1)
    enhancement_type = ChangeType.create(name: 'Enhancement', icon: 'fa-thumbs-up', priority: max_priority+2)
    bug_type = ChangeType.create(name: 'Bug Fix', icon: 'fa-bug', priority: max_priority+3)

    rni_newfeature = ReleaseNoteItem.create(
        change_title: "Change Title",
        change_details: "Change Details",
        change_type_id: newfeature_type.id,
        user_id: @user.id,
        release_note_id: @release_note.id
    )
    rni_enhancement = ReleaseNoteItem.create(
        change_title: "Change Title",
        change_details: "Change Details",
        change_type_id: enhancement_type.id,
        user_id: @user.id,
        release_note_id: @release_note.id
    )
    rni_bugfix = ReleaseNoteItem.create(
        change_title: "Change Title",
        change_details: "Change Details",
        change_type_id: bug_type.id,
        user_id: @user.id,
        release_note_id: @release_note.id
    )

    expect(ReleaseNoteItem.enhancement).to include(rni_enhancement)
    expect(ReleaseNoteItem.enhancement).to_not include(rni_newfeature, rni_bugfix)
  end

  it "only returns new feature items through the new_feature scope" do
    max_priority = ChangeType.all.map(&:priority).max
    newfeature_type = ChangeType.create(name: 'New Feature', icon: 'fa-sun', priority: max_priority+1)
    enhancement_type = ChangeType.create(name: 'Enhancement', icon: 'fa-thumbs-up', priority: max_priority+2)
    bug_type = ChangeType.create(name: 'Bug Fix', icon: 'fa-bug', priority: max_priority+3)

    rni_newfeature = ReleaseNoteItem.create(
        change_title: "Change Title",
        change_details: "Change Details",
        change_type_id: newfeature_type.id,
        user_id: @user.id,
        release_note_id: @release_note.id
    )
    rni_enhancement = ReleaseNoteItem.create(
        change_title: "Change Title",
        change_details: "Change Details",
        change_type_id: enhancement_type.id,
        user_id: @user.id,
        release_note_id: @release_note.id
    )
    rni_bugfix = ReleaseNoteItem.create(
        change_title: "Change Title",
        change_details: "Change Details",
        change_type_id: bug_type.id,
        user_id: @user.id,
        release_note_id: @release_note.id
    )

    expect(newfeature_type).to be_valid
    expect(enhancement_type).to be_valid
    expect(bug_type).to be_valid

    expect(rni_newfeature).to be_valid
    expect(rni_enhancement).to be_valid
    expect(rni_bugfix).to be_valid

    expect(ReleaseNoteItem.new_feature).to include(rni_newfeature)
    expect(ReleaseNoteItem.new_feature).to_not include(rni_enhancement, rni_bugfix)
  end

end
