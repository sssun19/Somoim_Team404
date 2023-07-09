$(document).ready(function() {
    var userId = $('#login_user_id').val();
    console.log(userId);

    $('.participant_mine').each(function() {
        var participantName = $(this).val();

        if (participantName === userId) {
            $(this).siblings('img').css('border', '2px solid #1785F2');
            $(this).parent().prependTo('#member-list');
        }
    });
});
