// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
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

$(function() {
  $(".timepicker").timepicker({
    "closeOnWindowScroll": true,
    "disableTextInput":    true,
    "selectOnBlur":        true,
    "timeFormat":          "H:i",
    "show2400":            true,
    "step":                15
  });

  $(".enable-list label input").click(function(){
    $(".enable-list label").removeClass("selected");
    $(this).parent("label").addClass("selected");
    $(this).attr("checked", "checked");
    if ($(this).val() == "true"){
      $("#system_config_base_overtime_rest_start_time").attr("disabled", false);
      $("#system_config_base_overtime_rest_end_time").attr("disabled", false);
    } else {
      $("#system_config_base_overtime_rest_start_time").attr("disabled", true);
      $("#system_config_base_overtime_rest_end_time").attr("disabled", true);
    }
  });
});


function top_page() {
  location.href = Routes.top_index_path();
  return false;
}
