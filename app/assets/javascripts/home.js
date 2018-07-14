$(document).on('turbolinks:load', function() {
  $('.toggle-ba').on("click", function(){
    $('.li-class').toggleClass('active');
  });
});