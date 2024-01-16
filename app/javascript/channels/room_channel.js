import consumer from "./consumer"
  const room_element = $("#room_id")
  const room_id = room_element.attr("data-room-id")
    window.subscriptions= consumer.subscriptions

    consumer.subscriptions.subscriptions.forEach((subscription) => {
      if(JSON.parse(subscription.identifier).channel == 'RomChannel')
    consumer.subscriptions.remove(subscription) })
consumer.subscriptions.create({channel: "RoomChannel",conversation_id: room_id }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    if(data.action == "create") {
      const user_element = $("#user_id")
      const user_id = Number(user_element.attr("data-user-id"))
  
      let html;
      if(user_id === data.message.user_id) {
        html = data.mine
      }
      else {
        html = data.their
      }
  
      const messageContainer = document.getElementById("message")
      messageContainer.innerHTML = messageContainer.innerHTML + html
    }

    if(data.action == "update") {
      $("#message_"+ data.mes_id).html(data.content)
      $("#seen_"+data.mes_id).html(data.status)
    }

    if(data.action == "destroy") {
      $("#delete_message_"+ data.mes_id).remove()
    }
  }
});
