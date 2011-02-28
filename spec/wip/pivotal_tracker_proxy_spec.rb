require 'spec_helper'

describe WIP::PivotalTrackerProxy do
  it "correctly retrieves projects " do
    PivotalTracker::Project.should_receive(:all).and_return([])
    WIP::PivotalTrackerProxy.projects.should == []
  end

  it "find stories" do
    project_id = 1234
    project = PivotalTracker::Project.new
    stories = [PivotalTracker::Story.new(:owned_by => "Neo Morpheus", :current_state => "started", :name => "Neo")]
    project.stub_chain(:stories, :all).and_return(stories)
    PivotalTracker::Project.should_receive(:find).and_return(project)
    WIP::PivotalTrackerProxy.stories(project_id, "started").should == [stories.first.name]
  end
end

