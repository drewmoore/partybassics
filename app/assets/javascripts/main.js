(function(){

  'use strict';
  var arrowColorRested;

  $(document).ready(initialize);


  function initialize(){
    initializeEventHandlers();
    positionHeadsOneColumnCenter();
    if($('#from-controller').val() === 'welcome'){
      window.onpopstate = onPop;
      saveState({caller: 'initialize'});
    }
  }

  function initializeEventHandlers() {
    $('.three-column-button').click(threeColumnButtonClick);
    $('.panorama-column-button').click(panoramaColumnButtonClick);
    $('.content-footer').mouseenter(tryptGlow);
    $('.content-footer').mouseleave(tryptFade);
    $('#facebook-event').click(getFacebookEvent);
  }

  function saveState(state){
    if($('#from-controller').val() === 'welcome'){
      window.history.pushState(state, '', '');
    }
  }

  function originalState(){
    window.location.reload();
  }

  function onPop(event){
    var pageStates = {
      initialize:originalState,
      getWelcomeAbout:getWelcomeAbout,
      getEventsDisplay:getEventsDisplay,
      displayEvent:displayEvent
    };
    // Only apply if the event state is a function relevant to the customer interface.
    if(event && pageStates[event.state.caller]){
      if(event.state.data){
        pageStates[event.state.caller](event, event.state.data);
      } else {
        pageStates[event.state.caller]();
      }
    } else if(history.state.caller !== 'initialize'){
      window.history.back();
    }
  }

  function threeColumnButtonClick(){
    saveState({caller: 'getWelcomeAbout'});
    $('#content-body').empty();
    getWelcomeAbout();
  }

  function getWelcomeAbout(){
    tryptGlow();
    positionHeadsThreeColumns();
    $.ajax({url: '/about-us', type: 'get', success: receiveWelcomeAbout});
    $(window).bind('resize', sizeEvents);
  }

  function receiveWelcomeAbout(){
    sizeThaEvent();
    tryptFade();
  }

  function panoramaColumnButtonClick(){
    saveState({caller: 'getEventsDisplay'});
    $('#content-body').empty();
    getEventsDisplay();
  }

  function getEventsDisplay(){
    positionHeadsPanorama(function(){
      $.ajax({type: 'get', url: 'events/display', success: receiveEvents});
    });
    $(window).unbind('resize');
    $(window).bind('resize', sizeEvents);
  }

  function receiveEvents() {
    $('.arrow-container').bind('click', eventsScroll);
    $('.event-flyer').bind('click', displayEvent);
    $('.event-flyer').bind('mouseover', eventMouseOver);
    $('.event-flyer').bind('mouseout', eventMouseOut);
    arrowColorRested = $('#events-arrow-left').css('border-right-color');
    sizeEvents(function(){
      scrollToCurrent(function(){
        tryptFade();
      });
    });
  }

  function displayEvent(event, stateData){
    // receives HTML from events#display_one and its partial
    $('#content-body').empty();
    tryptGlow();
    positionHeadsThreeColumns();
    var $self = $(this);
    var $cell = $self.closest('.event-cell');
    var url;
    if(stateData){
      url = '/events/display-one/' + stateData.id;
    } else {
      url = '/events/display-one/' + $cell.attr('data-id');
      saveState({caller: 'displayEvent', data: {id: $cell.attr('data-id')}});
    }
    $.ajax({url:url, type:'get', success: function(){
      sizeThaEvent();
      tryptFade();
    }});
    $(window).unbind('resize');
    $(window).bind('resize', sizeThaEvent);
  }

  function scrollToCurrent(callback){
    var $cells = $('.event-cell');
    var currentId = $cells.attr('data-current');
    var $currentEvent;
    _.each($cells, function(cell){
      var cellId = $(cell).attr('data-id');
      if(cellId === currentId){
        $currentEvent = $(cell);
      }
    });
    var position = $currentEvent.position().left - ($cells.width() / 2);
    var scrollTime = 500;
    $('#events-scroll-window').scrollTo(position, 0, {duration: scrollTime, onAfter: callback});
  }

  function positionHeadsOneColumnCenter() {
    $('div[class^="fold"]').css('left', '33%');
    $('div[class^="panel"]').width('75%');
  }

  function positionHeadsThreeColumns() {
    $('div[class^="panel"]').animate({'width':'33%'});
    var folds = $('[class^="fold"]');
    $('.foldL').animate({'left': '0%'}, 1500);
    $('.foldC').animate({'left': '25%'}, 1500);
    $('.foldR').animate({'left': '50%'}, 1500);
    _.each(folds, function(fold){
      var $left = $(fold).find('.panelL');
      var $center = $(fold).find('.panelC');
      var $right = $(fold).find('.panelR');
      $left.css('left', '25%');
      $center.css('left', '37%');
      $right.css('left', '50%');
    });
  }

  function positionHeadsPanorama(callback){
    $('#content-body').empty();
    tryptGlow();
    $('.foldL').animate({'left': '0%'}, 1000);
    $('.foldC').animate({'left': '25%'}, 1000);
    $('.foldR').animate({'left': '50%'}, 1000);
    var folds = $('[class^="fold"]');
    _.each(folds, function(fold){
      var $left = $(fold).find('.panelL');
      var $center = $(fold).find('.panelC');
      var $right = $(fold).find('.panelR');
      $left.css('left', '0%');
      $center.css('left', '25%');
      $right.css('left', '50%');
    });
    $('div[class^="panel"]').animate({'width':'50%'}, 1000, callback);
  }

  function eventMouseOver(){
    var $self = $(this);
    $self.closest('.event-cell').css('box-shadow', '0px 0px 10px rgba(175, 175, 175, .8)');
  }

  function eventMouseOut(){
    var $self = $(this);
    $self.closest('.event-cell').css('box-shadow', 'none');
  }


  function sizeEvents(callback) {
    var $scrollWindow = $('#events-scroll-window');
    var widthRatio;
    // Check to determine if device is in portrait or landscape orientation.
    if(isPortrait()){
      widthRatio = 0.75;
    } else {
      widthRatio = 0.50;
    }
    var windowWidth = parseFloat($scrollWindow.width());
    var windowHeight = parseFloat($scrollWindow.height());
    var $scrollPanel = $('#events-scroll-panel');
    var $cells = $('.event-cell');
    var cellCount = $cells.length;
    var heightRatio = 1.00;
    var newCellWidth = windowWidth * widthRatio;
    var newCellHeight = windowHeight * heightRatio;
    var widthNeeded = newCellWidth * cellCount;
    var marginRatio = 0.06;
    var marginPerSide = newCellWidth * marginRatio;
    var safetyMargin = (newCellWidth + (marginPerSide * 4)) * 2;
    var newPanelWidth = widthNeeded + (marginPerSide * (cellCount * 2)) + safetyMargin;
    $scrollPanel.css('width', newPanelWidth.toString());
    $cells.css('margin', '0px ' + (marginPerSide * 2).toString() + 'px');
    $cells.css('width', newCellWidth.toString());
    $cells.css('height', newCellHeight.toString());
    if(callback){callback();}
  }

  function sizeThaEvent(){
    var $contentBody = $('#content-body');
    var $eventThirds = $('.event-third');
    var $contentPanels = $('[class^="event-content"]');
    var $eventPosterFrame = $('.event-poster-frame');
    var heightRatio = 0.90;
    var panelRatio = 0.75;
    var $eventPoster = $('.event-poster');
    $eventPosterFrame.height(newHeight(heightRatio));
    $eventThirds.height(newHeight(heightRatio));
    $contentPanels.height(newHeight(panelRatio));
    if(isPortrait()){
      if($eventPoster.hasClass('portrait')){
        $eventPoster.css('background-size', '79% 70%');
      }
      if($eventPoster.hasClass('landscape')){
        $eventPoster.css('background-size', '100% 40%');
      }
    } else {
      if($eventPoster.hasClass('portrait')){
        $eventPoster.css('background-size', '53% 100%');
      }
      if($eventPoster.hasClass('landscape')){
        $eventPoster.css('background-size', '70% 60%');
      }
    }

    function newHeight(ratio){
      return (parseFloat($contentBody.height()) * ratio).toString();
    }
  }

  function isPortrait(){
    var screenWidth = window.screen.width;
    var viewportWidth = window.innerWidth;
    var viewportWidthRatio = viewportWidth / screenWidth;
    if(viewportWidthRatio < 0.5 || window.innerWidth < window.innerHeight){ return true; } else { return false; }
  }

  function eventsScroll() {
    var $self = $(this);
    var id = $self.attr('id');
    var $scrollPanel = $('#events-scroll-panel');
    var $scrollWindow = $('#events-scroll-window');
    var side;
    _.each(id.split('-'), function(str){
      if(str === 'left'){ side = 'right';}
      if(str === 'right'){ side = 'left';}
    });
    var moveRatio = 0.1;
    var amountToMove;
    var moveTime = 200;
    var flipSide;
    if(side === 'left'){
      amountToMove = '+=' + parseInt(($scrollPanel.width() * moveRatio)).toString() + 'px';
      flipSide = 'right';
    }
    if(side === 'right'){
      amountToMove = '-=' + parseInt(($scrollPanel.width() * moveRatio)).toString() + 'px';
      flipSide = 'left';
    }
    var $arrow = $('#events-arrow-' + flipSide);
    var propertyToColor = 'border-' + side + '-color';
    var arrowColorActive = $('a').css('color');
    $arrow.css(propertyToColor, arrowColorActive);

    $scrollWindow.scrollTo(amountToMove, 0, {duration: moveTime, onAfter: function(){
      $arrow.css(propertyToColor, arrowColorRested);
    }});
  }

  function tryptGlow(){
    $('[class^="trypt-bright"]').animate({'opacity': '1'}, 1500);
  }

  function tryptFade(){
    $('[class^="trypt-bright"]').animate({'opacity': '.2'}, 1500);
  }

  function getFacebookEvent(event){
    event.preventDefault();
    var facebookId = $('#event_facebook_id').val();
    FB.login(function(response){
      if(response.status === 'connected'){
        FB.api('/v2.2/' + facebookId, function(apiResponse){
          $('#event_title').val(apiResponse.name);
          $('#event_description').val(apiResponse.description);
          var date = apiResponse.start_time.split('T')[0];
          var year = date.split('-')[0];
          var month = date.split('-')[1];
          var day = date.split('-')[2];
          $('#event_date_1i option:contains(' + year + ')').prop({selected:true});
          $('#event_date_2i option:contains(' + convertToMonthString(month) + ')').prop({selected:true});
          $('#event_date_3i option:contains(' + day + ')').prop({selected:true});
          var time = apiResponse.start_time.split('T')[1];
          var hour = time.split(':')[0];
          var minute = time.split(':')[1];
          var newTime = hour + ':' + minute;
          $('#event_time').val(newTime);
          $('#event_venue').val(apiResponse.location);
          $('#event_city').val(apiResponse.venue.city);
          $('#event_street').val(apiResponse.venue.street);
          $('#event_zip').val(apiResponse.venue.zip);

        });
      }
    });
  }

  function convertToMonthString(month){
    var newMonth = '';
    switch(month){
      case '01':
        newMonth = 'January';
        break;
      case '02':
        newMonth = 'February';
        break;
      case '03':
        newMonth = 'March';
        break;
      case '04':
        newMonth = 'April';
        break;
      case '05':
        newMonth = 'May';
        break;
      case '06':
        newMonth = 'June';
        break;
      case '07':
        newMonth = 'July';
        break;
      case '08':
        newMonth = 'August';
        break;
      case '09':
        newMonth = 'September';
        break;
      case '10':
        newMonth = 'October';
        break;
      case '11':
        newMonth = 'November';
        break;
      case '12':
        newMonth = 'December';
        break;
    }
    return newMonth;
  }

})();
