$ ->
  # enable chosen js
  $('.chosen').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '100%'

  setInterval (->
    $('#unread-messages-count').load '/dashboard/unread_messages_count'
    return
  ), 3000
  return