// DATEPICKERS FUNCTIONS
$(document).on('page:change', function() {
	$('.datepicker').datepicker();

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
