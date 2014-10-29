(function(){

  'use strict';

  $(document).ready(initialize);

  function initialize(){
    initializeEventHandlers();
    positionHeadsOneColumnCenter();
  }

  function initializeEventHandlers() {
    $('#three-column').click(positionHeadsThreeColumns);
    $('#panorama-column').click(positionHeadsPanorama);
    $('.content-panel').mouseenter(tryptGlow);
    $('.content-panel').mouseleave(tryptFade);
  }

  function positionHeadsOneColumnCenter() {
    /*
    $('#folds-container').removeClass('full-screen');
    $('#folds-container').addClass('two-thirds-screen');
    $('#folds-container').css('left', '33%');
    $('div[class^="panel"]').width('100%');
    */
    $('div[class^="fold"]').css('left', '33%');
    $('div[class^="panel"]').width('75%');

  }

  function positionHeadsThreeColumns() {
    //$('#folds-container').removeClass('two-thirds-screen');
    //$('#folds-container').addClass('full-screen');
    //$('#folds-container').css('left', '0%');
    $('div[class^="panel"]').animate({'width':'33%'});
    var folds = $('[class^="fold"]');
    $('.foldL').animate({'left': '0%'}, 1500);
    $('.foldC').animate({'left': '25%'}, 1500);
    $('.foldR').animate({'left': '50%'}, 1500);
    _.each(folds, function(fold){
      var $left = $(fold).find('.panelL');
      var $center = $(fold).find('.panelC');
      var $right = $(fold).find('.panelR');
      //var viewWidth = $(fold).width();

      //var panelWidth = $center.width();
      //var centerLeftAnchor = (viewWidth / 2) - (panelWidth / 2);
      //var leftAnchor = centerLeftAnchor - (panelWidth * 0.33);
      //var centerRightAnchor = (viewWidth / 2) + (panelWidth / 2);
      //var rightAnchor = centerRightAnchor - (panelWidth * 0.66);

      $left.css('left', '25%');
      $center.css('left', '37%');
      $right.css('left', '50%');
    });


    //console.log('positionHeads: ', centerLeftAnchor, centerRightAnchor);
  }

  function positionHeadsPanorama(){
    //$('#folds-container').removeClass('two-thirds-screen');
    //$('#folds-container').addClass('full-screen');
    //$('#folds-container').animate({'left': '0%'});
    $('.foldL').animate({'left': '0%'}, 1500);
    $('.foldC').animate({'left': '25%'}, 1500);
    $('.foldR').animate({'left': '50%'}, 1500);
    $('div[class^="panel"]').animate({'width':'50%'});
    var folds = $('[class^="fold"]');
    _.each(folds, function(fold){
      var $left = $(fold).find('.panelL');
      var $center = $(fold).find('.panelC');
      var $right = $(fold).find('.panelR');
      //var viewWidth = $(fold).width();

      //var panelWidth = $center.width();
      //var centerLeftAnchor = (viewWidth / 2) - (panelWidth / 2);
      //var leftAnchor = centerLeftAnchor - (panelWidth * 0.33);
      //var centerRightAnchor = (viewWidth / 2) + (panelWidth / 2);
      //var rightAnchor = centerRightAnchor - (panelWidth * 0.66);

      $left.css('left', '0%');
      $center.css('left', '25%');
      $right.css('left', '50%');
    });
  }

  function tryptGlow(){
    var self = this;
    if($(self).hasClass('content-heading')){
      $('[class^="trypt-bright"]').animate({'opacity': '1'}, 1000);
    }
    console.log(self);
  }

  function tryptFade(){
    if($(self).hasClass('content-heading')){
      $('[class^="trypt-bright"]').animate({'opacity': '.2'}, 1000);
    }
  }

})();
