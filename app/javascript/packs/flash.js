console.log('flash')
document.addEventListener('turbolinks:load', function() {
  var flashMessage = document.getElementById('my-flash');
  console.log('flash')

  if (flashMessage) {
    setTimeout(function() {
      flashMessage.style.display = 'none';
    }, 5000);
  }
});