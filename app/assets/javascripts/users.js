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
        'user[phone_number]': 'required',
        'user[alternate_phone_number]': 'required',
        'user[name]': 'required',
        'user[date_of_birth]': 'required',
        'user[date_of_joining]': 'required'
    },
    messages: {
        'user[alternate_email]': {
            required: 'alternate_email field is required!'
        },
        'user[email]': {
            required: 'Email field is requerid!'
        },
        'user[phone_number]': {
            required: 'Phone Number field is requerid!'
        },
        'user[alternate_phone_number]': {
            required: 'Alternate Phone Number field is requerid!'
        },
        'user[name]': {
            required: 'Name field is requerid!'
        },
        'user[date_of_birth]': {
            required: 'Date Of Birth field is required!'
        },
        'user[date_of_joining]': {
            required: 'Date Of Join field is required!'
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

});
