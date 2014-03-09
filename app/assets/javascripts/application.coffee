#= require jquery
#= require jquery_ujs
#= require jquery.ui.all
#= require bootstrap
#= require underscore
#= require backbone
#= require_self
#= require hamlcoffee
#= require_tree .

window.Hipocrates =
  RailsViews: {}

  initCurrentView: ->
    if @currentView?
      @currentView.undelegateEvents()
      @currentView = null

    viewName = $("#main_container").data("view-name")
    @currentView = new Hipocrates.RailsViews[viewName]() if Hipocrates.RailsViews[viewName]?

  initBaseView: ->
    new Hipocrates.RailsViews.BaseView()

$ ->
  Hipocrates.initBaseView()
  Hipocrates.initCurrentView()
