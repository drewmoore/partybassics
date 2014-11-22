(function(){

  'use strict';

  $(document).ready(initialize);

  function initialize(){
    initializeEventHandlers();
    positionHeadsOneColumnCenter();
  }

  function initializeEventHandlers() {
    $('.three-column-button').click(positionHeadsThreeColumns);
    $('.panorama-column-button').click(positionHeadsPanorama);
    $('.content-footer').mouseenter(tryptGlow);
    $('.content-footer').mouseleave(tryptFade);
    $('#facebook-event').click(getFacebookEvent);
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

  function positionHeadsPanorama(){
    $('.foldL').animate({'left': '0%'}, 1500);
    $('.foldC').animate({'left': '25%'}, 1500);
    $('.foldR').animate({'left': '50%'}, 1500);
    $('div[class^="panel"]').animate({'width':'50%'});
    var folds = $('[class^="fold"]');
    _.each(folds, function(fold){
      var $left = $(fold).find('.panelL');
      var $center = $(fold).find('.panelC');
      var $right = $(fold).find('.panelR');
      $left.css('left', '0%');
      $center.css('left', '25%');
      $right.css('left', '50%');
    });

    $.ajax({type: 'get', url: 'events/display', success: sizeEvents});
    $(window).bind('resize', sizeEvents);
  }

  function sizeEvents() {

    $('.arrow-container').bind('click', eventsScroll);

    var $scrollWindow = $('#events-scroll-window');
    var screenWidth = window.screen.width;
    var viewportWidth = window.innerWidth;
    var viewportWidthRatio = viewportWidth / screenWidth;
    var widthRatio = 0.0;
    if(viewportWidthRatio < 0.5){
      widthRatio = 0.75;
    } else {
      widthRatio = 0.33;
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
    var safetyMargin = newCellWidth + (marginPerSide * 2);
    var newPanelWidth = widthNeeded + (marginPerSide * (cellCount * 2)) + safetyMargin;
    $scrollPanel.css('width', newPanelWidth.toString());
    $cells.css('margin', '0px ' + (marginPerSide * 2).toString() + 'px');
    $cells.css('width', newCellWidth.toString());
    $cells.css('height', newCellHeight.toString());
  }

  function eventsScroll() {
    var $self = $(this);
    var id = $self.attr('id');
    var $scrollPanel = $('#events-scroll-panel');
    var side = '';
    _.each(id.split('-'), function(str){
      if(str === 'left'){ side = 'left';}
      if(str === 'right'){ side = 'right';}
    });
    var moveRatio = 0.2;
    var leftPosition = parseFloat($scrollPanel.css('left').split('p')[0]);
    var amountToMove = (leftPosition - ($scrollPanel.width() * moveRatio)).toString();
    var moveTime = 1000;
    if(side === 'left'){
      //$scrollPanel.animate({'left': '-20%'}, 1500);
      $scrollPanel.animate({'left': amountToMove + 'px'}, moveTime);
      //$('.foldL').animate({'left': '0%'}, 1500);
    }

    //debugger;

    console.log('eventsScroll: ', 'amountToMove: ', amountToMove);
  }


  function tryptGlow(){
    var self = this;
    if($(self).hasClass('content-heading') || $(self).hasClass('content-footer')){
      $('[class^="trypt-bright"]').animate({'opacity': '1'}, 1000);
    }
  }

  function tryptFade(){
    var self = this;
    if($(self).hasClass('content-heading') || $(self).hasClass('content-footer')){
      $('[class^="trypt-bright"]').animate({'opacity': '.2'}, 1000);
    }
  }

  function getFacebookEvent(event){
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
    event.preventDefault();
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
