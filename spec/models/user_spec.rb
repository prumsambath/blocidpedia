require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:wikis).dependent(:destroy) }

  describe "User with a default role" do
    it "sets a standard role" do
      user = create(:user)
      expect(user.role).to eq("standard")
    end
  end

  describe "#admin?" do
    it "returns true if user has admin role" do
      admin = create(:admin_user)
      expect(admin.admin?).to be(true)
    end

    it "returns false if user has no admin role" do
      user = create(:user)
      expect(user.admin?).to be(false)
    end
  end

  describe "#standard?" do
    it "returns true if user has standard role" do
      standard_user = create(:standard_user)
      expect(standard_user.standard?).to be(true)
    end

    it "returns false if user has no standard role" do
      premium_user = create(:premium_user)
      expect(premium_user.standard?).to be(false)
    end
  end

  describe "#premium?" do
    it "returns true if user has premium role" do
      premium_user = create(:premium_user)
      expect(premium_user.premium?).to be(true)
    end

    it "returns false if user has no premium role" do
      standard_user = create(:standard_user)
      expect(standard_user.premium?).to be(false)
    end
  end
end
