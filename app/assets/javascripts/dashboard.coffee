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

    $('#messageModal').on 'shown.bs.modal', (e) ->
      profile_url = $(e.relatedTarget).data('profile-url')
      photo_url = $(e.relatedTarget).data('photo-url')
      name = $(e.relatedTarget).data('name')
      purchase_sentence = $(e.relatedTarget).data('purchase-sentence')
      destination = $(e.relatedTarget).data('destination')
      breakout = $(e.relatedTarget).data('breakout')
      price = $(e.relatedTarget).data('price')
      quality_type = $(e.relatedTarget).data('quality-type')
      recipient_id = $(e.relatedTarget).data('recipient')
      subject = $(e.relatedTarget).data('subject')


      $("#match_profile_url").attr("href", profile_url);
      $("#match_photo_url").attr("src", photo_url);
      $("#match_name").html(name);
      $("#match_purchase_sentence").html(purchase_sentence);
      $("#match_destination").html(destination);
      $("#match_breakout").html(breakout);
      $("#match_price").html(price);
      $("#match_quality_type").html(quality_type);


      $("#conversation_recipient").val(recipient_id);
      $("#conversation_subject").val(subject);

    $('#send_message').click ->
      $("#new_message").submit();

    return


  show: =>
    return


  new: =>
    return


  edit: =>
    return
