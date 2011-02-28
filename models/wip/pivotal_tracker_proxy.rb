module WIP
  class PivotalTrackerProxy
    class << self
      def projects
        PivotalTracker::Project.all
      end

      def stories(project_id, chosen_state)
        stories_for_project(project_id).by(chosen_state).map(&:name)
      end

      protected

      def stories_for_project(project_id)
        @stories = project(project_id).stories.all
        self
      end

      def by(chosen_state)
        @stories.select(&story_filter(chosen_state))
      end

      def project(id)
        PivotalTracker::Project.find(id.to_i)
      end

      def story_filter(chosen_state)
        lambda {|story| story.owned_by == settings.member_name && story.current_state == chosen_state}
      end
    end  
  end
end
