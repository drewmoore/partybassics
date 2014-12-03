(function(){
  'use strict';

  $(document).ready(initialize);

  function initialize(){
    $('#event-select').change(selectEvent);
  }

  function selectEvent(){
    var eventId = $('#event-select').val();
    var url = '/purchases/per-event/' + eventId.toString();
    $.ajax({url: url, type: 'get', success: function(){}});
  }

})();
