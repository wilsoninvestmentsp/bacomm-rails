$(document).on('turbolinks:load', function() {
  $('.toggle-ba').on("click", function(){
    $('.li-class').toggleClass('active');
    var url = $(this).data('url')
    $.ajax({url: url, dataType: 'script', success: function(result){
    }});
  });
});