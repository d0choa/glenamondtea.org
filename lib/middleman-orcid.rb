
require 'log4r'

# require 'lib/helpers'
require 'lib/profile'
require 'lib/bibliography'
require 'lib/work'

class MiddlemanOrcid < Middleman::Extension  
  
  option :data, true, 'A example variable.'
  attr_accessor :orcid, :created_at, :updated_at, :biography, :given_names, :family_name, :name, :credit_name, :other_names, :reversed_name, :works, :a
  
  def initialize(app, options_hash={}, &block)    
    super    
    self.generate(options.data)
  end
  
  def generate(site)
    unless is_orcid?(site.config['author']['orcid']) && @profile = Profile.new(site.config['author']['orcid'])
      error 404
    end
    IO.write("#{site.config['scholar']['source']}.yml", @profile.to_yaml)
  end
    
  #Methods
  def h(text)
    Rack::Utils.escape_html(text)
  end

  def is_orcid?(string)
    string.strip =~ /\A[0-9]{4}\-[0-9]{4}\-[0-9]{4}\-[0-9]{3}[0-9X]\Z/
  end

  def get_csl(style)
    return "apa" if ["apa", "", nil].include? style

    response = Faraday.get "http://www.zotero.org/styles/#{style}"
    return "apa" unless response.status == 200

    parent  = Nokogiri::XML(response.body).at_css('link[rel="independent-parent"]')
    return response.body unless parent

    style = File.basename(parent["href"])
    get_csl(style)
  end
     
end

::Middleman::Extensions.register(:middleman_orcid, MiddlemanOrcid)
