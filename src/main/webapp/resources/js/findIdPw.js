$(document).ready(function(){
    fnFindId();
    fnFindPw();
    fnEmailCheck();

    /* 비밀번호 */
    fnPwFind_IdCheck();
    fnUpdatePw();
});

// 이메일 정규식
let regEmail = /^[0-9a-zA-Z-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}/;
let email_result = false;
let pwEmail_result = false;


/* ------ 아이디 ------ */

function fnFindId(){
    $('#findId_btn').on('click', function(){
        $('#findPw_btn').css('backgroundColor', 'lightgray');
        $('#findId_btn').css('backgroundColor', 'white');
        $('.form_box').css('backgroundColor', 'white');
        $('#pw_box').css('zIndex', '1');
        $('#id_box').css('zIndex', '2');
    });
}

/* 이메일 */
function fnEmailCheck(){

    $('#email').on('keyup blur', function(){
        if(regEmail.test($(this).val()) == false){
            $('#authCode_btn').css('disply', 'none');
            $('#email_check_msg').text('이메일을 다시 확인 해주세요.')
                                 .removeClass('pass_msg')
                                 .addClass('error_msg');
            email_result = false;
        }else{
            $('#email').css('width', '337.5px');
            $('#authCode').css('width', '337.5px');
            $('#authCode_btn').css('display', 'inline-block');
            $('#email_check_msg').text('')
            email_result = true;
        }
    });           


    email_result = true;
    // 인증코드 전송 버튼
     $('#authCode_btn').click(function(){
          // 이메일 있는지 확인하기
          $.ajax({
              url: "/nearby/member/selectByEmail",
              type: 'post',
              data : 'email=' + $("#email").val(),
              dataType: 'json',
              success: function(map){
                  if(map.result != null ){
                     /*  $('#email_check_msg').html("회원님의 아이디는 <strong>"+map.result.id +"</strong> 입니다."); */
                      fnSendAuthCode(map.result.id);
                  } else {
                       $('#email_check_msg').text("입력하신 이메일 조회 결과 없는 회원입니다.");
                  }
              }, 
              error : function(xhr) {
                  $('#email_check_msg').text(xhr.responseText);
                  return;
              }
          }); // 이메일 유무 확인   
     });

}// end fnEmailCheck

function fnSendAuthCode(id){
   $("#authCode_box").css("display", 'inline-block');
     $.ajax({
        url: '/nearby/member/sendAuthCode',
        type: 'post',
        data: 'email=' + $('#email').val(),
        dataType: 'json',
        success: function(map){
            $('#email_check_msg').text('인증코드가 발송 되었습니다.')
                                 .addClass('pass_msg');
            fnVerifyAuthCode(map.authCode, id);
        },
        error: function(){
            alert('인증코드 전송 실패');
        }
    }); // AJAX     
}

function fnVerifyAuthCode(authCode, id){
   $('#verify_btn').click(function(){
      if($('#authCode').val() == authCode){
         $('#verify_msg').html('회원님의 아이디는 <strong>'+ id +'</strong> 입니다.').addClass('pass_msg');
         authCodePass = true;
      }else{
         alert('인증 실패');
         authCodePass = false;
      }
   });
}// fnVerifyAuthCode




/* ------ 비밀번호 ------ */

function fnFindPw(){
    $('#findPw_btn').on('click', function(){
        $('#findId_btn').css('backgroundColor', 'lightgray');
        $('#findPw_btn').css('backgroundColor', 'white');
        $('.form_box').css('backgroundColor', 'white');
        $('#id_box').css('zIndex', '1');
        $('#pw_box').css('zIndex', '2');
    });
}

