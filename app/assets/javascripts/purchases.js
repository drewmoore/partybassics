(function(){
  'use strict';

  $(document).ready(initialize);

  function initialize(){
    $('#event-select').change(selectEvent);
    $('#email-search-button').click(searchByEmail);
    $('#conf-search-button').click(searchByConf);
    $('#lastfour-search-button').click(searchByLastFour);
    $('#event-search-reset').click(searchReset);
  }

  function selectEvent(){
    var eventId = $('#event-select').val();
    var url = '/purchases/per-event/' + eventId.toString();
    $.ajax({url: url, type: 'get', success: function(){
      $('#email-search-button').attr('data-event-id', eventId);
      $('#conf-search-button').attr('data-event-id', eventId);
      $('#lastfour-search-button').attr('data-event-id', eventId);
    }});
  }

  function searchByEmail(event){
    var $self = $(this);
    var eventId = $self.attr('data-event-id');
    var searchString = $('#email-search-field').val();
    if(eventId){
      var url = '/purchases/per-event/' + eventId.toString() + '/email/' + searchString;
      $.ajax({url: url, type: 'get', success: function(){}});
    }
    event.preventDefault();
  }

  function searchByConf(event){
    var $self = $(this);
    var eventId = $self.attr('data-event-id');
    var searchString = $('#conf-search-field').val();
    if(eventId){
      var url = '/purchases/per-event/' + eventId.toString() + '/conf/' + searchString;
      $.ajax({url: url, type: 'get', success: function(){}});
    }
    event.preventDefault();
  }

  function searchByLastFour(event){
    var $self = $(this);
    var eventId = $self.attr('data-event-id');
    var searchString = $('#lastfour-search-field').val();
    if(eventId){
      var url = '/purchases/per-event/' + eventId.toString() + '/lastfour/' + searchString;
      $.ajax({url: url, type: 'get', success: function(){}});
    }
    event.preventDefault();
  }

  function searchReset(event){
    $('#email-search-field').val('');
    $('#conf-search-field').val('');
    selectEvent();
    event.preventDefault();
  }

})();
