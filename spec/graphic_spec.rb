require_relative 'spec_helper'

describe "Graphic" do
  before(:each) do
    p1 = Page.create(title: "Test title", controller: "test_controller", action: "test_action")
    p2 = Page.create(title: "Test title 2", controller: "test_controller2", action: "test_action")
    g1 = Graphic.create(identifier: "graphic-identifier", path: "graphic.png")
  end
  it "should exist in the database" do
    g = Graphic.all
    expect(g.length).to eql(1)
  end
  it "should have an identifier" do
    g = Graphic.find_by identifier: "graphic-identifier"
    expect(g.identifier).to eql("graphic-identifier")
  end
  it "should have a path" do
    g = Graphic.find_by identifier: "graphic-identifier"
    expect(g.path).to eql("graphic.png")
  end
  it "the identifier should not have any white space" do
    g1 = Graphic.create(identifier: "Should not work")
    g_lookup = Graphic.find_by identifier: "Should not work"
    expect(g_lookup).to be(nil)
  end
  it "the identifier should be unique" do
    g1 = Graphic.create(identifier: "graphic-identifier")
    g_lookup = Graphic.where identifier: "graphic-identifier"
    expect(g_lookup.length).to eql(1)
  end
  it "should have page associations" do
    g1 = Graphic.new(identifier:"identifier-1", path:"test.png")
    p = Page.all
    p1 = p[0]
    p2 = p[1]
    g1.pages << p1
    g1.pages << p2
    g1.save
    expect(g1.pages.length).to eql(2)
  end
end
