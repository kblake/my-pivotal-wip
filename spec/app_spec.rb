require File.dirname(__FILE__) + '/spec_helper'


describe 'Landing Page' do
  it "show page heading" do
    visit '/'
    page.has_content? 'My Pivotal WIP'
  end
end

