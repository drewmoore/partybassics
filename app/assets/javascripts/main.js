(function(){

  'use strict';

  $(document).ready(initialize);

  function initialize(){
    $(window).resize(resizing);
    //positionHeadsThreeColumns();
    //positionHeadsOneColumnCenter();
    positionHeadsPanorama();
  }

  function resizing() {
  }

  function positionHeadsOneColumnCenter() {
    $('#folds-container').removeClass('full-screen');
    $('#folds-container').addClass('three-quarters-screen');
    $('#folds-container').css('left', '33%');
    $('div[class^="panel"]').width('100%');
  }

  function positionHeadsThreeColumns() {
    $('div[class^="panel"]').width('33%');
    var folds = $('[class^="fold"]');
    $('.foldC').animate({'left': '25%'}, 1500);
    $('.foldR').animate({'left': '50%'}, 1500);
    _.each(folds, function(fold){
      var $left = $(fold).find('.panelL');
      var $center = $(fold).find('.panelC');
      var $right = $(fold).find('.panelR');
      var viewWidth = $(fold).width();

      var panelWidth = $center.width();
      var centerLeftAnchor = (viewWidth / 2) - (panelWidth / 2);
      var leftAnchor = centerLeftAnchor - (panelWidth * 0.33);
      var centerRightAnchor = (viewWidth / 2) + (panelWidth / 2);
      var rightAnchor = centerRightAnchor - (panelWidth * 0.66);

      $center.css('left', centerLeftAnchor.toString() + 'px');
      $left.css('left', leftAnchor.toString() + 'px');
      $right.css('left', rightAnchor.toString() + 'px');
    });


    //console.log('positionHeads: ', centerLeftAnchor, centerRightAnchor);
  }

  function positionHeadsPanorama(){
    $('div[class^="panel"]').width('50%');
    var folds = $('[class^="fold"]');
    $('.foldL').animate({'left': '0%'}, 1500);
    $('.foldC').animate({'left': '25%'}, 1500);
    $('.foldR').animate({'right': '0%'}, 1500);
    _.each(folds, function(fold){
      var $left = $(fold).find('.panelL');
      var $center = $(fold).find('.panelC');
      var $right = $(fold).find('.panelR');
      var viewWidth = $(fold).width();

      var panelWidth = $center.width();
      var centerLeftAnchor = (viewWidth / 2) - (panelWidth / 2);
      var leftAnchor = centerLeftAnchor - (panelWidth * 0.33);
      var centerRightAnchor = (viewWidth / 2) + (panelWidth / 2);
      var rightAnchor = centerRightAnchor - (panelWidth * 0.66);

      $center.css('left', centerLeftAnchor.toString() + 'px');
      $left.css('left', leftAnchor.toString() + 'px');
      $right.css('left', rightAnchor.toString() + 'px');
    });
  }

})();
