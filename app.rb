require 'rubygems'
require 'bundler'; Bundler.setup
require 'sinatra'
require 'pivotal-tracker'
require 'json'
require 'haml'
require 'sass'
require 'ap'
require settings.root + '/settings'
require settings.root + '/models/wip/pivotal_tracker_proxy'


PivotalTracker::Client.token = settings.token

get '/styles.css' do
  scss :styles
end

get '/' do
  @projects = WIP::PivotalTrackerProxy.projects
  haml :index
end

get '/stories/:project_id' do
  {
    :wip_limit => settings.wip_story_limit,
    :stories => WIP::PivotalTrackerProxy.stories(params[:project_id], "started")
  }.to_json
end

helpers do
  def project_options(projects)
    projects.map do |project|
      "<option value='#{project.id}'>#{project.name}</option>"
    end.join
  end
end

