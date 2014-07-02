$(function () {
  /*==JQUERY STEPY==*/
  $('#stepy_form').stepy({
      backLabel: 'Back',
      nextLabel: 'Next',
      errorImage: true,
      block: true,
      description: false,
      legend: false,
      titleClick: true,
      titleTarget: '#top_tabby',
      validate: true
  });

  $('#stepy_form').validate({
    errorPlacement: function (error, element) {
        $('#stepy_form div.stepy-error.valid-error').prepend(error);
    },
    rules: {
        'user[email]': 'required',
        'user[alternate_email]': 'required',
        'user[phone_number]': {
          required: true,
          number: true,
          minlength: 10,
          maxlength: 12
        },
        'user[alternate_phone_number]': {
          required: true,
          number: true,
          minlength: 10,
          maxlength: 12
        },
        'user[name]': 'required',
        'user[date_of_birth]': 'required',
        'user[date_of_joining]': 'required',
        'user[local_address]': 'required',
        'user[permanent_address]': {
          required: {
            depends: function(element) {
              if ($('#same_local_address').is(':checked')){
                return false;
              }else{
                return true;
              }
            }
          }
        }
    },
    messages: {
        'user[alternate_email]': {
            required: 'alternate_email field is required!'
        },
        'user[email]': {
            required: 'Email field is requerid!'
        },
        'user[phone_number]': {
            required: 'Phone Number field is requerid!',
            number: 'Enter Numeric value only.',
            minlength: 'Enter atleast 10 digit phone number.',
            maxlength: 'Enter atlmost 12 digit phone number.'
        },
        'user[alternate_phone_number]': {
            required: 'Alternate Phone Number field is requerid!',
            number: 'Alternate Phone Number -Enter Numeric value only.',
            minlength: 'Enter atleast 10 digit phone number.',
            maxlength: 'Enter atlmost 12 digit phone number.'
        },
        'user[name]': {
            required: 'Name field is requerid!'
        },
        'user[date_of_birth]': {
            required: 'Date Of Birth field is required!'
        },
        'user[date_of_joining]': {
            required: 'Date Of Join field is required!'
        },
        'user[local_address]': {
            required: 'Local Address field is required!'
        },
        'user[permanent_address]': {
            required: 'Permanent Address field is required!'
        }
    }
  });

  var now = new Date(),
  curr_year = now.getFullYear(),
  dob_maxyear = curr_year - 15,
  doj_minyear = curr_year - 10;

  $('#date_of_birth').datepicker({
    dateFormat: "yy-mm-dd",
    changeYear: true,
    yearRange: '1970:'+dob_maxyear
  });

  $('#date_of_join').datepicker({
    dateFormat: "yy-mm-dd",
    changeYear: true,
    yearRange: doj_minyear+':'+curr_year
  });

  // permanent address is same as local address
  $('#same_local_address').click(function(){
    if($("#same_local_address").is(':checked')){
      $("#user_permanent_address").hide().removeClass('valid');
    }else{
      $("#user_permanent_address").show().addClass('valid');
    }
  });
});
