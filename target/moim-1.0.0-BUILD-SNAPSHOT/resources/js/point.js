$(document).ready(function(){
    $('.point_list').show();
    $('.point_list2').hide();


    $(".point_category a").click(function(e){
        e.preventDefault();
        
        var showValue= $(this).text();

        console.log(showValue);

        if(showValue == '유료결제'){
            $('.point_list').show();
            $('.point_list2').hide();
        }else{
            $('.point_list').hide();
            $('.point_list2').show();
        }

        // 모든 a 태그에서 'point_acitve' 클래스를 제거
        $('.point_category a').removeClass('point_acitve');
        
        // 클릭된 a 태그에 'point_acitve' 클래스 추가
        $(this).addClass('point_acitve');
    });
});