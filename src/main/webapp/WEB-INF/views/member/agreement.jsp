<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<style type="text/css">
	
		* {
			font-family: sans-serif;
		}

		body {	/* 요소는 HTML 문서의 내용을 나타냅니다. 한 문서에 하나의 전체화면에 색상추가	*/
			background-color: rgb(240,242,245);
		}
		
		.container {	/* 전체 박스 */
			border-radius: 10px;	/* 박스 각도 */
			margin: 20px auto;
			width: 600px;	/* 너비 */
			height: 1250px;	/* 높이 */
			background-color: #FFFFFF;
			box-shadow: 10px 10px 20px 10px #cbcdcf;	/* 속성은 요소의 테두리를 감싼 그림자 효과를 추가합니다. */
		}
		
		.header_box {
			margin: 0 auto;
			text-align: center;
		}
		
		.header_box  > h1 {
			display: inline-block;
		}
		
		.title {
			height: 89px;
			text-align: center;
			text-decoration: none;
		}
		
		.title > a{
			display: inline-block;
		    width: 156px;
		    height: 60px;
		    padding-top: 50px;	/* 이미지 50px 올리겟다. */
		    background-size: 156px 60px;
		    background-image: url('${pageContext.request.contextPath}/resources/image/logo_color.png');
		    background-repeat: no-repeat;
		    background-position: 0 0;
		    font-size: 0;
		    
		}
		
		.title2 {
			margin-top: 80px;  /* 80px 글자 내린다. */
		}
		
		form {
			width : 550px;
			margin: 0 auto;
		}
		
		/* h1 {
			text-align: center;
			padding-top: 50px;
			font-size: 25px;
		} */
		
		.box {	/* 설명서 박스에 넣어서 스크롤 y축 추가한다 */
			border: 1px solid black;	/* 박스 */
			margin: 10px;
			width: 500px;
			padding: 10px;
	  		height: 120px;
	  		overflow: auto; /* y 축만 스크롤하면 되지만 */
	  		border-color: #fe4b60;
		}
		
		.box::-webkit-scrollbar {	/* 스크롤바 전체 */
		width: 10px;
		}
		.box::-webkit-scrollbar-thumb {	/* 스크롤 막대 속성 */
		background-color: #fe4b60;
		border-radius: 5px;
		}
		.box::-webkit-scrollbar-track {	/* 스크롤 막대 외부 속성 */
		background-color: #FFE6E6;
		border-radius: 5px;
		}
	
		.accordion {
			margin-top: 30px;
		}
		
		.all_check_wrap {	/* 박스와 사이 아래 너비 사이에 준다. */
			margin-bottom: 30px;
		}
		
		.all_check_wrap2 {
			margin-bottom: 40px;
			margin-top: 40px;
		}
		
		span {
			font-size: 12px;
		}
		/* 	margin: 0 auto;
			padding: 20px; */
		
		.right {
			margin: 10px;
			margin-right: 23px;
		}
		
		#agreement {	/* 동의 버튼 */ 
			border-radius: 10px;
			width: 220px;
			height: 50px;
			background-color: #bababb;
			font-size: 20px;
			color: black;
			margin-right: 20px;
			outline: none;
			border: none;
			cursor: pointer;
		} 
		/* active:마우스 클릭하는 이벤트 , hover:마우스 오버 이벤트, visied:한번더 클릭 하는 이벤트 */
		#agreement:hover {	/* 박스에 마우스 이동 하고있을때 색상 변경 */ 
			background-color: #fe4b60;
			color: #FFFFFF;
			outline: none;
			border: none;
			cursor: pointer;
		}
		#disagree {	/* 비동의 버튼 */
			border-radius: 10px;
			width: 220px;
			height: 50px;
			background-color: #bababb;
			font-size: 20px;
			color: black;
			margin-left: 20px;
			outline: none;
			border: none;
			cursor: pointer;
		}
		#disagree:hover {	/* 박스에 마우스 이동 하고있을때 색상 변경 */
			background-color: #fe4b60;
			color: #FFFFFF;
			outline: none;
			border: none;
			cursor: pointer;
		}
		
		#all_check_text {
			font-size: 20px;
		}
		
	</style>
	<!-- accordion 접히는 Script 선언 -->
	<script type="text/javascript">
		$(document).ready(function() {
			// 체크박스 클리 하면 전체 체그박스 모두 체그  
			$('#check_all').click(function() {
				if ($('#check_all').prop("checked")) {
					$('.test').prop('checked', true);
				} else {
					$('.test').prop('checked', false);
				}
			});
			// 전체 체크 박스 선택중 체크박스 하나를 풀었을때
			$('.test').click(function() {
				if ($('input[name="check"]:checked').length == 4) {
					$('#check_all').prop('checked', true);
				} else {
					$('#check_all').prop('checked', false);
				}
			});
			$('#accordion input[type="checkbox"]').click(function(e) {
				e.stopPropagation();
			}); 
			
			/* 체크해도 경고창 나타난다. */
			/* $('#form').on('submit', function(event){
				if (true) {
					alert('이용동의 약관에 동의하지 않았습니다.');
					event.preventDefault();
					return false;
				} else if (true) { // check2를 선택하지 않은 경우
					alert('개인정보 수집 및 이용에 대한 안내를 동의하지 않았습니다.');
					event.preventDefault();
					return false;
				}
				return true; */
			/* 필수 선택 안하면 경고창 */
			$('#form').on('submit', function(event){
				if ($('#check1').is(':checked')) {  
				// check1을 선택해도 경고창 나오지 않지 하기
				} else {	// check1을 선택하지 않은 경우
					alert('이용동의 약관에 동의하지 않았습니다.');
					event.preventDefault();
					return false;
				} if ($('#check2').is(':checked')) {
				// check2를 선택해도 경고창 나오지 않지 하기
				} else  {  // check2를 선택하지 않은 경우
					alert('개인정보 수집 및 이용에 대한 안내를 동의하지 않았습니다.');
					event.preventDefault();
					return false;
				}
				return true; 
			});
			/* 보이기, 숨기 */
			/* $(function() {
				$('#bto_toggle').click(function() {
					$('#box1').toggle();
				});
				$('#bto_toggle2').click(function() {
					$('#box2').toggle();
				});
				$('#bto_toggle3').click(function() {
					$('#box3').toggle();
				});
			});  */
		});
	</script>
