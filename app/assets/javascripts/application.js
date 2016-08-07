// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
// require_tree .
//= require js-routes
//= require jquery.timepicker.js
//= require jquery.ui.core
//= require jquery.ui.datepicker
//= require jquery.ui.all
//= require jquery.ui.datepicker-ja

$(function() {
  $(".timepicker").timepicker({
    "closeOnWindowScroll": true,
    "disableTextInput":    true,
    "selectOnBlur":        true,
    "timeFormat":          "H:i",
    "show2400":            true,
    "step":                15
  });

  $(".datepicker").datepicker({
    "dateFormat": 'yy年mm月dd日'
  })
});

function top_page() {
  location.href = Routes.top_index_path();
  return false;
}

function toggle_sidebar(){
  var elmSideMenuTitles = $(".side-menu .side-content .title");
  var elmContent        = $(".content");
  var elmSideMenu       = $(".side-menu");
  var elmHeaderContent  = $(".header-menu .header-content");

  if (elmSideMenuTitles.first().css("display") == "inline-block"){
    elmSideMenuTitles.hide();
    elmContent.animate({"margin-left": "30px"}, "slow");
    elmSideMenu.animate({ "width": "30px" }, "slow");
    elmHeaderContent.animate({ "margin-left": "30px" }, "slow").promise().done(function () {
      elmContent.switchClass("active", "disable");
      elmSideMenu.switchClass("active", "disable");
      elmHeaderContent.switchClass("active", "disable");
      elmSideMenuTitles.switchClass("active", "disable");
    });
  } else {
    elmContent.animate({"margin-left": "250px"}, "slow");
    elmSideMenu.animate({ "width": "250px" }, "slow");
    elmHeaderContent.animate({ "margin-left": "250px" }, "slow").promise().done(function () {
      elmSideMenuTitles.show();
      elmSideMenuTitles.attr("style", "");
      elmContent.switchClass("disable", "active");
      elmSideMenu.switchClass("disable", "active");
      elmHeaderContent.switchClass("disable", "active");
      elmSideMenuTitles.switchClass("disable", "active");
    });
  }
}
