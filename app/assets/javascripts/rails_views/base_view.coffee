class Hipocrates.RailsViews.BaseView extends Backbone.View
  el: 'body'

  events:
    'click .nav-tabs a': 'activateTab'

  initialize: () ->

  activateTab: (e) ->
    e.preventDefault()
    $('.nav-tabs li').removeClass('active')
