class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :release_notes
  has_many :release_note_items

  validates :email, :first_name, :last_name, :job_title, presence: true

  scope :dev, -> {where(dev: true)}
  scope :end_user, -> {where(dev false)}
  scope :approved, -> {where(approved: true)}
  scope :not_approved, -> {where(approved: false)}

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def pref_name
    case self.preferred_name
      when 0
        first_name
      when 1
        last_name
      when 2
        nickname
      when 3
        [first_name, last_name].join(' ')
      when 4
        [first_name, '"' + nickname + '"', last_name].join(' ')
      when 5
        [nickname, first_name].join(' ')
      when 6
        [nickname, last_name].join(' ')
      when 7
        [first_name, nickname].join(' ')
      when 8
        [last_name, nickname].join(' ')
      else
        first_name
    end
  end
  
end
