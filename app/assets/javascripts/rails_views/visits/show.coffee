class Hipocrates.RailsViews.VisitsShowView extends Backbone.View
  el: 'body'

  events:
    'keyup #recognition-search': 'searchRecognitions'
    'keyup #procedure-search': 'searchProcedures'

  searchRecognitions: (e) ->
    value = $(e.target).val()
    $('.visit_recognitions label').each (index) ->
      if $(@).text().indexOf(value) == -1 then $(@).hide() else $(@).show()

  searchProcedures: (e) ->
    value = $(e.target).val()
    $('.visit_procedures label').each (index) ->
      if $(@).text().indexOf(value) == -1 then $(@).hide() else $(@).show()

