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

    $('.match_route').click ->
      dataset = this.dataset;
      data = {destination: dataset.destination, breakout: dataset.breakout, price: dataset.price, purchase_type: dataset.purchaseType, quality_type: dataset.qualityType}
      $.post '/dashboard/match_route', data

    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return
