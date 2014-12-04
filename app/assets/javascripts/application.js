// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

var preview = function() {
  width = $('#wiki_body').css("width");
  height = $('#wiki_body').css("height");
  $('.output').css({"width": width,
                    "height": height});

  $('#preview').on('click', function(){
    $.post("/markdown_previews", { text: $('#wiki_body').val() }, function(data) {
      $('.output').html(data);
    });
  });

  $('#user-profile').show();
  $('#user-password').hide();

  $('#item-profile').on('click', function() {
    $('#user-profile').show();
    $('#user-password').hide();
  });

  $('#item-password').on('click', function() {
    $('#user-profile').hide();
    $('#user-password').show();
  });
};

$(document).ready(preview);
$(document).on('page:load', preview);
