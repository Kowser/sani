// DATEPICKERS FUNCTIONS
var calendar_options = {
  dateFormat : 'mm/dd/yy',
  changeMonth : true,
  changeYear : true
}

$(document).on('page:change', function() {

	$('.datepicker').datepicker(calendar_options);

	$('select#facility_id').change(function() {
	  var facility_id = window.location.toString().match(/facilities\/(\d+)/)[1]
	  window.location = window.location.toString().replace("facilities/" + facility_id, "facilities/" + $(this).val())
	});

	$('select#search_deposited').change(function() {
		$(this).closest('form').submit();
	});

	$('select#search_completed').change(function() {
		$(this).closest('form').submit();
	});

	function addUnit() {
	  $('#add-unit').click(function() {
	    var id = Math.floor(Math.random() * (100000)) + 9999;
	    var regexp = RegExp($(this).data('id'), 'g');
	    $('#new-unit-link').before($(this).data('fields').replace(regexp, id));
	    return false;
	  });
	}
	addUnit();
});
