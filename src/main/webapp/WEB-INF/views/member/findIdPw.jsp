<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<!-- sweetCDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/findIdPw.css">
<script src="${pageContext.request.contextPath}/resources/js/findIdPw.js"></script>

<style>
/* header 관련 */
   .header_wrap {
      z-index: 5;
      position: fixed;
      top: 0;
      width:100%;
      height: 100px;
      background-color: white;
      display: flex;
   }
   .header_btn {
      width: 140px;
      height: 40px;
      border-radius: 30px;
      border: none;
      font-size: 20px;
      margin-top: 30px;
      cursor:pointer;   
      right: 30px;
   }
   #header_logo {
   	display: inline-block;
   	margin-left: 40px;
   	margin-top: 10px;
   }
/* footer */
	footer {
		margin-top : 200px;
	}
</style>
</head>
<body>
 
 	  <header class="header_wrap">
           <a href="/nearby/"><img id="header_logo" src="${pageContext.request.contextPath}/resources/image/logo_color.png" width="200px"></a>
      </header>
 
 
 
    <<!-- h1 class="title">
       <a href="/nearby/">NearBy</a>
    </h1> -->
    
    
    <div class="container" style="margin-top: 200px;">
        <!-- 아이디 찾기 -->
        <input id="findId_btn" type="button" value="아이디 찾기">
        <div class="wrap" id="id_box">
            <div class="form_box">
                <form action="">
                    <!-- 이메일 -->
                    <div class="input_wrap">
    
                        <!-- 이메일 -->
                        <label for="email">아이디 찾기 회원정보에 등록한 이메일 인증</label>
                        <span class="space">
                            <input type="text" id="email" name="email">
                        </span>
                        
                        <!-- 인증코드 발송 버튼-->
                        <input type="button" value="인증번호받기" id="authCode_btn">
                        <span id="email_check_msg"></span>
                        
                        <!-- 인증코드 입력 칸 -->
                        <div id="authCode_box">
                            <span class="space">
                                <input type="text" name="authCode" id="authCode">
                            </span>
                            <input type="button" value="인증하기" id="verify_btn">
                            <span id="verify_msg"></span>
                        </div>
                        
                        <div>
                           <span id="id_confirm"></span>
                        </div>
                    </div>   
                </form>
            </div>
        </div>

        <!-- 비밀번호 찾기 -->
        <input id="findPw_btn" type="button" value="비밀번호 찾기">
        <div class="wrap" id="pw_box">
            <div class="form_box">
                <form action="">
                <!-- 이메일 -->
                <div class="input_wrap">

                    <!-- 아이디 -->
                    <label for="email">찾을 비밀번호의 아이디</label>
                    <span class="space">
                        <input type="text" id="pwId" name="pwId">
                    </span>

                    <!-- 아이디 확인 버튼-->
                    <input type="button" value="확인" id="idCheck_btn">
                    <span id="idCheck_msg"></span>

                    <div class="emailCheck_box">
                        <!-- 이메일 -->
                        <label for="email">회원정보에 등록한 이메일 인증</label>
                        <span class="space">
                            <input type="text" id="pwEmail" name="pwEmail">
                        </span>
                        
                        <!-- 이메일 확인 -->
                        <input type="button" value="이메일 확인" id="emailCheck_btn">
                        <!-- 인증코드 발송 버튼-->
                        <input type="button" value="인증번호받기" id="pwAuthCode_btn">
                        <span id="pwEmail_check_msg"></span>
                    </div>

                    <!-- 인증코드 입력 칸 -->
                    <div id="pwAuthCode_box">
                        <span class="space">
                            <input type="text" name="authCode" id="pwAuthCode">
                        </span>
                        <input type="button" value="인증하기" id="pwVerify_btn">
                  <span id="pwVerify_msg"></span>

                        <input type="button" id="updatePw" value="임시 비밀번호 발급 받기">

                    </div>
                </div> 
                </form>
            </div>
        </div>
    </div>
    
	<footer>
         <jsp:include page="/WEB-INF/views/layout/footer.jsp" flush="true" />
    </footer>
    
    
</body>
</html>