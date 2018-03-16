require 'redcarpet'
###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration
set :css_dir, "css"
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, with_toc_data: true

# plugins
activate :dato, live_reload: true

# tell Middleman to ignore the template
ignore "/templates/*"

activate :directory_indexes
activate :external_pipeline,
  name: :gulp,
  command: build? ? 'gulp build':'gulp serve',
  source: '.tmp',
  latency: 1

###
# Helpers
###
helpers do
  def inline_css(name)
    name += ".css" unless name.include?(".css")
    css_path = sitemap.resources.select { |p| p.source_file.include?(name) }.first
    "#{css_path.render()}" if css_path
  end
  def active_link_to(*args)
    options = args.extract_options!
    if url_for(current_page.url) == url_for(args.last)
      options[:selected] = ""
    end
    link_to *args, options
  end
  def css_active_link_to(*args)
    options = args.extract_options!
    if url_for(current_page.url) == url_for(args.last)
      options[:class] += " active"
    end
    link_to *args, options
  end
  def markdown(text)
    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(hard_wrap: true,),
      tables: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      underline: true,
    ).render(text)
  end
end

# Build-specific configuration
configure :build do
  activate :minify_html
end

# Remove css dir after build
after_build do |builder|
  FileUtils.rm_rf(config[:build_dir]+'/'+config[:css_dir])
end
