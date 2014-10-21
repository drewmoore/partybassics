(function() {
  $(document).ready(initialize);

  function initialize() {
    $('#add-content').click(addContent);
    $('.remove-content').click(removeContent);
    $('#add-graphic').click(addGraphic);
    $('.remove-graphic').click(removeGraphic);
  }

  function addContent(event) {
    pageId = $('#contents-menu').attr('data-id');
    contentId = $('#contents-menu').val();
    $.ajax({type: 'post', url: '/pages/add-content', data: {contentId:contentId, pageId:pageId}, success: function(data){
      console.log('');
    }});
    event.preventDefault();
  }

  function removeContent(event) {
    var self = this;
    pageId = $(self).attr('data-page-id');
    contentId = $(self).attr('data-content-id');
    $.ajax({type: 'post', url: '/pages/remove-content', data: {contentId:contentId, pageId:pageId}, success: function(data){
      console.log('');
    }})
    event.preventDefault();
  }

  function addGraphic(event) {
    pageId = $('#graphics-menu').attr('data-id');
    graphicId = $('#graphics-menu').val();
    $.ajax({type: 'post', url: '/pages/add-graphic', data: {graphicId:graphicId, pageId:pageId}, success: function(data){
      console.log('');
    }})
    event.preventDefault();
  }

  function removeGraphic(event) {
    var self = this;
    pageId = $(self).attr('data-page-id');
    graphicId = $(self).attr('data-graphic-id');
    $.ajax({type: 'post', url: '/pages/remove-graphic', data: {graphicId:graphicId, pageId:pageId}, success: function(data){
      conole.log('');
    }});
    event.preventDefault();
  }
})();
