class Hipocrates.RailsViews.VisitsShowView extends Backbone.View
  el: 'body'

  events:
    'keyup #recognition-search': 'searchRecognitions'

  searchRecognitions: (e) ->
    value = $(e.target).val()
    $('.visit_recognitions label').each (index) ->
      if $(@).text().indexOf(value) == -1
        $(@).hide()
      else
        $(@).show()

