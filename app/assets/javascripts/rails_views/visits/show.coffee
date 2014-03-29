class Hipocrates.RailsViews.VisitsShowView extends Backbone.View
  el: 'body'

  events:
    'keyup #recognition-search': 'searchRecognitions'
    'keyup #procedure-search': 'searchProcedures'
    'keyup #med-search': 'searchMeds'

  initialize: () ->
    @hideBase('meds')
    @hideBase('procedures')
    @hideBase('recognitions')

  searchRecognitions: (e) ->
    value = $(e.target).val().toLowerCase()
    if value.length > 2 then @searchBase('recognitions', value) else @hideBase('recognitions')

  searchProcedures: (e) ->
    value = $(e.target).val().toLowerCase()
    if value.length > 2 then @searchBase('procedures', value) else @hideBase('procedures')

  searchMeds: (e) ->
    value = $(e.target).val().toLowerCase()
    if value.length > 2 then @searchBase('meds', value) else @hideBase('meds')

  searchBase: (search_type, value) ->
    $(".visit_#{search_type} label").each (index) ->
      if $(@).text().toLowerCase().indexOf(value) == -1 then $(@).hide() else $(@).show()

  hideBase: (to_hide) ->
    $(".visit_#{to_hide} label").hide()
