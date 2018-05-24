require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  it "is valid when approved" do
    expect(@user).to be_valid
  end

end
