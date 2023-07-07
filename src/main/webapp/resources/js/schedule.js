function Participant_UpdateOK(btn) {
    console.log("Participant_UpdateOK....");

    var numField = $(btn).closest('li').find('.PART_UPDATE_NUM');
    var num2Field = $(btn).closest('li').find('.PART_UPDATE_Participant');

    console.log(numField.val());
    console.log(num2Field.val());
    console.log($('.PART_UPDATE_USER_ID').val());

    $.ajax({
        url: "Participant_UpdateOK.do",
        data: {
            num: numField.val(),
            participant: num2Field.val(),
            user_id: $('.PART_UPDATE_USER_ID').val(),
        },
        method: 'POST',
        dataType: 'text',
        success: function(response) {
            console.log('ajax....success', response);
        },
        error:function(xhr,status,error){
            console.log('xhr.status:', xhr.status);
        }
    });

} //end function()
