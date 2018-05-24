class Dev
  def self.included(base)
    base.extend self
  end

  def dev
    ENV['TIM_RN_ENVIRONMENT'] == 'local' || ENV['TIM_RN_ENVIRONMENT'] == 'stage'
  end

  def create_random_release_notes(number)

    if dev
      number.times do

        @random_note = ReleaseNote.create(
                                      title: Faker::Simpsons.quote,
                                      release_date: Faker::Date.between(1.years.ago, Date.today),
                                      intro: Faker::RickAndMorty.quote,
                                      outro: Faker.StarWars.quote,
                                      user_id: 1
        )

        rand(1..15).times do
          ReleaseNoteItem.create(
              change_type_id: rand(1..3),
              user_id: 1,
              release_note_id: @random_note.id,
              change_title: Faker::TheITCrowd.quote,
              change_details: Faker::TheFreshPrinceOfBelAir.quote
          )
        end

      end
    end

  end

  def delete_all_release_notes
    if dev
      ReleaseNote.all.each do |rn|
        rn.release_note_items.each do |rni|
          rni.destroy
        end
        rn.destroy
      end
    end
  end

end