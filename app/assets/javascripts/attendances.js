// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
  var vm = {};

  for (i=1; i<=31; i++) {
    vm["workStartTime" + i] = ko.observable($("#work_start_time" + i).val());
    vm["workEndTime" + i]   = ko.observable($("#work_end_time" + i).val());
    vm["workingTime" + i]   = ko.computed({
      read: function(){
        return 1;
        // return Math.floor(this.price() * (1 + this.tax() / 100));;
      },
      write: function(newValue){
        // this.price(Math.floor(Number(newValue) / (1 + this.tax() / 100)));
      },
      owner: vm
    });
  }

  ko.applyBindings(vm);
});

function get_attendance(date) {
  var attendanceBody = $("#" + date);
  if ($(attendanceBody).hasClass("no-data")) {
    $(attendanceBody).removeClass("no-data");
    $.post("/attendances/specific_month", { "date": date } );
  }
}

function set_reason(day, content) {
  $("#reason" + day).val(content);
  return false;
}

