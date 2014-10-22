(function(){

  'use strict';

  $(document).ready(initialize);

  function initialize(){
    $(window).resize(resizing);
    //positionHeadsThreeColumns();
    positionHeadsOneColumnCenter();
  }

  function resizing() {
  }

  function positionHeadsOneColumnCenter() {
    //$('div[class^="fold"] div[class^="panel"]').css('position', 'static');
    $('#folds-container').removeClass('full-screen');
    $('#folds-container').addClass('three-quarters-screen');
    $('#folds-container').css('left', '33%');
    $('div[class^="panel"]').width('100%');
    //$('div[class^="fold"]]').css('left': '25%')
  }

  function positionHeadsThreeColumns() {
    $('div[class^="panel"]').width('33%');
    var folds = $('[class^="fold"]');
    $('.foldC').animate({'left': '25%'}, 1500);
    $('.foldR').animate({'left': '50%'}, 1500);
    _.each(folds, function(fold){
      //var $left = $($('.panelL')[0]);
      var $left = $(fold).find('.panelL');
      //var $center = $($('.panelC')[0]);
      var $center = $(fold).find('.panelC');
      //var $right = $($('.panelR')[0]);
      var $right = $(fold).find('.panelR');

      //var viewWidth = $center.parent().width();
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

})();
