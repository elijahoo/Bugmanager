class Story

attr_accessor :project, :message, :title, :name

    def initialize(project_id, message, title, name)
      	self.project = project_id
      	self.message = message
	self.title = title
	self.name = name
    end

    def all
      	Client.connection["/projects/#{project}/stories"].get
    end

    def create
	Client.connection["/projects/#{project}/stories"].post(%Q{curl -d <story><story_type>bug</story_type><name>#{title}</name><description>#{message}</description><requested_by>OWNER</requested_by></story>})


      
    end


end
