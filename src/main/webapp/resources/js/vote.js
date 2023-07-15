$(document).ready(function(){
    $("#add_votetable").click(function(e){
        e.preventDefault();
        $(".vote_grid").append('<li><button type="button"><input type="text" placeholder="투표 항목"></button></li>');
    });
});
