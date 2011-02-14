require 'rubygems'
require 'bundler'; Bundler.setup
require 'sinatra'
require 'sass'
require 'pivotal-tracker'
require 'json'
require settings.root + '/credentials'

# TODO: add protection against missing file or token

PivotalTracker::Client.token = settings.token

get '/styles.css' do
  scss :styles
end

get '/' do
  @projects = PivotalTracker::Project.all
  haml :index
end

get '/stories/:project_id' do
  project = PivotalTracker::Project.find(params[:project_id].to_i)
  started = project.stories.all.select(&story_filter("started")).map(&:name)
  # {:wip_limit => settings.wip_story_limit, :stories => project.stories.all.select(&story_filter("unscheduled")).map(&:name)}.to_json
  {:wip_limit => settings.wip_story_limit, :stories => started}.to_json
end


private

def story_filter(chosen_state)
  lambda {|story| story.owned_by == settings.member_name && story.current_state == chosen_state}
end
