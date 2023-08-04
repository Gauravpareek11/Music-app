import consumer from '../channels/consumer'
document.addEventListener('turbolinks:load', () => {
  const conversationId = document.getElementById('conversation').dataset.conversationId;
  const messageInput = document.getElementById('message_body');
  const messagesContainer = document.getElementById('messages');
  const messageForm=document.getElementById('form')

  if (messageForm) {
    console.log('form')
    messageForm.addEventListener('submit', (event) => {
      event.preventDefault();
      
      const formData = new FormData(messageForm);
      
      fetch(messageForm.action, {
        method: messageForm.method,
        body: formData
      })
      .then(response => {
        if (response.ok) {
        } else {
        }
      })
      .catch(error => {
      });
    });
  }

  consumer.subscriptions.create(
      { channel: 'ChatChannel', conversation_id: conversationId },
      {
        connected(){
          console.log("Connected to server")
        },
        received: function (data) {
          messagesContainer.insertAdjacentHTML('beforeend', `<p><strong>${data.sender}</strong>: ${data.message}</p>`);
          const messageInput = document.querySelector("#chat_message")
          messageInput.value = ""
          
          const submitButton = document.querySelector("#message_submit")
          submitButton.disabled = false
          messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }
      }
    );
});
