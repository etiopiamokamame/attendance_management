$(function() {
  change_all_working_time();

  $(".table-attendance input.work_start_time").change(function() {
    var day   = $(this).attr("day");
    var start = $(this).val();
    var end   = $(".table-attendance input.work_end_time[day=" + day + "]").val();
    change_working_time(day, start, end);
  });

  $(".table-attendance input.work_end_time").change(function() {
    var day   = $(this).attr("day");
    var start = $(".table-attendance input.work_start_time[day=" + day + "]").val();
    var end   = $(this).val();
    change_working_time(day, start, end);
  });

  $("#attendance_display_rest_start_time").change(function() {
    change_all_working_time();
  });

  $("#attendance_display_rest_end_time").change(function() {
    change_all_working_time();
  });
});

function change_all_working_time() {
  $(".table-attendance input.work_start_time").each(function() {
    var day   = $(this).attr("day");
    var start = $(this).val();
    var end   = $(".table-attendance input.work_end_time[day=" + day + "]").val();
    change_working_time(day, start, end);
  });
}

function change_working_time(day, start, end) {
  if (start != "" && end != "") {
    var year         = $("#attendance_year").val();
    var month        = $("#attendance_month").val()
    var start_time   = start.split(":");
    var end_time     = end.split(":");
    var start_date   = new Date(year, month, day, start_time[0], start_time[1]);
    var end_date     = new Date(year, month, day, end_time[0], end_time[1]);
    var working_time = (end_date - start_date - rest_period(day)) / 1000 / 60 / 60;
    $("#working_time" + day).text(format_time(working_time));
  }
}

function rest_period(day) {
  var year       = $("#attendance_year").val();
  var month      = $("#attendance_month").val()
  var start_time = $("#attendance_display_rest_start_time").val().split(":");
  var end_time   = $("#attendance_display_rest_end_time").val().split(":");
  var start_date = new Date(year, month, day, start_time[0], start_time[1]);
  var end_date   = new Date(year, month, day, end_time[0], end_time[1]);
  return end_date - start_date;
}

function format_time(num) {
  String(num).match(/(\d+)\.*(\d*)/)
  var int = RegExp.$1;
  var flt = RegExp.$2;
  var int_str;
  var flt_str;

  if (int == "") {
    int_str = "00";
  } else {
    if (parseInt(int) < 10) {
      int_str = "0" + int;
    } else {
      int_str = int;
    }
  }

  if (flt == "") {
    flt_str = "00";
  } else {
    var min = 60 * parseFloat("0." + flt);
    if (min < 10) {
      flt_str = "0" + min;
    } else {
      flt_str = min;
    }
  }

  return int_str + ":" + flt_str;
}
