// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
     $('#project_customer_name_autocomplete').autocomplete({
        minLength: 1,
        source: $('#project_customer_name_autocomplete').data('autocomplete-source'),  //'#..' can NOT be replaced with this
        select: function(event, ui) {
            //alert('fired!');
            $(this).val(ui.item.value);
        },
    });
});

$(function() {
  $('#project_customer_name_autocomplete').change(function (){
  	//$('#project_field_changed').val('supplier_id');
    $.get(window.location, $('form').serialize(), null, "script");
    return false;
  });	
});

$(function() {
   $("#project_construction_start_date").datepicker({dateFormat: 'yy-mm-dd'});
   $("#project_construction_finish_date").datepicker({dateFormat: 'yy-mm-dd'});
   $("#project_turn_over_date").datepicker({dateFormat: 'yy-mm-dd'});
});

$(function() {
	$("#project_construction_start_date_s").datepicker({dateFormat: 'yy-mm-dd'});
    $("#project_construction_finish_date_s").datepicker({dateFormat: 'yy-mm-dd'});
    $("#project_turn_over_date_s").datepicker({dateFormat: 'yy-mm-dd'});
});