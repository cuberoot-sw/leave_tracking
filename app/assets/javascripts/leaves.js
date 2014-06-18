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
    var reason = $('#reject_reasonModal #rejection_reason').val(),
    url;
    if(reason === ""){
      $('#reject_reasonModal .error_msg').html('Rejection reason is required.');
      return false;
    }else{
      url = '/leaves/'+$('#reject_reasonModal #leave_id').val()+'/reject?reason='+reason;
      window.location.href = url;
    }
  });

  $('.cancel_reason').click(function(){
    $('#reject_reasonModal').modal('hide');
  });
});
