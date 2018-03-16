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

### Deployment
The easiest way to deplay your website is to follow DatoCMS documentation with Netlify:
[https://www.datocms.com/docs/deployment/netlify/](https://www.datocms.com/docs/deployment/netlify/)

In step 2 in addition to ``DATO_API_TOKEN`` don't forget to also add other env variable regarding dmat:

* ``SITE_URL`` (ex: https://www.yoursite.com)
* ``SITE_ENV`` (production or staging)
* ``GA_ACCOUNT`` (Google Analytics Tracking ID ex: UA-XXXXX-X)
