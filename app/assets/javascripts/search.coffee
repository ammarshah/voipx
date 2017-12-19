$ ->
  $('#search_breakout').on 'input propertychange', ->
    $('#search_destination').val ''
    $('#search_breakout_id').val ''
    return
  
  $('#search_destination').on 'input propertychange', ->
    $('#search_breakout').val ''
    $('#search_breakout_id').val ''
    return