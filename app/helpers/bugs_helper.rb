module BugsHelper
  class Client
    class << self
      attr_writer :use_ssl
    end

    def self.use_ssl
      @use_ssl || false
    end

    def self.token(username, password, method)
      response = if method == 'post'
        RestClient.post 'https://www.pivotaltracker.com/services/tokens/active', :username => username, :password => password
      else
        RestClient.get "https://#{username}:#{password}@www.pivotaltracker.com/services/tokens/active"
      end
      @token ||= Nokogiri::XML(response).search('guid').inner_html
    end

    def self.connection(options={})
      if use_ssl
        @secure_connection ||= RestClient::Resource.new('https://www.pivotaltracker.com/services/v2', :headers => {'X-TrackerToken' => @token, 'Content-Type' => 'application/xml'})
      else
        @connection ||= RestClient::Resource.new('http://www.pivotaltracker.com/services/v2', :headers => {'X-TrackerToken' => @token, 'Content-Type' => 'application/xml'})
      end
    end

  end


  class Project

    class << self
      def all
        # /projects
        # Parse each and create new project array
        # response.each {|x| projects << parse(x) }
        #parse(connection['/projects'].get)
        Client.connection['/projects'].get
      end

      def find(id)
        # http://www.pivotaltracker.com/services/v2/projects/#{id}
        # parse response
        #parse(connection['/projects/#{id}'])
        Client.connection["/projects/{id}"].get
      end
    end

    attr_accessor :stories

    def initialize
      self.stories ||= []
    end

  end


  class Story
    attr_accessor :project

    def initialize(project_id)
      self.project = project_id
    end

    def all
      Client.connection["/projects/#{project}/stories"].get
    end

  end

  
end
