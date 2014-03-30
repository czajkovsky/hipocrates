class Hipocrates.RailsViews.VisitsShowView extends Backbone.View
  el: 'body'

  events:
    'keyup #recognition-search': 'search'
    'keyup #procedure-search': 'search'
    'keyup #med-search': 'search'
    'change #edit_meds': 'editMeds'
    'change #edit_procedures': 'editProcedures'
    'change #edit_recognitions': 'editRecognitions'

  search: (e) ->
    $input = $(e.target)
    url = "#{$input.attr('data-action')}?utf8=%E2%9C%93&search=#{$input.val()}"
    $.get url, null, null, "script"

  editBase: ($form, object_type) ->
    values = []
    $form.find("input:checked").each (index) ->
      values.push($(@).val())
    if $form.attr('action')?
      if object_type == 'meds'
        $.ajax({url: $form.attr('action'), type: "PUT", data: { visit: { med_ids: values } } })
      if object_type == 'recognitions'
        $.ajax({url: $form.attr('action'), type: "PUT", data: { visit: { recognition_ids: values } } })
      if object_type == 'procedures'
        $.ajax({url: $form.attr('action'), type: "PUT", data: { visit: { procedure_ids: values } } })

  editMeds: (e) ->
    $form = $('#edit_meds')
    @editBase($form, 'meds')

  editRecognitions: (e) ->
    $form = $('#edit_recognitions')
    @editBase($form, 'recognitions')

  editProcedures: (e) ->
    $form = $('#edit_procedures')
    @editBase($form, 'procedures')
