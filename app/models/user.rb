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
  
end
