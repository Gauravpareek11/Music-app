import consumer from '../channels/consumer'
document.addEventListener('turbolinks:load', () => {
  const senderId = document.getElementById('sender').dataset.senderId;
  const messageForm=document.getElementsByClassName('noti-form');
  const messagesContainer=document.getElementById('notifications');
  Array.from(messageForm).forEach(function(form) {
      form.addEventListener('submit', (event) => {
        event.preventDefault();
        
        const formData = new FormData(form);
        
        fetch(form.action, {
          method: form.method,
          body: formData
        })
        .then(response => {
          if (response.ok) {
            console.log('hi')
            var flashDiv = document.createElement('div');
            flashDiv.classList.add('flash-notice');
            flashDiv.textContent = 'Thanks for showing your interest';
            document.body.appendChild(flashDiv);
            console.log(flashDiv)
            setTimeout(function() {
              flashDiv.parentNode.removeChild(flashDiv);
            }, 5000);
          } else {
            var flashDiv = document.createElement('div');
            flashDiv.classList.add('flash-notice');
            flashDiv.textContent = 'Try again later';
            document.body.appendChild(flashDiv);
            console.log(flashDiv)
            setTimeout(function() {
              flashDiv.parentNode.removeChild(flashDiv);
            }, 5000);
          }
        })
        .catch(error => {
        });
      });
    });

  consumer.subscriptions.create(
      { channel: 'NotificationChannel', sender_id: senderId },
      {
        connected(){
          console.log("Connected to server")
        },
        received: function (data) {
          const noNoti=document.getElementById('no-notification');
          if(noNoti !== null){
            console.log(noNoti)
            noNoti.remove()
          }
          messagesContainer.insertAdjacentHTML('beforeend', `<p>Hi I am Interested in your post</p>Name->${data['message'].name} Email->${data['message'].email}</p>`);
          var counterElement = document.getElementById('count-noti-badge')
          var counter = parseInt(counterElement.textContent)
          counter +=1
          counterElement.textContent = counter;
        },
        speak: function (message) {
          return this.perform('receive', { sender_id: senderId,recipient_id: recieverId, message: message });
        }
      }
    );
});