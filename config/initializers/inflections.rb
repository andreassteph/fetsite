# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end
ActiveSupport::Inflector.inflections do |inflect|
inflect.plural 'studium', 'studien'
inflect.singular 'studien', 'studium'
inflect.plural 'neuigkeit', 'neuigkeiten'
inflect.singular 'neuigkeiten', 'neuigkeit'
inflect.plural 'modulgruppe', 'modulgruppen'
inflect.singular 'modulgruppen', 'modulgruppe'
inflect.irregular 'modulgruppe', 'modulgruppen'
inflect.plural 'rubrik', 'rubriken'
inflect.singular 'rubriken', 'rubrik'
inflect.plural 'beispiel', 'beispiele'
inflect.singular 'beispiele', 'beispiel'
end
