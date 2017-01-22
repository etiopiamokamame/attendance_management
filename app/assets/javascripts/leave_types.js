// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
  $(".sortable").sortable({
    axis:    "y",
    opacity: 0.5,
    handle:  ".handle",
    update: function(e, ui) {
      update_order(ui);
    }
  });
});

function update_order(ui) {
  $(".overlay").removeClass("hide");
  var item        = ui.item;
  var item_data   = item.data();
  var params      = {};
  params.position = item.index();

  $.ajax({
    type:     "POST",
    url:      item_data.update_url,
    dataType: "json",
    data:     params,
    success: function(res){
      if (res.result == true) {
        $(".overlay").addClass("hide");
      } else {
        update_order(ui);
      }
    }
  });
}
