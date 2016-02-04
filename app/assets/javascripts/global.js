// DATEPICKERS FUNCTIONS
$(document).on('page:change', function() {
	$('.datepicker').datepicker();

	$('select#facility_id').change(function() {
	  var org_id = window.location.toString().match(/facilities\/(\d+)/)[1]
	  window.location = window.location.toString().replace("facilities/" + org_id, "facilities/" + $(this).val())
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
