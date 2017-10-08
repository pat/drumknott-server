# frozen_string_literal: true

require "rails_helper"

RSpec.describe Site, :type => :model do
  describe "#valid?" do
    it "only allows names with valid characters" do
      # Where valid = lowercase letters, numbers, underscores and dashes

      site = Site.new :name => "foo"
      site.valid?
      expect(site.errors[:name].length).to eq(0)

      site = Site.new :name => "foo "
      site.valid?
      expect(site.errors[:name].length).to eq(1)

      site = Site.new :name => "Foo"
      site.valid?
      expect(site.errors[:name].length).to eq(1)

      site = Site.new :name => "foo-"
      site.valid?
      expect(site.errors[:name].length).to eq(0)

      site = Site.new :name => "foo_"
      site.valid?
      expect(site.errors[:name].length).to eq(0)

      site = Site.new :name => "foo_bar"
      site.valid?
      expect(site.errors[:name].length).to eq(0)

      site = Site.new :name => "foo$bar"
      site.valid?
      expect(site.errors[:name].length).to eq(1)
    end
  end
end