</head>
<body>

	<div class="container">	<!-- 전체 박스 -->
	
		<form id="form" action="/nearby/member/memberJoin">
		
			<div>
			
				<div class="header_box">
				
					<h1 class="title">
					
						<a href="#">Nearby</a>
						
					</h1>
					
					<!-- 제목 -->
					
					<h1 class="title2" align="center">이용약관 동의</h1> 
					
				</div>
				
				<div id="on_box">
					<!-- 중간 따로 박스 넣음 -->
					<div class="all_check_wrap">	
						<!-- <label>태그안에 <input>태그 옆에 <span>태그 클리하면 동시에 체크 확인 가능하다. -->
						<label>
							<input type="checkbox" class="test" name="check_all" id="check_all"><span id="all_check_text">모두확인, 동의합니다.</span>
						</label>
					
					</div>
					
					<hr/>
					
					
					<div id="accordion" class="dccordion">
						<!-- 중간 따로 박스 넣음 -->
					 	<div class="all_check_wrap2">	
					 	
					 		<label>
					 			<!-- 체크박스 필수 선태 -->
								<input type="checkbox" class="test" name="check" id="check1" ><span>이용약관 동의(필수)</span>
					 		</label>
							<!-- 박스에 스크롤 추가  <div class="box" id="box" style="display: none;">-->
							<!-- 보이기, 숨기 -->
					 		<!-- <input type="button" id="bto_toggle" value="보기"> -->
							<div class="box" id="box1">	
							
								<h4>제1조 (목적)</h4>
								
								<p><span>이 약관은 NEARBY, ln(이하"NEARBY") 가 제공하는 NEARBY 관련	제반 서비스의 이용과 관련하여 회원과의 권리, 의무 및 책임 사항,	기타 필요한 사항을 규정함을 목적으로 합니다</span></p>
								
								<h4>제2조 (정의)</h4>
								
								<p><span>이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</span></p>
								<p><span>① "서비스"라 함은 구현되는 단말기(PC, TV, 휴대형 단말기 등의 각종 유무선 장치를 포함)와 상관없이 "회원"이 이용할 수 있는 NEARBY, ln 및 NEARBY, ln 관련 제반 서비스를 의미합니다.</span></p>
								<p><span>② "회원"이라 함은 NEARBY의 "서비스"에 접속하여 이 약관에 따라 "NEARBY"와 이용계약을 체결하고 "NEARBY"가 제공하는 "서비스"를 이용하는 고객을 말합니다.</span></p>
								<p><span>③ "아이디(ID)"라 함은 "회원"의 식별과 "서비스" 이용을 위하여 "회원"이 정하고 "NEARBY"가 승인하는 SNS 계정을 의미합니다.</span></p>
								<p><span>④ "비밀번호"라 함은 "회원"이 선택한 아이디(SNS 계정)의 비밀번호를 의미합니다.</span></p>
								<p><span>⑤ "게시물"이라 함은 "회원"이 "서비스"를 이용하면서 있어 "서비스상"에 게시한 부호 · 문자 · 음성 · 음향 · 화상 · 동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다.</span></p>
								
								<h4>제3조 (약관의 게시와 개정)</h4>
								
								<p><span>① "NEARBY"는 이 약관의 내용을 "회원"이 쉽게 알 수 있도록 서비스 초기 화면에 게시합니다.</span></p>
								<p><span>② "NEARBY"는 "약관의 규제에 관한 법률", "정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 "정보통신망법") 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</span></p>
								<p><span>③ "NEARBY"가 약관을 개정할 경우에는 적용 일자 및 개정 사유를 명시하여 현행약관과 함께 제1항의 방식에 따라 그 개정약관의 적용 일자 30일 전부터 적용 일자 전날까지 공지합니다.</span></p>
								<p><span>단, "회원"의 권리, 의무에 중대한 영향을 주는 변경이 아닌 경우에는 적용 일자 7일 전부터 공지하도록 합니다.</span></p>
								<p><span>④ 전항에 따라 시행일 이후에 "회원"이 "서비스"를 이용할 때는 개정약관에 동의한 것으로 간주합니다. "회원"은 변경된 약관에 동의하지 않을 때 이용계약을 해지할 수 있습니다.</span></p>
								
								<h4>제4조 (이용 게약 체결)</h4>
								
								<p><span>① 이용계약"회원"이 되고자 하는 자(이하 "가입 신청자")가 약관이 내용에 대하여 동의를 한 다음 회원 가입신청을 하고 "NEARBY"가 이러한 신청에 대하여 승낙함으로써 체결됩니다.</span></p>
								<p><span>② "NEARBY"는 "가입신청자"의 신청에 대하여 "서비스" 이용을 승낙함을 원칙으로 합니다. 다만, "NEARBY"는 다음 각호에 해당하는 신청에 대하여는 승낙하지 않거나 사후에 이용 계약을 해지할 수 있습니다.</span></p>
								<p><span>1. 가입 신청자가 이 약관에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만, 회원자격 상실 후 1년이 지나간 자로서 "NEARBY"의 회원 재가입 승낙을 오는 경우에는 예외로 함.</span></p>
								<p><span>2. 설명이 아니거나 타인의 명의를 이용한 경우</span></p>
								<p><span>3. 허위의 정보를 기재하거나, "NEARBY"가 제시하는 내용을 기재하지 않은 경우</span></p>
								<p><span>4. 이용자의 귀책 사유로 인하여 승인할 수 없거나 기타 규정한 제반 사항을 위반하여 신청하는 경우</span></p>
								<p><span>③ 제1항에 따른 신청에 있는 "NEARBY"는 "회원"의 종류에 따라 전문기관을 통한 실명 확인 및 본인인증을 요청할 수 있습니다.</span></p>
								<p><span>④ "NEARBY"는 서비스 관련 설비의 여우가 없거나, 기술상 또는 업무상 문제가 있는 경우에는 승낙을 유보할 수 있습니다.</span></p>
								<p><span>⑤ 제2항과 제4항에 따라 회원 가입신청의 승낙하지 아니하거나 유보한 경우, "NEARBY"는 원칙적으로 이를 가입 신청자에게 알리도록 합니다.</span></p>
								<p><span>⑥ 이용계약의 성립 시기는 "NEARBY"가 가입 완료를 신청 절차상에서 표시한 시점으로 합니다</span></p>
								<p><span>⑦ "NEARBY"는 "회원"에 대하여 "영화 및 비디오물의 진흥에 관한 법률" 및 "청소년 보호법" 등에 따른 등급 및 연령 준수를 위해 이용 제한이나 등급별 제한을 할 수 있습니다.</span></p>
								
								<h4>제5조 (회원 정보의 변경)</h4>
								
								<p><span>① "회원"은 마이페이지 화면을 통하여 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다. 다만, 서비스 관리를 위해 필요한 e-mail은 수정할 수 없습니다.</span></p>
								<p><span>② "회원"은 상품 관련 수령을 위한 주소 및 연락처를 온라인으로 비밀글 게시판에 등록해 "NEARBY"에 알릴 수 있으며, "NEARBY"는 상품발송 이외의 목적으로 이용하지 않으며 이용 이후 즉시 파기합니다.</span></p>
								<p><span>③ 제2항의 상품 관련 수령을 위한 주소 및 연락처를 "NEARBY"에 알리지 않아 발생한 불이익에 대하여 "NEARBY"는 책임지지 않습니다.</span></p>
								
								<h4>제6조 (개인정보보호 의무)</h4>
								
								<p><span>"NEARBY"는 "정보통신망법" 등 관계 법령이 정하는 바에 따라 "회원"의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련법 및 "NEARBY"의 개인정보 취급 방침이 적용됩니다. 다만, "NEARBY"의 공식 사이트 이외의 링크된 사이트에서는 "NEARBY"의 개인정보 취급 방침이 적용되지 않습니다.</span></p>
								
								<h4>제7조 (회원의 아이디 및 비밀번호의 관리에 대한 의무)</h4>
								
								<p><span>① "회원"의 "아이디"와 "비밀번호"에 관리책임은 "회원"에게 있으면, 이를 제3자가 이용토록 하여서는 안 됩니다.</span></p>
								<p><span>② "NEARBY"는 "회원"의 "아이디"가 개인정보 유출 우려가 있거나, 반사회적 또는 미풍양속에 어긋나거나 "NEARBY" 및 "NEARBY"의 운영자로 오인할 우려가 있는 경우, 해당 "아이디"의 이용을 제한할 수 있습니다.</span></p>
								<p><span>③ "회원"은 "아이디" 및 "비밀번호"가 도용되거나 제3자가 사용하고 인지한 경우에는 이를 즉시 "NEARBY"에 통지하고 "NEARBY"의 안내에 따라야 합니다.</span></p>
								<p><span>④ 제3자의 경우에 해당 "회원"이 "회사"에 그 사실을 통지하지 않거나, 통지한 경우에도 "NEARBY"의 안내에 따르지 않아 발생한 불이익에 대하여" NEARBY"는 책임지지 않습니다.</span></p>
								
								<h4>제8조 (회원에 대한 통지)</h4>
								
								<p><span>① "NEARBY"가 "회원"에 대한 통지를 하는 경우 이 약관에 별도 규정이 없는 한 "회원"이 지정한 전자우편주소를 할 수 있습니다.</span></p>
								<p><span>② "NEARBY"는 "회원" 전체에 대한 통지의 경우 7일 이상 "NEARBY"의 게시판에 게시함으로 제1항의 통지에 갈음할 수 있습니다.</span></p>
								
								<h4>제9조 ("NEARBY"의 의무)</h4>
								
								<p><span>① "NEARBY"는 관련법과 이 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적이고 안정적으로 "서비스"를 제공하기 위하여 최선을 다하여 노력합니다.</span></p>
								<p><span>② "NEARBY"는 "회원"이 안전하게 "서비스"를 이용할 수 있도록 개인정보 보호를 위해 보안시스템을 갖추어야 하며 개인정보 취급 방침을 공시하고 준수합니다.</span></p>
								<p><span>③ "NEARBY"는 서비스 이용과 관련하여 "회원"으로부터 제기된 의견이나 불만이 정당하다고 인정할 경우에는 이를 처리하여야 합니다. "회원"이 제기한 의견이나 불만 사항에 대해서는 게시판을 활용하거나</span></p>
								<p><span>전자우편 등을 통하여 "회원"에게 처리 과정 및 결과를 전달합니다.</span></p>
								
								<h4>제10조 ("회원"의 의무)</h4>
								
								<p><span>① "회원"은 다음 행위를 하여서는 안 됩니다.</span></p>
								<p><span>1. 신청 또는 변경 시 허위 내용의 등록</span></p>
								<p><span>2. 타인의 정보도용</span></p>
								<p><span>3. "NEARBY"가 게시한 정보의 변경</span></p>
								<p><span>4. "NEARBY"가 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시</span></p>
								<p><span>5. "NEARBY"와 기타 제3자의 저작권 등 지식재산권에 대한 침해</span></p>
								<p><span>6. "NEARBY" 및 기타 제3자의 명예를 손상하거나 업무를 방해하는 행위</span></p>
								<p><span>7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 "서비스"에 공개 또는 게시하는 행위</span></p>
								<p><span>8. NEARBY의 동의 없이 영리를 목적으로 "서비스"를 사용하는 행위</span></p>
								<p><span>9. 기타 불법적이거나 부당한 행위</span></p>
								<p><span>② "회원"은 관계법, 이 약관의 규정, 이용 안내 및 "서비스"와 관련하여 공지한 주의사항, "NEARBY"가 통지하는 사항 등을 준수하여야 하며, 기타 "NEARBY"의 업무에 방해되는 행위를 하여서는 안 됩니다.</span></p>
								
								<h4>제11조 (서비스의 제공 등)</h4>
								
								<p><span>① NEARBY는 회원에게 아래와 같은 서비스를 제공합니다.</span></p>
								<p><span>1. 검색 서비스</span></p>
								<p><span>2. 게시판 형 서비스</span></p>
								<p><span>3. VOD 서비스 (On Air, 다시 보기)</span></p>
								<p><span>4. News 기사 제공 서비스</span></p>
								<p><span>5. 기타 "회사가" 추가 개발하거나 다른 회사와의 제휴 계약 등을 통해 "회원"에게 제공하는 일체의 서비스</span></p>
								<p><span>② NEARBY는 "서비스"를 일정 범위로 분할하여 각 범위별로 이용가능시간을 별도로 지정할 수 있습니다. 다만, 이런 한 경우에는 그 내용을 사전에 공지합니다.</span></p>
								<p><span>③ "서비스"는 연중무휴, 1일 24시간 제공함을 원칙으로 합니다.</span></p>
								<p><span>④ "NEARBY"는 컴퓨터 등 정보통신설비의 보수점검, 교체 및 고장, 통신두절 또는 운영상 당당한 이유가 있는 경우 "서비스"의 제공을 일시적으로 중단할 수 있습니다. 이 경우 "NEARBY"는 제8조(회원에 대한 통지)에</span></p>
								<p><span>정한 방법으로 "회원"에게 통지합니다. 다만, "NEARBY"가 사전에 통지할 수 없는 부득이한 사유가 있는 경우 사후에 통지할 수 있습니다.</span></p>
								<p><span>⑤ "NEARBY"는 서비스의 제공에 필요한 경우 정기 점검을 시행할 수 있으며, 정기 점검 시간은 서비스 제공화면에 공지한 바에 따릅니다.</span></p>
								
								<h4>제12조 ("서비스"의 변경)</h4>
								
								<p><span>① "NEARBY"는 상당한 이유가 있는 경우에 운영상, 기술상의 필요에 따라 제공하고 있는 전부 또는 일부 "서비스"를 변경할 수 있습니다.</span></p>
								<p><span>② "서비스"의 내용, 이용 방법, 이용 시간에 대하여 변경이 있는 경우에는 변경 사유, 변경될 서비스의 내용 및 제공 일자 등은 그 변경 전 7일 이상 해당 서비스 초기 화면에 게시하여야 합니다.</span></p>
								<p><span>③ "NEARBY"는 무료로 제공되는 서비스의 일부 또는 전부를 회사의 정책 및 운영의 필요성 수정, 중단, 변경할 수 있으며, 이에 대하여 관련법에 특별한 규정이 없는 한 "회원"에게 별도의 보상을 하지 않습니다.</span></p>
								
								<h4>제13조 (정보의 제공 및 광고의 게재)</h4>
								
								<p><span>① "NEARBY"는 "회원"이 "서비스" 이용 중 필요하다고 인정되는 다양한 정보를 공지사항이나 전자우편 등의 방법으로 "회원"에게 제공할 수 있습니다. 다만, "회원"은 관련법에 따른 거래 관련 정보 및 고객 문의</span></p>
								<p><span>등에 대해 답변 등을 제외하고는 언제든지 전자우편 등에 대해서 수신 거절을 할 수 있습니다.</span></p>
								<p><span>② 제1항의 정보를 전화 및 모사전송기기에 의하여 전송하려고 하는 경우에는 "회원"의 사전 동의를 받아서 전송합니다. 다만, "회원"의 거래 관련 정보 및 고객 문의 등에 대한 회신에 있어서는 제외됩니다.</span></p>
								<p><span>③ "NEARBY"는 "서비스"의 운영과 관련하여 서비스 화면, 홈페이지, 전자우편 등에 광고를 게재할 수 있습니다. 광고가 게재된 전자우편 등을 수신한 "회원"은 수신 거절을 "회사"에 할 수 있습니다.</span></p>
								
								<h4>제14조 ("게시물"의 저작권)</h4>
								
								<p><span>① "회원"이 "서비스" 내에 게시한 "게시물"의 저작권은 해당 게시물의 저작자에게 귀속됩니다.</span></p>
								<p><span>② "회원"이 "서비스" 내에 게시하는 "게시물"은 검색 결과 내지 "서비스"프로모션 등에 노출될 수 있으며, 해당 노출을 위해 필요한 범위 내에서는 일부 수정, 편집되어 게시될 수 있습니다.</span></p>
								<p><span>이 경우, "회원"은 언제든지 고객센터 또는 "서비스" 내 관리 기능을 통해 게시물에 대해 삭제, 검색 결과 제외, 비공개 등의 조처를 할 수 있습니다.</span></p>
								<p><span>③ "NEARBY"는 제2항 이외의 방법으로 "회원"의 "게시물"을 이용하고자 하는 경우에는 전화, 팩스, 전자우편 등을 통해 사전에 "회원"의 동의를 얻어야 합니다.</span></p>
								
								<h4>제15조 ("게시물"의 관리)</h4>
								
								<p><span>① "회원"의"게시물"이 "정보통신망법" 및 "저작권법" 등 관련법에 위반되는 내용을 포함하는 경우, 관리자는 관련법이 정한 절차에 따라 해당 "게시물"의 게시 중단 및 삭제 등을 요청할 수 있으면,</span></p>
								<p><span>"NEARBY"는 관련법에 따라 조치하여야 합니다.</span></p>
								<p><span>② "NEARBY"는 전하에 따른 관리자의 요청이 없는 경우라도 권리 침해가 인정될 만한 사유가 있거나 기타 NEARBY 정책 및 관련법에 따라 해당 "게시물"에 대해 임지 조치 등을</span></p>
								<p><span>취할 수 있습니다.</span></p>
								<p><span>③ 본 조에 따른 세부 절차는 "정보통신망법" 및 "저작권법"이 규정한 범위 내에서 이메일을 통한 "게시 중단 요청 서비스"를 요청 할 수 있습니다.</span></p>
								
								<h4>제16조 (권리의 귀속)</h4>
								
								<p><span>① "서비스"에 대한 저작권 및 지적재산권은 "NEARBY"에 귀속됩니다. 단, "회원"의 "게시물" 및 제휴 계약에 따라 제공된 저작물 등의 제외 합니다.</span></p>
								<p><span>② "NEARBY"는 서비스와 관련하여 "회원"에게 "NEARBY"가 정한 이용조건에 따라 아이디, 콘텐츠 등을 이용할 수 있는 이용권만을 부여하며, "회원"은 이를 양도, 판매, 담보제공 등의 처분행위를 할 수 없습니다.</span></p>
								
								<h4>제17조 (계약 해제, 해지 등)</h4>
								
								<p><span>① "회원"은 언제든지 서비스 초기 화면의 이메일(nearby.corp@gmail.com) 또는 마이페이지 메뉴 등을 통하여 이용계약 해지 신청을 할 수 있으면, "회사"는 관련법 등이 정하는 바에 따라 이를 즉시 처리하여야</span></p>
								<p><span>합니다.</span></p>
								<p><span>② "회원"이 계약을 해지할 경우, 권력 법 및 개인정보 취급 방침에 따라 "NEARBY"가 회원 정보를 보유하는 경우를 제외하고는 해지 즉시 "회원"의 모두 데이터는 소명됩니다.</span></p>
								<p><span>③ "회원"이 계약을 해체하는 경우, "회원"이 작성한 "게시물"은 삭제되지 않으니 사전에 삭제 후 탈퇴하시기 바랍니다.</span></p>
								
								<h4>제18조 (이용 제한 등)</h4>
								
								<p><span>① "NEARBY"는 "회원"이 약관의 의무를 위반하거나 "서비스의 정상적인 운용을 방해한 경우, 계정 강제 삭제 등으로 "서비스" 이용이 제한될 수 있습니다.</span></p>
								<p><span>② "NEARBY"는 전항에도 불구하고, "주민등록법"을 위반한 명의도용, "저작권법" 및 컴퓨터프로그램 보호법"을 위반한 불법 프로그램의 제공 및 운영방해, "정보통신망법"을 위반한 불법 통신 및 해킹,</span></p>
								<p><span>악성프로그램의 배포, 접속 권한 초과 행위 등과 같이 관련법을 위반하였을 때 즉시 영구 이용정지를 할 수 있습니다. 본 항에 따른 영구 이용정지시 "서비스" 이용을 통해 발생하는 상품 수령,</span></p>
								<p><span>On Air 시청 등의 "서비스"를 받을 수 없으며 "NEARBY"는 이에 대해 별도로 보상하지 않습니다.</span></p>
								<p><span>③ "NEARBY"는 "회원"이 계속해서 1년 이상 로그인하지 않는 경우, 회원 정보의 보호 및 운영의 효율성을 위해 이용을 제한 할 수 있습니다.</span></p>
								<p><span>④ 본 조에 따라 "서비스" 이용을 제한하거나 계약을 해지할 때는 "NEARBY"는 "회원"에게 별도의 통지를 하지 않습니다.</span></p>
								<p><span>⑤ "회원"은 본 조에 따른 이용 제한 등에 대해 "NEARBY"가 정한 절차에 따라 이의 신청을 할 수 있습니다. 이때 이의가 정당하다고 "NEARBY"가 인정하는 경우 "NEARBY"는 즉시 "서비스"의 이용을 재개합니다.</span></p>
								
								<h4>제19조 (책임 제한)</h4>
								
								<p><span>① "NEARBY"는 천재지변 또는 이에 준하는 불가항력으로 인하여 "서비스"를 제공할 수 없는 경우에는 "서비스" 제공에 관한 책임이 면제됩니다.</span></p>
								<p><span>② "NEARBY"는 "회원"의 귀책 사유로 인한 "서비스" 이용의 장애에 대하여는 책임을 지지 않습니다.</span></p>
								<p><span>③ "NEARBY"는 "회원"이 "서비스"와 관련하여 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을 지지 않습니다.</span></p>
								<p><span>④ "NEARBY"는 "회원" 간 또는 "회원"과 제3자 상호 간에 "서비스"를 매개로 하여 거래 등을 한 경우에는 책임이 면제됩니다.</span></p>
								<p><span>⑤ "NEARBY"는 무료로 제공되는 서비스 이용과 관련하여 관련법에 특별한 규정이 없는 한 책임을 지지 않습니다.</span></p>
								
								<h4>제20조 (준거법 및 재판관할)</h4>
								
								<p><span>① "NEARBY"와 "회원" 간 제기된 소송은 대한민국 법을 준거법으로 합니다.</span></p>
								<p><span>② "NEARBY"와 "회원"간 발생한 분쟁에 대한 소송은 관할법원에 제소합니다.</span></p> 
								
							</div>
							
						</div>
						<!-- 중간 따로 박스 넣음 -->
						<div class="all_check_wrap2">	
							
							<label>
								<!-- 체크박스 필수 선택 -->
								<input type="checkbox" class="test" name="check" id="check2" class="test"><span>개인정보 수집 및 이용에 대한 안내(필수)</span>
							</label>
							<!-- 보이기, 숨기 -->
							<!-- <input type="button" id="bto_toggle2" value="보기"> -->
						
							<!-- 박스에 스크롤 추가 -->
							<div class="box" id="box2">	
										
								<p><span>정보통신망법 규정에 따라 NEARBY에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.</span></p>
								
								
								<h4>1. 수집하는 개인정보</h4>
								
								<p><span>이용자는 회원가입을 하지 않아도 정보 등 대부분의 NEARBY 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, NEARBY는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.</span></p>
					
							</div>
							
						</div>
						<!-- 중간 따로 박스 넣음 -->
						<div class="all_check_wrap2">	
							
							<label>
								<!-- 체크박스 선택 -->
								<input type="checkbox" class="test" name="check" id="check3"><span>위치정보 이용약관 동의(선택)</span>
							</label>
							
							<!-- 박스에 스크롤 추가 -->
							<!-- 보이기, 숨기 -->
							<!-- <input type="button" id="bto_toggle3" value="보기"> -->
							<div class="box" id="box3">	
					
								<p><span>위치정보 이용약관에 동의하시면, 위치를 활용한 광고 정보 수신 등을 포함하는 NEARBY 위치기반 서비스를 이용할 수 있습니다.</span></p>
								
								
								<h4>제 1 조 (목적)</h4>
								<p><span>이 약관은 NEARBY 주식회사 (이하 “NEARBY”)가 제공하는 위치정보사업 또는 위치기반서비스사업과 관련하여 NEARBY 개인위치정보주체와의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.</span></p>
								
								
								<h4>제 2 조 (약관 외 준칙)</h4>
								<p><span>이 약관에 명시되지 않은 사항은 위치정보의 보호 및 이용 등에 관한 법률, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신기본법, 전기통신사업법 등 관계법령과 회사의 이용약관 및 개인정보취급방침, 회사가 별도로 정한 지침 등에 의합니다.</span></p>
								
								
								<h4>제 3 조 (서비스 내용 및 요금)</h4>
								<p><span>①NEARBY는 직접 위치정보를 수집하거나 위치정보사업자인 이동통신사로부터 위치정보를 전달받아 아래와 같은 위치기반서비스를 제공합니다. 1.Geo Tagging 서비스: 게시글 등록 시점의 개인위치정보주체의 위치정보를 게시글과 함께 저장합니다.</span></p>
								<p><span>2.위치정보를 활용한 검색결과 제공 서비스: 정보 검색을 요청하거나 개인위치정보주체 또는 이동성 있는 기기의 위치정보를 제공 시 본 위치정보를 이용한 검색결과 및 주변결과(맛집, 주변업체, 교통수단 등)를 제시합니다.</span></p>
								<p><span>3.위치정보를 활용한 친구찾기 및 친구맺기: 현재 위치를 활용하여 친구를 찾아주거나 친구를 추천하여 줍니다.</span></p>
								<p><span>4.연락처 교환하기: 위치정보를 활용하여 친구와 연락처를 교환할 수 있습니다.</span></p>
								<p><span>5.현재 위치를 활용한 광고정보 제공 서비스: 광고정보 제공 요청 시 개인위치정보주체의 현 위치를 이용하여 광고소재를 제시합니다.</span></p>
								<p><span>6. 이용자 보호 및 부정 이용 방지: 개인위치정보주체 또는 이동성 있는 기기의 위치를 이용하여 권한없는 자의 비정상적인 서비스 이용 시도 등을 차단합니다.</span></p>
							</div>
							
						</div>
						
					</div>
					<!-- 중간 따로 박스 넣음 -->
					<div class="all_check_wrap">	
					
						<label>
							<!-- 체그박스 선택 -->
							<input type="checkbox" class="test" name="check" id="check4"><span>이벤트 등 프로모션 알림 메일 수신(선택)</span>
						</label>
						
						<div class="right ">
						
							<span>NEARBY에서 제공하는 이벤트/혜택 등 다양한 정보를 휴대전화(NEARBY앱 알림 또는 문자), 이메일로 받아보실 수 있습니다. 일부 서비스(별도 회원 체계로 운영하거나 NEARBY 가입 이후 추가 가입하여 이용하는 서비스 등)의 경우, 개별 서비스에 대해 별도 수신 동의를 받을 수 있으며, 이때에도 수신 동의에 대해 별도로 안내하고 동의를 받습니다.</span>
						
						</div>
						
					</div>
					
					<hr>
					
					<div align="center">
						
						<br/>
						<!-- 동의 클릭 하면 필수 2개 체크 안하면 경고창 나타나고 필수 체그하면 회원가입 페이지로 이동 -->
						<input type="submit" value="동의" id="agreement" >
						
						<input type="reset" value="비동의" id="disagree">
						
					
					</div>
				
				</div>
				
			</div>
			
		</form>
		
	</div>
	
</body>
</html>