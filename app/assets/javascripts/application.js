// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require rails-ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  $('.dark').on('click', function(event){
    event.preventDefault();
    var $thingClicked = $(this);
    var myUrl = $thingClicked.parent().attr('action');
    var myType = $thingClicked.parent().attr('method');

    $.ajax({
      url: myUrl,
      type: myType,
    })
    .done(function(response) {
      $thingClicked.hide();
      $thingClicked.closest('div').append(response);
    })
    .fail(function() {
      alert("error");
    })
  })

  $('#stable').on('click', '#horse-submit', function(event){
    event.preventDefault();

    var $thisForm = $(this).closest('#new-horse-form');
    var myUrl = $thisForm.attr('action');
    var myType = $thisForm.attr('method');
    var myData = $thisForm.serialize();
    // console.log(myData)
    $.ajax({
      url: myUrl,
      type: myType,
      data: myData,
    })
    .done(function(response) {
      $thisForm.siblings('.list').append(response)
      $thisForm.find('#horse-name').val("")
      $thisForm.find('#horse-age').val("")
      $thisForm.find('#horse-breed').val("")
    })
    .fail(function() {
      alert("error");
    })
  })

  $('#stable').on('click', '.light-link', function(event){
    // have you invoked preventDefault when testing
    event.preventDefault();

    var $thingClicked = $(this);
    var myUrl = $thingClicked.attr('href');
    // var asdf = $thingClicked.closest('li').find('.horse-details').removeClass()
    // console.log(asdf)

    $.ajax({
      url: myUrl,
      type: 'GET',
    })
    .done(function(jResponse) {
      $thingClicked.after(jResponse)
      // $('.horse-details').remove();
      // var miniForm = "<div>hi</div>" + jResponse.name
      // $thingClicked.after(miniForm)
    })
    .fail(function() {
      alert("error");
    })
  })

});
