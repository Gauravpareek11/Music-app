// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap/dist/js/bootstrap.bundle.min'
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
document.addEventListener("DOMContentLoaded", function() {
  console.log(document.getElementById("notification-count"))
document.getElementById("mark-read").addEventListener("click", function() {
  fetch('notifications/read')
  document.getElementById("notifications").innerHTML = "";
  document.getElementById("count-noti-badge").innerHTML = "0";
  const noNoti=document.getElementById('no-notification');
  if(noNoti !== null){
    console.log(noNoti)
    noNoti.remove()
  }
  const divElement = document.createElement('div');
  divElement.setAttribute('id', 'no-notification');

  const h1Element = document.createElement('h1');
  const h1Text = document.createTextNode('No Notification to show');
  h1Element.appendChild(h1Text);
  divElement.appendChild(h1Element);
  const bodyElement = document.getElementById("noti-container");
  bodyElement.appendChild(divElement);
});
});