class Hipocrates.RailsViews.MedsIndexView extends Backbone.View
  el: 'body'

  events:
    'keyup #meds-search #search': 'searchMeds'

  searchMeds: (e) ->
    $input = $(e.target)
    $form = $('#meds-search')
    $.get $form.attr("action"), $form.serialize(), null, "script"
    return false
