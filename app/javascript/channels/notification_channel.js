import consumer from '../channels/consumer'
console.log('hi')
document.addEventListener('turbolinks:load', () => {
  console.log('hi')
  const recieverId = document.getElementById('reciever').dataset.recieverId;
  const senderId = document.getElementById('sender').dataset.senderId;
  const messageForm=document.getElementById('noti-form');
  const messagesContainer=document.getElementById('notifications');
  console.log(messagesContainer)

  if (messageForm) {
    console.log('form')
    messageForm.addEventListener('submit', (event) => {
      event.preventDefault(); // Prevent the default form submission
      
      const formData = new FormData(messageForm);
      
      fetch(messageForm.action, {
        method: messageForm.method,
        body: formData
      })
      .then(response => {
        if (response.ok) {
          // Handle successful form submission
          // You can update the chat interface or perform any other necessary actions
          const submitButton = document.querySelector("#notification_submit")
          submitButton.disabled = false
        } else {
          // Handle form submission error
        }
      })
      .catch(error => {
        // Handle any network or JavaScript error
      });
    });
  }

  consumer.subscriptions.create(
      { channel: 'NotificationChannel', sender_id: senderId },
      {
        connected(){
          console.log("Connected to server")
        },
        received: function (data) {
          messagesContainer.insertAdjacentHTML('beforeend', `<p><strong>${data.sender_id}</strong>: ${data['message']}</p>`);
          // const messageInput = document.querySelector("#chat_message")
          // messageInput.value = ""
          console.log(data)
          // recieverId=data['recipient_id']
          // console.log()
          // consumer.subscriptions.subscriptions[0].speak(data['message']);
        },
        speak: function (message) {
          // console.log(message)
          return this.perform('receive', { sender_id: senderId,recipient_id: recieverId, message: message });
        }
      }
    );
});