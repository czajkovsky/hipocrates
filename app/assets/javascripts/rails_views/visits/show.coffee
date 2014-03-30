class Hipocrates.RailsViews.VisitsShowView extends Backbone.View
  el: 'body'

  events:
    'keyup #recognition-search': 'searchRecognitions'
    'keyup #procedure-search': 'searchProcedures'
    'keyup #med-search': 'searchMeds'
    'change #edit_meds': 'editMeds'

  initialize: () ->
    @hideBase('procedures')
    @hideBase('recognitions')

  searchRecognitions: (e) ->
    value = $(e.target).val().toLowerCase()
    if value.length > 2 then @searchBase('recognitions', value) else @hideBase('recognitions')

  searchProcedures: (e) ->
    value = $(e.target).val().toLowerCase()
    if value.length > 2 then @searchBase('procedures', value) else @hideBase('procedures')

  searchMeds: (e) ->
    $input = $(e.target)
    url = "#{$input.attr('data-action')}?utf8=%E2%9C%93&search=#{$input.val()}"
    $.get url, null, null, "script"

  editMeds: (e) ->
    meds = []
    $form = $('#edit_meds')
    $form.find("input:checked").each (index) ->
      meds.push($(@).val())
    if $form.attr('action')? and $form.serialize()?
      $.ajax({url: $form.attr('action'), type: "PUT", data: { visit: { med_ids: meds } } })

  searchBase: (search_type, value) ->
    $(".visit_#{search_type} label").each (index) ->
      if $(@).text().toLowerCase().indexOf(value) == -1 then $(@).hide() else $(@).show()

  hideBase: (to_hide) ->
    $(".visit_#{to_hide} label").hide()
