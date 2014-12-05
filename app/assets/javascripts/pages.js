(function() {

  'use strict';

  $(document).ready(initialize);

  function initialize() {
    $('#add-content').click(addContent);
    $('.remove-content').click(removeContent);
    $('#add-graphic').click(addGraphic);
    $('.remove-graphic').click(removeGraphic);
  }

  function addContent(event) {
    event.preventDefault();
    var pageId = $('#contents-menu').attr('data-id');
    var contentId = $('#contents-menu').val();
    $.ajax({type: 'post', url: '/pages/add-content', data: {contentId:contentId, pageId:pageId}, success: function(data){
      console.log('');
    }});
  }

  function removeContent(event) {
    event.preventDefault();
    var self = this;
    var pageId = $(self).attr('data-page-id');
    var contentId = $(self).attr('data-content-id');
    $.ajax({type: 'post', url: '/pages/remove-content', data: {contentId:contentId, pageId:pageId}, success: function(data){
      console.log('');
    }});
  }

  function addGraphic(event) {
    event.preventDefault();
    var pageId = $('#graphics-menu').attr('data-id');
    var graphicId = $('#graphics-menu').val();
    $.ajax({type: 'post', url: '/pages/add-graphic', data: {graphicId:graphicId, pageId:pageId}, success: function(data){
      console.log('');
    }});
  }

  function removeGraphic(event) {
    event.preventDefault();
    var self = this;
    var pageId = $(self).attr('data-page-id');
    var graphicId = $(self).attr('data-graphic-id');
    $.ajax({type: 'post', url: '/pages/remove-graphic', data: {graphicId:graphicId, pageId:pageId}, success: function(data){
    }});
  }
})();
