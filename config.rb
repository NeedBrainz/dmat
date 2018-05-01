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

# tell Middleman to ignore the template
ignore "/templates/*"

# plugins
preview = ENV['SITE_ENV'] == 'staging' ? true:false
activate :dato, live_reload: true


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
  def render_components()
    base_url = "https://cdn.ampproject.org/v0/";
    amp_components = {
      #Ads and analytics
      'ad'                    => { v: 0.1 },
      'ad-exit'               => { v: 0.1 },
      'analytics'             => { v: 0.1 },
      'auto-ads'              => { v: 0.1 },
      'call-tracking'         => { v: 0.1 },
      'experiment'            => { v: 0.1 },
      'sticky-ad'             => { v: 0.1 },
      #Dynamic content
      'acces-laterpay'        => { v: 0.2 }, #!also require access and analytics!
      'acces'                 => { v: 0.1 }, #!also require analytics!
      'bind'                  => { v: 0.1 },
      'byside-content'        => { v: 0.1 },
      'consent'               => { v: 0.1 },
      'date-picker'           => { v: 0.1 },
      'form'                  => { v: 0.1 },
      'geo'                   => { v: 0.1 },
      'gist'                  => { v: 0.1 },
      'install-serviceworker' => { v: 0.1 },
      'list'                  => { v: 0.1 },
      'live-list'             => { v: 0.1 },
      'mustache'              => { v: 0.1 },
      'selector'              => { v: 0.1 },
      'user-notification'     => { v: 0.1 },
      'web-push'              => { v: 0.1 },
      #Layout
      'accordion'             => { v: 0.1 },
      'app-banner'            => { v: 0.1 },
      'carousel'              => { v: 0.1 },
      'fx-flying-carpet'      => { v: 0.1 },
      'iframe'                => { v: 0.1 },
      'image-lightbox'        => { v: 0.1 },
      'lightbox'              => { v: 0.1 },
      'position-observer'     => { v: 0.1 },
      'sidebar'               => { v: 0.1 },
      #Media
      '3q-player'             => { v: 0.1 },
      'anim'                  => { v: 0.1 },
      'apester-media'         => { v: 0.1 },
      'audio'                 => { v: 0.1 },
      'bodymovin-animation'   => { v: 0.1 },
      'brid-player'           => { v: 0.1 },
      'brightcove'            => { v: 0.1 },
      'dailymotion'           => { v: 0.1 },
      'google-vrview-image'   => { v: 0.1 },
      'hulu'                  => { v: 0.1 },
      'ima-video'             => { v: 0.1 },
      'imgur'                 => { v: 0.1 },
      'izlesene'              => { v: 0.1 },
      'jwplayer'              => { v: 0.1 },
      'kaltura-player'        => { v: 0.1 },
      'nexxtv-player'         => { v: 0.1 },
      'o2-player'             => { v: 0.1 },
      'ooyala-player'         => { v: 0.1 },
      'playbuzz'              => { v: 0.1 },
      'reach-player'          => { v: 0.1 },
      'soundcloud'            => { v: 0.1 },
      'springboard-player'    => { v: 0.1 },
      'video'                 => { v: 0.1 },
      'vimeo'                 => { v: 0.1 },
      'wistia-player'         => { v: 0.1 },
      'youtube'               => { v: 0.1 },
      #Presentation
      'animation'             => { v: 0.1 },
      'dynamic-css-classes'   => { v: 0.1 },
      'fit-text'              => { v: 0.1 },
      'font'                  => { v: 0.1 },
      'mathml'                => { v: 0.1 },
      'story'                 => { v: 0.1 },
      'timeago'               => { v: 0.1 },
      'viz-vega'              => { v: 0.1 },
      #Social
      'beopinion'             => { v: 0.1 },
      'addthis'               => { v: 0.1 },
      'facebook-comments'     => { v: 0.1 },
      'facebook-like'         => { v: 0.1 },
      'facebook-page'         => { v: 0.1 },
      'facebook'              => { v: 0.1 },
      'gfycat'                => { v: 0.1 },
      'instagram'             => { v: 0.1 },
      'pinterest'             => { v: 0.1 },
      'reddit'                => { v: 0.1 },
      'riddle-quiz'           => { v: 0.1 },
      'social-share'          => { v: 0.1 },
      'twitter'               => { v: 0.1 },
      'vine'                  => { v: 0.1 },
      'vk'                    => { v: 0.1 },
    }
    result = ""
    components = []
    components = current_page.metadata['amp_components'] if current_page.metadata.has_key?('amp_components')
    components.uniq.each do |component|
      if amp_components.has_key?(component)
        result << "<script async custom-element=\"amp-#{component}\" src=\"#{base_url}amp-#{component}-#{amp_components[component][:v]}.js\"></script>"
      end
    end
    result
  end
  def add_component(name)
    c = []
    c = current_page.metadata['amp_components'] if current_page.metadata.has_key?('amp_components')
    c.push(name) unless c.include?(name)
    current_page.add_metadata({'amp_components' => c })
  end
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
