class Hipocrates.RailsViews.VisitsShowView extends Backbone.View
  el: 'body'

  events:
    'keyup #recognition-search': 'search'
    'keyup #procedure-search': 'search'
    'keyup #med-search': 'search'
    'change #edit_meds': 'editMeds'

  search: (e) ->
    $input = $(e.target)
    url = "#{$input.attr('data-action')}?utf8=%E2%9C%93&search=#{$input.val()}"
    $.get url, null, null, "script"

  searchProcedures: (e) ->
    value = $(e.target).val().toLowerCase()
    if value.length > 2 then @searchBase('procedures', value) else @hideBase('procedures')

  editMeds: (e) ->
    meds = []
    $form = $('#edit_meds')
    $form.find("input:checked").each (index) ->
      meds.push($(@).val())
    if $form.attr('action')? and $form.serialize()?
      $.ajax({url: $form.attr('action'), type: "PUT", data: { visit: { med_ids: meds } } })

