window.App ||= {}
class App.Breakouts extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    $('.breakout_parent_input').bind 'input', ->
      $(this).closest('form').submit()
    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return
