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
document.getElementById("notification-count").addEventListener("click", function() {
  fetch('notifications/read')
  document.getElementById("count-noti-badge").innerHTML = "0";
});
});