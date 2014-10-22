(function(){

  'use strict';

  $(document).ready(initialize);

  function initialize(){
    $(window).resize(resizing);
    positionHeads();
  }

  function resizing() {
  }

  function positionHeads() {
    var folds = $('[class^="fold"]');
    _.each(folds, function(fold){
      if($(fold).hasClass('foldC')){
        $(fold).css('left', '25%');
      }
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
