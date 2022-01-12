<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NearBy 회원가입 페이지</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css">
<script src="${pageContext.request.contextPath}/resources/js/join.js"></script>
</head>
<body>
    <div class="container">
    
        <div class="head">
            <h1 class="title"><a href="/nearby/">NearBy</a></h1>
        </div>
 
        <div class="join_form">
    
            <form action="/nearby/member/insertMember" method="post" id="join_form">
                <!-- 아이디 --> 
                <div class="input_box">
                    <label for="id">아이디</label>
                        <input type="text" id="id" name="id">
                        <span class="icon"><i class="fas fa-check idCheckTrue"></i><i class="fas fa-times idCheckFalse"></i></span>
                    <span id="id_check_msg"></span>
                </div>

                <!-- 비밀번호 -->
                <div class="input_box">
                    <label for="pw">비밀번호</label>
                        <input type="text" id="pw" name="pw">
                    	<span class="icon"><i class="fas fa-check pwCheckTrue"></i><i class="fas fa-times pwCheckFalse"></i></span>
                    <span id="pw_check_msg"></span>
                </div>

                <!-- 비밀번호 확인 -->
                <div class="input_box">
                    <label for="pw2">비밀번호 재확인</label>
                        <input type="text" id="pw2" >
                    	<span class="icon"><i class="fas fa-check pw2CheckTrue"></i><i class="fas fa-times pw2CheckFalse"></i></span>
                    <span id="pw2_check_msg"></span>
                </div>
                
                <!-- 이름 -->
                <div class="input_box">
                    <label for="name">이름</label>
                        <input type="text" id="name" name="name">
                    	<span class="icon"><i class="fas fa-check nameCheckTrue"></i><i class="fas fa-times nameCheckFalse"></i></span>
                    <span id="name_check_msg"></span>
                </div>

                <!-- 이메일 -->
                <div class="email_box">

                    <!-- 이메일 -->
                    <label for="email">이메일</label>
                        <input type="text" id="email" name="email">
                        <input type="button" value="이메일 확인" id="emailCheck_btn">
                    	<span class="icon"><i class="fas fa-check emailCheckTrue"></i><i class="fas fa-times emailCheckFalse"></i></span>
                    
                    <!-- 인증코드 발송 버튼-->
                    <input type="button" value="인증번호받기" id="authCode_btn">
                    <span id="email_check_msg"></span>
                    
                    <!-- 인증코드 입력 칸 -->
                    <div id="authCode_box">
                        <input type="text" name="authCode" id="authCode">
                        <input type="button" value="인증하기" id="verify_btn">
                    	<span class="icon"><i class="fas fa-check verifyCheckTrue"></i><i class="fas fa-times verifyCheckFalse"></i></span>
                  <span id="verify_msg"></span>
                    </div>
                </div>

                <!-- 번호 -->
                <div class="tel_box">
                    <label for="phone">번호</label>
                        <input type="text" id="phone" name="phone" placeholder="- 표시 없이 입력해주세요">
                    	<span class="icon"><i class="fas fa-check telCheckTrue"></i><i class="fas fa-times telCheckFalse"></i></span>
                    <span id="phone_check_msg"></span>
                </div>

                <!-- 생년월일 -->
                <div class="birth_box">
                    
                    <!-- 년도 -->
                    <label for="birthday">생년월일</label>
                  <select id="year" name="year"></select>

                  <!-- 월 -->
                  <select id="month" name="month"></select>

                  <!-- 일 -->
                  <select id="day" name="day"></select>
                </div>

                <!-- 성별 -->
                <div class="gender_box">
                    <p id="gender_box">성별</p>
                    <!-- 선택 안 함 -->
                    <input type="radio" name="gender" value="n" id="n" checked>
                    <label id="n"  for="n">선택안함</label>
                    
                    <!-- 남성 -->
                    <input type="radio" name="gender" value="m" id="male">
                    <label id="m"  for="male">남성</label>
   
                    <!-- 여성 -->
                    <input type="radio" name="gender" value="f" id="female">
                    <label id="f" for="female">여성</label>

                </div>

                <div class="join_btn_wrap" id="join_btn_wrap">
                    <button class="btn btn-primary">회원가입</button>                 
                </div>                
            </form>
        </div>

        <div style="text-align: center;">
           <a href="/nearby/member/serviceTerms" id="pol">NearBy 서비스 이용 약관</a>
        </div>
    </div>
</body>
</html>