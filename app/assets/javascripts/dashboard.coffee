window.App ||= {}
class App.Dashboard extends App.Base

  beforeAction: (action) =>
    return


  afterAction: (action) =>
    return


  index: =>
    
    $('#reset-btn').click ->
      # reset route form fields
      $('#route_name').val('');
      $('#breakout').val('');
      $('#route_price').val('');
      $('#route_purchase_type').val('');
      $('#route_quality_type').val('');
      $('#route_breakout_id').val('');

    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return
