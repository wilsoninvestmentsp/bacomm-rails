BaComm = {};
BaComm.Events = {
  loadMoreEvents: function(){
    $('#load_more_events').on('click', function(){
      debugger;
      if($('#next_page').val()){
        $.ajax({
          url: '/more_events',
          data: {offset: $('#next_page').val()},
          dataType: 'script'
        });
      }
    });
  },
  clickableEvent: function(){
    $('#event-listing').on('click', '.event_list', function(){
      window.open($(this).children('#event_url').val(), '_blank');
    });
  },
  documentOnReady: function(){
    this.loadMoreEvents();
    this.clickableEvent();
  },
  pageLoad: function () {
    BaComm.Events.documentOnReady();
  }
}
$(document).ready(function(){
  BaComm.Events.documentOnReady();
});
$(document).on('page:load', function(){
  BaComm.Events.pageLoad();
});