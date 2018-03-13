Utility.DashboardControls = (function() {
  function DashboardControls() {

    $(document).on("click", '#reset-btn', function(){
      console.log('Clicked');
      $('#route_destination').val('');
      $('#route_breakout').val('');
      $('#route_price').val('');
      $('#route_purchase_type').val('');
      $('#route_quality_type').val('');
      $('#route_breakout_id').val('');
      return
    });

    $(document).on("input propertychange", "#route_breakout", function(){
      $('#route_destination').val('');
      $('#route_breakout_id').val('');
      return
    });

    $(document).on("input propertychange", "#route_destination", function(){
      $('#route_breakout').val('');
      $('#route_breakout_id').val('');
      return
    });

    $(document).on("click", ".match_route", function(){
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
      $("#matched_routes").html('<p class="text-center">Fetching results...</p>');
      $.post('/dashboard/match_route', data);
      return
    });

    $(document).on("click", "#send_message", function(){
      var message_body = document.getElementById("conversation_body");
      if (message_body && message_body.value) {
        $('#send_message').addClass('hide');
        $('#modal_loader').removeClass('hide');
        $('#new_message').submit();
      }
    });

    $(document).on("click", "#send_breakout_request", function(){
      var destination = document.getElementById("requested_breakout_destination");
      var breakout = document.getElementById("requested_breakout_breakout");
      if (destination && destination.value && breakout && breakout.value) {
        $('#send_breakout_request').addClass('hide');
        $('#modal_loader_for_breakout_request').removeClass('hide');
        $('#new_requested_breakout').submit();
      }
    });

    return this;
  }

  return DashboardControls;

})();