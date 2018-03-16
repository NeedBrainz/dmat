require 'dato'
require 'dotenv'

token = ENV['DATO_API_TOKEN']

if token.blank? && File.exist?('.env')
  token = Dotenv::Environment.new('.env')['DATO_API_TOKEN']
end

if token.blank?
  raise RuntimeError, 'Missing DatoCMS site API token!'
end

client = Dato::Site::Client.new(token)

#Create the model for homepage
item_type = client.item_types.create(
  name: 'Homepage',
  singleton: true,
  modular_block: false,
  sortable: false,
  tree: false,
  api_key: 'homepage',
  ordering_direction: nil,
  ordering_field: nil
)
item_type_id = item_type[:id]

#Add title, subtitle and seo fields
title = client.fields.create(
  item_type_id,
  api_key: 'title',
  field_type: 'string',
  appeareance: { type: 'title' },
  label: 'Title',
  localized: false,
  position: 1,
  hint: '',
  validators: { required: {} }
)
subtitle = client.fields.create(
  item_type_id,
  api_key: 'subtitle',
  field_type: 'string',
  appeareance: { type: 'plain' },
  label: 'Subtitle',
  localized: false,
  position: 2,
  hint: '',
  validators: { required: {} }
)
seo = client.fields.create(
  item_type_id,
  api_key: 'seo',
  label: 'SEO',
  localized: false,
  appeareance: {},
  field_type: 'seo',
  hint: '',
  position: 3,
  validators: {}
)

#Create default content for homepage
homepage = client.items.create(
  item_type: item_type_id,
  title: 'My Awesome AMP Website',
  subtitle: 'Middleman + DatoCMS + Tailwind Powered!',
  seo: nil
)
