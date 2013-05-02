$(document).ready(function() {

$('#add_taken_course_form').hide();

$('#add_taken_course_button').click(function() {
   $('#add_taken_course_form').show();
   $('#add_taken_course_button').hide();
});



$(function() {
    function updateCheckbox() {
        $(this).attr("value", $(this).attr("checked") ? 1 : 0);
    }
    // Run whenever checkbox is ticked or unticked
    $("input[type=checkbox]").change(updateCheckbox);
    // Run on page load
    updateCheckbox();
});
  
});