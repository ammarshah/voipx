Utility.DashboardControls = (function() {
  function DashboardControls() {

    $('#reset-btn').click(function() {
      $('#route_destination').val('');
      $('#route_breakout').val('');
      $('#route_price').val('');
      $('#route_purchase_type').val('');
      $('#route_quality_type').val('');
      $('#route_breakout_id').val('');
      return
    });

    $("#route_breakout").on("input propertychange",function(){
      $('#route_destination').val('');
      $('#route_breakout_id').val('');
      return
    });

    $("#route_destination").on("input propertychange",function(){
      $('#route_breakout').val('');
      $('#route_breakout_id').val('');
      return
    });

    $('.match_route').click(function() {
      var data, dataset;
      dataset = this.dataset;
      data = {
        route: {
          destination: dataset.destination,
          breakout: dataset.breakout,
          price: dataset.price,
          purchase_type: dataset.purchaseType,
          quality_type: dataset.qualityType
        }
      };
      $.post('/dashboard/match_route', data);
      return
    });

    $('#send_message').click(function() {
      var message_body = document.getElementById("conversation_body");
      if (message_body && message_body.value) {
        $('#send_message').addClass('hide');
        $('#modal_loader').removeClass('hide');
        $('#new_message').submit();
      }
    });

    return this;
  }

  return DashboardControls;

})();