/*
    비밀번호를 찾을 아이디를 확인후
    등록 되어 있는 이메일을 확인
    등록 되어 있는 이메일로 인증코드 발송
    인증코드 검중 후 -> 비밀번호 변경 페이지로 이동
*/
    /* 가입한 아이디 체크 */
    function fnPwFind_IdCheck(){
        $('#idCheck_btn').on('click', function(){
            $.ajax({
                url: '/nearby/member/idCheck',
                type: 'post',
                data: 'id=' + $('#pwId').val(),
                dataType: 'json',
                success: function(map){
                    if(map.result == null){
                        Swal.fire({
                            icon: 'error',
                            title: '실패',
                            text: '해당하는 아이디를 찾을 수 없습니다.',
                        });
                    }else if(map.result.id == $('#pwId').val()){
                        $('.emailCheck_box').css('display', 'block');
                        fnPwFind_EmailCheck(map.result.email);
                    }
                },
                error: function(){
                    alert('아이디 체크 오류');
                }
            });// 아이디 여부 체크 AJAX
        });
    } // end fnPwFind_IdCheck()


    /* 이메일 체크 */
    function fnPwFind_EmailCheck(email){
        $('#pwEmail').on('keyup bulr', function(){
            if(regEmail.test($(this).val()) == false){
                $('#pwAuthCode_btn').css('display', 'none');
                $('#pwEmail_check_msg').text('이메일을 다시 확인 해주세요.')
                                       .removeClass('pass_msg')
                                       .addClass('error_msg');
                pwEmail_result = false;
            }else{
                $('#pwEmail_check_msg').text('');
                $('#emailCheck_btn').css('display', 'inline-block');
            }

            $('#emailCheck_btn').click(function(){
                if($('#pwEmail').val() == email){
                    $('#emailCheck_btn').css('display', 'none');
                    $('#pwAuthCode_btn').css('display', 'inline-block');
                    $('#pwEmail_check_msg').text('')
                    pwEmail_result = true;
                }else{
                    Swal.fire({
                        icon: 'error',
                        title: '실패',
                        text: '회원정보 어쩌구 아이디 어쩌구 이메일이 틀림 어쩌구',
                    });
                    /*$('#pwEmail_check_msg').text('회원정보 어쩌구 아이디 어쩌구 이메일이 틀림 어쩌구');*/
                    pwEmail_result = false;
                }
            });
        });

        // 인증코드 전송 버튼
        $('#pwAuthCode_btn').click(function(){
            $('#pwAuthCode_box').css('display', 'inline-block');
            $.ajax({
                url: '/nearby/member/sendAuthCode',
                type: 'post',
                data: 'email=' + $('#pwEmail').val(),
                dataType: 'json',
                success: function(map){
                    console.log(map.authCode);
                    Swal.fire({
                        icon: 'success',
                        title: '성공',
                        text: '인증코드가 발송 되었습니다.',
                    });
                    /*$('#pwEmail_check_msg').text('인증코드가 발송 되었습니다.')
                                           .addClass('pass_msg');*/
                    fnPwVerify(map.authCode);
                },
                error: function(){
                    alert('인증코드 전송 실패');
                }
            }); // 인증코드 전송 AJAX
        });

    } // end fnPwEmailCheck

    function fnPwVerify(authCode){
        $('#pwVerify_btn').click(function(){
            if($('#pwAuthCode').val() == authCode){
                Swal.fire({
                    icon: 'success',
                    title: '성공',
                    text: '인증번호 일치',
                })
                /*alert('인증번호 일치');*/
                $('#updatePw').css('display', 'inline-block');
                return true;
            }else{
                Swal.fire({
                    icon: 'error',
                    title: '실패',
                    text: '인증 번호가 일치하지 않습니다.',
                });
                /*alert('인증 번호가 일치하지 않습니다.');*/
                return false;
            }
        });
    }

    function fnUpdatePw(){
        $('#updatePw').click(function(){
            $.ajax({
                url: '/nearby/member/findPw',
                type: 'post',
                data: 'email=' + $('#pwEmail').val(),
                dataType: 'json',
                success: function(map){
                    if (map.result > 0) {
                  Swal.fire({
                     icon: 'success',
                     title: '성공',
                     text: '이메일로 임시 비밀번호를 전송 했습니다.',
                  })
                        /*alert('이메일로 임시 비밀번호를 전송 했습니다.');*/
                        location.href='/nearby/';
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: '실패',
                            text: '임시 비밀번호 전송이 실패되었습니다. 다시시도해주세요.',
                        });
                        /*alert('임시 비밀번호 전송이 실패되었습니다. 다시시도해주세요.');*/
                    }
                },
                error: function(){
                    alert('임시 비밀번호를 전송 실패');
                }
            }); //fnUpdatePw
        });
    }