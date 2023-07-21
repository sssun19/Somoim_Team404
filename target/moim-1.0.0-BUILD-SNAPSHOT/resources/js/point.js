$(document).ready(function(){
    $('.point_list').show();
    $('.point_list2').hide();

<<<<<<< HEAD
    $(".point_category a").click(function(e){
        e.preventDefault();

=======

    $(".point_category a").click(function(e){
        e.preventDefault();
        
>>>>>>> ffd127e859fc469cdc23d414038f01bb9c76ac47
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
<<<<<<< HEAD

        // 클릭된 a 태그에 'point_acitve' 클래스 추가
        $(this).addClass('point_acitve');
    });

    // purchase-btn을 클릭 했을 때의 이벤트 처리
    $('.purchase-btn').on('click', function() {
        var item = $(this).siblings('p').text();
        var point = $(this).siblings('input').val();
        console.log(item,point);

        var check = confirm("구매하신 항목은 "+item+" 입니다."+"\n"+
            point+" 결제하시겠습니까?");
        if (check == true){
            console.log('yes');

            $.ajax({
                url: "point_purchase.do",
                data: {
                    num: $('#update_num').val(),
                    title: $('#update_title').val(),
                    content: $('#update_content').text(),

                },
                method: 'POST',
                dataType: 'text',
                success: function(response) {
                    console.log('ajax....success', response);
                    alert("성공");
                    location.href="join_selectAll.do?somoim_num="+$('#somoim_num').val();

                },
                error:function(xhr,status,error){
                    console.log('xhr.status:', xhr.status);
                }
            });
        }else{
            console.log('no');
        }




    });
});
=======
        
        // 클릭된 a 태그에 'point_acitve' 클래스 추가
        $(this).addClass('point_acitve');
    });
});
>>>>>>> ffd127e859fc469cdc23d414038f01bb9c76ac47
