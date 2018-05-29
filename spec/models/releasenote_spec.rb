require 'rails_helper'

RSpec.describe ReleaseNote, type: :model do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  def create_change_types
    @newfeature_type = ChangeType.create(name: 'New Feature', icon: 'fa-sun', priority: 1)
    @enhancement_type = ChangeType.create(name: 'Enhancement', icon: 'fa-thumbs-up', priority: 2)
    @bug_type = ChangeType.create(name: 'Bug Fix', icon: 'fa-bug', priority: 3)
  end

  describe "is valid when" do
    it "it has a user_id, title and release date" do
      release_note = ReleaseNote.new(
          title: "Test Title",
          release_date: "23-05-2018",
          intro: "Intro text",
          outro: "Outro text",
          user_id: @user.id
      )
      expect(release_note).to be_valid
    end

    it "it has no intro" do
      release_note = ReleaseNote.new(
          title: "Test Title",
          release_date: "23-05-2018",
          outro: "Outro text",
          user_id: @user.id
      )
      expect(release_note).to be_valid
    end
    
    it "it has no outro" do
      release_note = ReleaseNote.new(
          title: "Test Title",
          release_date: "23-05-2018",
          intro: "Intro text",
          user_id: @user.id
      )
      expect(release_note).to be_valid
    end
    
    it "it has no release_note_items" do
      @release_note = FactoryBot.create(:release_note, user_id: @user.id)

      expect(@release_note).to be_valid
    end
    
    it "it has one release_note_item" do
      @release_note = FactoryBot.create(:release_note, user_id: @user.id)
      @change_type = FactoryBot.create(:change_type)

      1.times do
        FactoryBot.create(:release_note_item, change_type_id: @change_type.id, user_id: @user.id, release_note_id: @release_note.id)
      end

      expect(@release_note).to be_valid
    end
    
    it "it has multiple release_note_items" do
      @release_note = FactoryBot.create(:release_note, user_id: @user.id)
      @change_type = FactoryBot.create(:change_type)

      rand(2..5).times do
        FactoryBot.create(:release_note_item, change_type_id: @change_type.id, user_id: @user.id, release_note_id: @release_note.id)
      end

      expect(@release_note).to be_valid
    end
  end
  
  describe "is invalid when" do
    it "it has no title" do
      release_note = ReleaseNote.new(
          release_date: "23-05-2018",
          intro: "Intro text",
          outro: "Outro text",
          user_id: @user.id
      )

      release_note.valid?
      expect(release_note.errors[:title]).to include("can't be blank")
    end
    
    it "it has no release date" do
      release_note = ReleaseNote.new(
          title: "Has no release date",
          intro: "Intro text",
          outro: "Outro text",
          user_id: @user.id
      )

      release_note.valid?
      expect(release_note.errors[:release_date]).to include("can't be blank")
    end
    
    it "it has no user_id" do
      release_note = ReleaseNote.new(
          title: "Test Title",
          release_date: "23-05-2018",
          intro: "Intro text",
          outro: "Outro text"
      )
      release_note.valid?
      expect(release_note.errors[:user_id]).to include("can't be blank")
    end
    
    it "the user with the given user id does not exist" do
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
  end

  describe "returns the correct records when using a scope" do

    before do
      # Create 2 release notes. 1 will have new features, 2 will not
      @release_note_1 = FactoryBot.create(:release_note, user_id: @user.id, published: true)
      @release_note_2 = FactoryBot.create(:release_note, user_id: @user.id, published: true)

      # Create change types for use in the release note items associated to the above release notes
      create_change_types

      # Create release note items (2 of each type)
      # All rni_*_1 get associated to release_note_1
      @rni_newfeature_1 = ReleaseNoteItem.create(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: @newfeature_type.id,
          user_id: @user.id,
          release_note_id: @release_note_1.id
      )

      @rni_enhancement_1 = ReleaseNoteItem.create(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: @enhancement_type.id,
          user_id: @user.id,
          release_note_id: @release_note_1.id
      )

      @rni_bugfix_1 = ReleaseNoteItem.create(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: @bug_type.id,
          user_id: @user.id,
          release_note_id: @release_note_1.id
      )

      # All rni_*_2 get associated to release_note_1
      @rni_newfeature_2 = ReleaseNoteItem.create(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: @newfeature_type.id,
          user_id: @user.id,
          release_note_id: @release_note_2.id
      )

      @rni_enhancement_2 = ReleaseNoteItem.create(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: @enhancement_type.id,
          user_id: @user.id,
          release_note_id: @release_note_2.id
      )

      @rni_bugfix_2 = ReleaseNoteItem.create(
          change_title: "Change Title",
          change_details: "Change Details",
          change_type_id: @bug_type.id,
          user_id: @user.id,
          release_note_id: @release_note_2.id
      )
    end
    
    context "when there are multiple release notes and not all are published" do
      it "only returns published release_notes through the published scope" do

        release_note_1 = FactoryBot.create(:release_note, user_id: @user.id, published: true)
        change_type = @newfeature_type

        rand(2..5).times do
          FactoryBot.create(:release_note_item, change_type_id: change_type.id, user_id: @user.id, release_note_id: release_note_1.id)
        end

        release_note_2 = FactoryBot.create(:release_note, user_id: @user.id, published: false)

        rand(2..5).times do
          FactoryBot.create(:release_note_item, change_type_id: change_type.id, user_id: @user.id, release_note_id: release_note_2.id)
        end

        expect(ReleaseNote.published).to include(release_note_1)
        expect(ReleaseNote.published).to_not include(release_note_2)

      end
    end

    context "when there are multiple release notes, each with multiple release note items" do
      it "only returns release notes which include new features through the new_features scope " do
        # Update the rni_*_2 with the targeted change type to be associated to release_note_1
        @rni_newfeature_2.update(release_note_id: @release_note_1.id)

        # Test the the scope only returns release_note_1
        expect(ReleaseNote.new_features).to include(@release_note_1) # Has 2 NEW FEATURES, 1 ENHANCEMENT and 1 BUG FIX
        expect(ReleaseNote.new_features).to_not include(@release_note_2) # Has 0 NEW FEATURES, 1 ENHANCEMENT and 1 BUG FIX
      end

      it "only returns release notes which include enhancements through the enhancements scope" do
        # Update the rni_*_2 with the targeted change type to be associated to release_note_1
        @rni_enhancement_2.update(release_note_id: @release_note_1.id)

        # Test the the scope only returns release_note_1
        expect(ReleaseNote.enhancements).to include(@release_note_1) # Has 1 NEW FEATURE, 2 ENHANCEMENTS and 1 BUG FIX
        expect(ReleaseNote.enhancements).to_not include(@release_note_2) # Has 1 NEW FEATURE, 0 ENHANCEMENTS and 1 BUG FIX
      end

      it "only returns release notes which include bug fixes through the bug_fixes scope" do
        # Update the rni_*_2 with the targeted change type to be associated to release_note_1
        @rni_bugfix_2.update(release_note_id: @release_note_1.id)

        # Test the the scope only returns release_note_1
        expect(ReleaseNote.bug_fixes).to include(@release_note_1) # Has 1 NEW FEATURE, 1 ENHANCEMENT and 2 BUG FIXES
        expect(ReleaseNote.bug_fixes).to_not include(@release_note_2) # Has 1 NEW FEATURE, 1 ENHANCEMENT and 0 BUG FIXES
      end
    end

  end

end
