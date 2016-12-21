# -*- coding: utf-8 -*-

require 'addressable/uri'
require 'log4r'
require 'crossref'
require "i18n"

class Work < BibTeX::Entry

  attr_accessor :doi, :url, :number, :volume, :pages, :contributors

  WORK_TYPES = { article:       "JOURNAL_ARTICLE",
                 inproceedings: "CONFERENCE_PROCEEDINGS",
                 misc:          "OTHER" }
  
  def logger
    Log4r::Logger['test']    
  end
  
  def initialize(work, author)
    doi = nil
    
    # Some extra work may be needed to pick up the DOI
    if work["work-external-identifiers"]["work-external-identifier"].select{ |x| x['work-external-identifier-type'].upcase == 'DOI'}.first["work-external-identifier-id"]["value"]
      
      doi = work["work-external-identifiers"]["work-external-identifier"].select{ |x| x['work-external-identifier-type'].upcase == 'DOI'}.first["work-external-identifier-id"]["value"]
      doi = doi.gsub(/(?i:DOI):?\s?(10\.\S+)/, '\1').strip
    end
    
    if doi
      conn = Faraday.new(:url => 'http://crossref.org/openurl/') do |c|
        c.request :url_encoded
        c.response :xml,  :content_type => /\bxml$/
        c.adapter Faraday.default_adapter
      end

      response = conn.get do |req|
        req.params['noredirect'] = 'true'
        req.params['format'] = 'unixref'
        req.params['pid'] = 'ochoa@ebi.ac.uk'
        req.params['id'] = doi
      end

      record = response.body["doi_records"]["doi_record"]["crossref"]

      entry = BibTeX::Entry.new
      
      entry.author = author
      entry.DOI = doi
      entry.url = "http://dx.doi.org/#{doi}"
      if work["publication-date"]["month"]
        entry.month = work["publication-date"]["month"]["value"]
      end
      if work["publication-date"]["day"]
        entry.day = work["publication-date"]["day"]["value"]
      end
      if work["publication-date"]["year"]["value"]
        entry.year = work["publication-date"]["year"]["value"]
      end
      if (defined?(record["journal"]["journal_issue"]))
        entry.volume = record["journal"]["journal_issue"]["journal_volume"]["volume"]      
        entry.number = record["journal"]["journal_issue"]["issue"]
      end      

      if (defined?(record["journal"]["journal_article"]["pages"]))
        if(record["journal"]["journal_article"]["pages"].to_s != "")
          if(record["journal"]["journal_article"]["pages"]["last_page"].to_s != "")
            entry.pages = record["journal"]["journal_article"]["pages"]["first_page"] + "-" + record["journal"]["journal_article"]["pages"]["last_page"]
          else
            entry.page = record["journal"]["journal_article"]["pages"]["first_page"]
          end
        end
      end
      
      @contributors = Array.new
      if(defined?(record["journal"]["journal_article"]["contributors"]))
        record["journal"]["journal_article"]["contributors"]["person_name"].each do |contributor|
          thisauthor =  contributor["surname"] + ", " + contributor["given_name"]
          @contributors.push(thisauthor)
        end
      end
      entry.author = contributors.join(" and ")

      if(defined?(record["journal"]["journal_article"]["titles"]["title"]))
        entry.title = record["journal"]["journal_article"]["titles"]["title"]
        entry.journal = record["journal"]["journal_metadata"]["full_title"]
      end
      super(entry.fields)
    else
      if work["work-citation"] and work["work-citation"]["work-citation-type"].upcase == "BIBTEX"
        entry = BibTeX.parse(work["work-citation"]["citation"])[0]

        # Fix missing or malformed author field
        entry.author = author if entry.author.to_s == ""
        entry.author.gsub!(";", "")
        unless entry.author.to_s.include?("and") or entry.author.to_s.count(" ") < 3
          entry.author = entry.author.gsub(",", " and ")
        end

        # Fix missing title
        entry.title = "No title" unless entry.title

        # Fix issue with uppercased DOI field in BibTeX not recognized downstream in citeproc (I think)
        entry.doi = entry.DOI if entry.respond_to? :doi and entry.doi.nil? and !entry.DOI.nil?

        super(entry.fields)
        self["type"] = entry.type

      # otherwise create the object from scratch based on ORCID metadata
      else
        type = WORK_TYPES.key(work["work-type"]) || :misc
        title = work["work-title"] ? work["work-title"]["title"]["value"] : "No title"
        super({:type => type,
               :title => title,
               :author => author})

        # Optional attributes
        self["journal"] = work["work-title"]["subtitle"]["value"] if work["work-title"] and work["work-title"]["subtitle"]
        self["year"] = work["publication-date"]["year"]["value"] if work["publication-date"]
      end
    end
    
    
    # if work is already in bibtex format


    # Fix up the URL field if needed by adding a dx.doi.org URL
    if self.url.nil? and !self.doi.nil? 
      self["url"] = Addressable::URI.escape "http://dx.doi.org/#{doi}"
    end
  end

  # def hash
  #   "#{unique_title}_#{year}".hash
  # end

  def url
    self["url"]
  end

  def doi
    self["doi"]
  end

  # def ==(other)
  #   other.equal?(self) || ( other.instance_of?(self.class) && "#{other.unique_title}_#{other.year}" == "#{unique_title}_#{year}" )
  # end

  alias :eql? :==

  def unique_title
    encoding_options = {
      :invalid           => :replace,  # Replace invalid byte sequences
      :undef             => :replace,  # Replace anything not defined in ASCII
      :replace           => ''         # Use a blank for those replacements
    }
    title.downcase.encode Encoding.find('ASCII'), encoding_options
  end
end
