$ ->
  # enable chosen js
  $('.chosen').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '100%'

  # setInterval (->
  #   $('#unread-messages-count').load '/dashboard/unread_messages_count'
  #   return
  # ), 3000

  # Toggle event for Search Route form in the header
  $('.header .logo-search .search-header a').click ->
    $(this).toggleClass 'active'
    $('.search-drop-header').slideToggle 'slow', ->
      # Animation complete.
      return
    return

  $('#search_navbar_breakout').on 'input propertychange', ->
    $('#search_navbar_destination').val ''
    $('#search_navbar_breakout_id').val ''
    return
  
  $('#search_navbar_destination').on 'input propertychange', ->
    $('#search_navbar_breakout').val ''
    $('#search_navbar_breakout_id').val ''
    return