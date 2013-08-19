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
inflect.irregular 'studium', 'studien'
inflect.irregular 'neuigkeit', 'neuigkeiten'
#inflect.irregular 'neuigkeiten', 'neuigkeit'
inflect.plural 'modulgruppe', 'modulgruppen'
inflect.singular 'modulgruppen', 'modulgruppe'
inflect.irregular 'modulgruppe', 'modulgruppen'
inflect.irregular 'rubrik', 'rubriken'
inflect.plural 'beispiel', 'beispiele'
inflect.singular 'beispiele', 'beispiel'
inflect.plural 'themengruppe', 'themengruppen'
inflect.singular 'themengruppen', 'themengruppe'
inflect.irregular 'themengruppe', 'themengruppen'
inflect.plural /thema$/, 'themen'
inflect.singular /themen$/, 'thema'
inflect.irregular 'thema', 'themen'
inflect.plural 'frage', 'fragen'
inflect.singular 'fragen', 'frage'
inflect.irregular 'frage', 'fragen'
inflect.singular 'gremien', 'gremium'
inflect.irregular 'gremium', 'gremien'
inflect.plural 'gremium', 'gremien'

end
