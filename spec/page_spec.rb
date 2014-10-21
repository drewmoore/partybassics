require_relative 'spec_helper'

describe "Page" do
  before(:each) do
    p1 = Page.new
    p1.title = "Test Title"
    p1.controller = "test_controller"
    p1.action = "index"
    p1.save
  end
  context "construct object" do
    let(:p1) {
      p1 = Page.new
      p1.title = "Test Title"
      return p1
    }

    it "should exist in memory" do
      expect(p1.nil?).to be(false)
    end
    it "should have a title in memory" do
      expect(p1.title).to eql("Test Title")
    end
    it "should exist in the database" do
      p_lookup = Page.all
      expect(p_lookup.length).to eql(1)
    end
    it "should have a title in the database" do
      p_lookup = Page.find_by title: "Test Title"
      expect(p_lookup.title).to eql("Test Title")
    end
    it "should have a controller in the database" do
      p_lookup = Page.find_by controller: "test_controller"
      expect(p_lookup.controller).to eql("test_controller")
    end
    it "should have an action in the database" do
      p_lookup = Page.find_by action: "index"
      expect(p_lookup.action).to eql("index")
    end
    it "should allow a page with a duplicate controller or action" do
      p2 = Page.new
      p3 = Page.new
      p2.controller = "test_controller"
      p2.action = "show"
      p3.controller = "another_controller"
      p3.action = "index"
      p2.save
      p3.save
      p_lookup1 = Page.where(action: "index")
      p_lookup2 = Page.where(controller: "test_controller")
      expect(p_lookup1.length).to eql(2)
      expect(p_lookup2.length).to eql(2)
    end
    it "should not add a page with a duplicate controller/action combination" do
      p2 = Page.new
      p2.controller = "test_controller"
      p2.action = "index"
      p2.save
      p_lookup = Page.where(action: "index")
      expect(p_lookup.length).to eql(1)
    end
    it "should not have a bogus record in the database" do
      p_lookup = Page.find_by title: "False Title"
      expect(p_lookup).to be(nil)
    end
    it "should update record in database" do
      p2 = Page.find_by title: "Test Title"
      p2.title = "New Title"
      p2.controller = "new_controller"
      p2.action = "new_action"
      p2.save
      p_lookup = Page.find_by title: "New Title"
      expect(p_lookup.title).to eql("New Title")
      expect(p_lookup.controller).to eql("new_controller")
      expect(p_lookup.action).to eql("new_action")
    end
    it "should have contents" do
      c1 = Content.create(text: "content1 text", identifier: "content1-identifier")
      c2 = Content.create(text: "content2 text", identifier: "content2-identifier")
      p1.contents << c1
      p1.contents << c2
      p1.save
      expect(p1.contents.length).to eql(2)
    end
    it "should have graphics" do
      g1 = Graphic.create(path: "graphic1.png", identifier: "graphic1-identifier")
      g2 = Graphic.create(path: "graphic2.png", identifier: "graphic2-identifier")
      p1.graphics << g1
      p1.graphics << g2
      p1.save
      expect(p1.graphics.length).to eql(2)
    end
  end
end
