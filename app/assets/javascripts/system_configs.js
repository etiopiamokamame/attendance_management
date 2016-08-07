$(function() {
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
