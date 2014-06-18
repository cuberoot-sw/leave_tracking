$(document).ready(function(){
  $('#leaves_start_date').datetimepicker({
    pickTime: false,
  });

  $('#leaves_end_date').datetimepicker({
    pickTime: false,
  });

  $('.reject_btn').click(function(){
    var id = $(this).attr('id');
    $("#reject_reasonModal #leave_id").val(id);
    $('#reject_reasonModal').modal({
      "backdrop" : "static",
      "keyboard" : true,
      "show" : true
    });
  });

  $('.submit_reason').click(function(){
    var url = '/leaves/'+$('#reject_reasonModal #leave_id').val()+'/reject?reason='+$('#reject_reasonModal #rejection_reason').val();
    window.location.href = url;
  });
});
