require "administrate/base_dashboard"

class TaskDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    bathrooms: Field::Number,
    bedrooms: Field::Number,
    city: Field::String,
    completed: Field::Boolean,
    country: Field::String,
    description: Field::String,
    direction: Field::String,
    district: Field::String,
    land_area: Field::Number,
    meter_street: Field::Number,
    property_price: Field::String.with_options(searchable: false),
    property_type: Field::String,
    rent_duration: Field::String,
    result: Field::String,
    selected_language: Field::String,
    transaction_type: Field::String,
    user: Field::BelongsTo,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    bathrooms
    bedrooms
    city
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    bathrooms
    bedrooms
    city
    completed
    country
    description
    direction
    district
    land_area
    meter_street
    property_price
    property_type
    rent_duration
    result
    selected_language
    transaction_type
    user
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    bathrooms
    bedrooms
    city
    completed
    country
    description
    direction
    district
    land_area
    meter_street
    property_price
    property_type
    rent_duration
    result
    selected_language
    transaction_type
    user
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how tasks are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(task)
  #   "Task ##{task.id}"
  # end
end
