class BugsController < ApplicationController

 def index
    @bug = Bug.new
 end

 def create  
  @bug = Bug.new(params[:bug])
  @name = @bug.vorname
  @title = @bug.name
  @message = @bug.bug
  Client.token("LOGIN AT PIVOTAL", "PASSWORD", "post")
  @project = Project.new
  # Project.all
  Client.use_ssl = true
  Project.find('PROJECT-ID')
  p @project.stories.nil?
  p Story.new('PROJECT-ID', @message, @title, @name).all
  p Story.new('PROJECT-ID', @message, @title, @name).create
  
  
 end
end
