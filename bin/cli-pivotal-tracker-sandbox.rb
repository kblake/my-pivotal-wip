require 'rubygems'
require 'pivotal-tracker'
require 'highline/import'

HighLine.track_eof = false


def story_filter(chosen_state)
  lambda {|story| story.owned_by == @name && story.current_state == chosen_state}
end

def project_by_id
  id = ask("Enter project id")
  PivotalTracker::Project.find(id.to_i)
end

PivotalTracker::Client.token = ask("Please enter pivotal tracker token")
@name = ask("Enter name as in Pivotal Tracker")

line = "\n" + "="*72 + "\n"

loop do
  puts line

  choose do |menu|
    menu.prompt = "Pivotal Actions: "

    menu.choice "Projects" do
      PivotalTracker::Project.all.each do |project|
        say "#{project.id}: #{project.name}"
      end
    end

    menu.choice "Started Project Stories" do
      project_by_id.stories.all.find_all(&story_filter("started")).each do |story|
        puts "\t#{story.id}: #{story.name}"
      end
    end

    menu.choice "Accepted Project Stories" do
      project_by_id.stories.all.find_all(&story_filter("accepted")).each do |story|
        puts "\t#{story.id}: #{story.name}"
      end
    end

    menu.choice "Exit" do
      say "Bye bye!"
      exit
    end
  end
end
