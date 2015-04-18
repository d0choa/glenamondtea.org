###
# Blog settings
###

require 'faraday'
require 'faraday_middleware'
require 'multi_xml'
require 'yaml'
require 'lib/middleman-orcid.rb'
require 'bibtex'
require 'crossref'
require "lib/helpers"


Time.zone = "London"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}.html"
  blog.layout = "post"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".md"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

activate :syntax

activate :directory_indexes

page "/feed.xml", :layout => false

set :markdown_engine, :redcarpet
set :markdown, :layout_engine => :erb,
               :fenced_code_blocks => true,
               :tables => true,
               :autolink => true,
               :smartypants => true,
               :with_toc_data => true

# Middleman Orcid
helpers Helpers
activate :middleman_orcid, :data => data

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-60453205-1' # Replace with your property ID.
end

# paper = CR.doi('10.1021/ie50324a027')
# doi = data.bibliography["orcid-activities"]["orcid-works"]["orcid-work"][1]["work-external-identifiers"]["work-external-identifier"].select{ |x| x["work-external-identifier-type"] = "DOI"}.first()["work-external-identifier-id"]["value"]

# doi = data.bibliography["orcid-activities"]["orcid-works"]["orcid-work"][1]["work-external-identifiers"]["work-external-identifier"].select{|x| x["work-external-identifier-type"] == "DOI"}.first["work-external-identifier-id"]["value"]
# CR = Crossref::Metadata.new(:pid => "dogcaesar@gmail.com")
# paper = CR.doi(doi)
#
# puts paper.title
 # bib = BibTeX.parse(data.bibliography["orcid-activities"]["orcid-works"]["orcid-work"][0]["work-citation"]["citation"])

 

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

page "/sitemap.xml", :layout => false
  
# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets
  set :relative_links, true
  set :relative_paths, true

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
