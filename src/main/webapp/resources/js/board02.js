$(document).ready(function() {
    $('#sch_insert_max_member').on('input change', function() {
        $('#range_text').text($(this).val() + '명');
    });
});