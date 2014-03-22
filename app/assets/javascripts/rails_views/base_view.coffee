class Hipocrates.RailsViews.BaseView extends Backbone.View
  el: 'body'

  events:
    'click .nav-tabs a': 'activateTab'
    'change #visit_speciality_id': 'updateSelect'

  initialize: () ->
    @disableDoctors()

  activateTab: (e) ->
    e.preventDefault()
    $('.nav-tabs li').removeClass('active')

  updateSelect: (e) ->
    @disableDoctors()
    value = $(e.target).val()
    $('#visit_doctor_id option').each () ->
      if $(@).attr('data-spec')? and $(@).attr('data-spec').indexOf(value) != -1
        $(@).prop('disabled', false)

  disableDoctors: () ->
    $('#visit_doctor_id option').prop('disabled', true)
