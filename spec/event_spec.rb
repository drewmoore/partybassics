require_relative 'spec_helper'

describe 'Event' do
  before(:each) do
    e1 = Event.create(title: 'Test Event', date: Date.yesterday)
  end

  it "should exist" do
    e = Event.all
    expect(e.length).to eql(1)
  end
  it "should have a title" do
    e = Event.find_by title: "Test Event"
    expect(e.title).to eql("Test Event")
  end
  it "should have a date" do
    e = Event.find_by title: "Test Event"
    expect(e.date).to eql(Date.yesterday.to_s)
  end
end
