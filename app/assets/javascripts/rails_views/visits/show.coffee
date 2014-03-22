class Hipocrates.RailsViews.VisitsShowView extends Backbone.View
  el: 'body'

  events:
    'keyup #recognition-search': 'searchRecognitions'
    'keyup #procedure-search': 'searchProcedures'
    'keyup #med-search': 'searchMeds'

  searchRecognitions: (e) ->
    value = $(e.target).val().toLowerCase()
    $('.visit_recognitions label').each (index) ->
      if $(@).text().toLowerCase().indexOf(value) == -1 then $(@).hide() else $(@).show()

  searchProcedures: (e) ->
    value = $(e.target).val().toLowerCase()
    $('.visit_procedures label').each (index) ->
      if $(@).text().toLowerCase().indexOf(value) == -1 then $(@).hide() else $(@).show()

  searchMeds: (e) ->
    value = $(e.target).val().toLowerCase()
    $('.visit_meds label').each (index) ->
      if $(@).text().toLowerCase().indexOf(value) == -1 then $(@).hide() else $(@).show()

