# [DatoCMS + Middleman + AMP + Tailwind Starter Website](https://dmat.needbrainz.com)

A starter site template to kickstart a middleman website with AMP pages tailwindcss and content from DatoCMS.

## Installation
Require NodeJS, npm (>=3), Ruby and RubyGems
First install dev dependencies
```
npm install
bundle install
```

Copy the .env.example file and rename it .env (populate with your DatoCMS API Key)

If you want the system to build the base example homepage fields on your dato cms admin you can install ruby gem 'dato' and execute the dato_init.rb file
```
gem install dato
ruby dato_init.rb
```

### Local Running
Use middleman server command, Gulp will be running as an external pipeline for asset recompilation and live reload (use localhost:3000 instead of middleman port)
```
bundle exec middleman server
```

### Building
Use middleman normal build method ;)
```
bundle exec middleman build
```
### AMP components management
The amp components are managed as a simple array set in the currrent page metadata. You can add components from any template/layout/partial with the helper add_component(name). If you want for example to create a carousel gallery with lightbox from a dato modular block content for example:
```
<%
add_component("carousel")
add_component("image-lightbox")
%>

<amp-carousel
  height="250"
  layout="fixed-height"
  type="carousel">
  <% block.gallery.each_with_index do | image, index | %>
    <amp-img on="tap:lightbox<%= block.id %>" src="<%= image.url(w: 1200, h: 1000, fit: :crop, fm: :jpg) %>"
      role="button"
      tabindex="<%= index %>"
      width="300"
      height="250"
      alt="a sample image"></amp-img>
  <% end %>
</amp-carousel>
<amp-image-lightbox id="lightbox<%= block.id %>" layout="nodisplay"></amp-image-lightbox>
```
The js components ``amp-carousel`` and ``amp-image-lightbox`` will be added in the head of the site only once even if the partial is called multiple times on the page.


### Deployment
The easiest way to deplay your website is to follow DatoCMS documentation with Netlify:
[https://www.datocms.com/docs/deployment/netlify/](https://www.datocms.com/docs/deployment/netlify/)

In step 2 in addition to ``DATO_API_TOKEN`` don't forget to also add other env variable regarding dmat:

* ``SITE_URL`` (ex: https://www.yoursite.com)
* ``SITE_ENV`` (production or staging)
* ``GA_ACCOUNT`` (Google Analytics Tracking ID ex: UA-XXXXX-X)
