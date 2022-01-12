<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- fontawesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>

	@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
	
	 * { 
	 font-family: 'Noto Sans KR', sans-serif;
	 margin: 0;
	 padding: 0;
	 box-sizing: border-box;
	}
	
	body {	/* 요소는 HTML 문서의 내용을 나타냅니다. 한 문서에 하나의 전체화면에 색상추가	*/
		background-color: rgb(240,242,245);
	}
	
	.container {	/* 전체 박스 */
		border-radius: 10px;
		margin: 20px auto;
		width: 600px;
	    padding-bottom: 20px;
		background-color: #FFFFFF;
		box-shadow: 10px 10px 20px 10px #cbcdcf;	/* 속성은 요소의 테두리를 감싼 그림자 효과를 추가 */
	}
	
	.under_box {	/* 좌측상단 회원가입 */
		margin-left: 20px;	/* 글자 왼쪽으로 20px이동 한다. */
	}
	
	#lt { /* < 색상 추가 */
		display: inline-block;
		color: #fe495c;
	}
	
	.under {	/* 글자 위치 */
		display: inline-block;
		margin-top: 10px;
		margin-left: 20px;
		text-decoration: none;
		font-size: 13px;
		cursor: pointer;
		color: black;
	}
	.fa-reply {	/* 글자 크기와색상 */
		font-size: 13px;
		color:  #fe495c;
	}
	
	.center {	/* 글자 정가은데 위치로 이동	*/
		text-align: center;
	}
	
	#logo_box {	/* 이미지와 서비스 연결한는 부모 */
		display: flex;
		text-align: center;
		padding-left: 30px;
		margin-top: 20px;
	}
	
	h1 {	/* 글자 자식 */
		display: inline-block;
		line-height: 75px;
	}
	
	#logo_icon {	/* 이미지 자식 */
		display: inline-block;
		width: 156px;
		height: 60px;
		margin-left: 36px;
		margin-top: 10px;
	}
	
	#thing {	/* 글자 위 올리기와 글자 오른쪽 으로 위치 */
		text-align: right;
		margin-right: 40px;
		margin-top: 15px;
		align-content: start;
		position: relative;	/* 속성은 문서 상에 요소를 배치하는 방법을 지정합니다	*/
		bottom: 30px;	/* 글자 올라가기 속성 요소 */
	}
	
	.ce {	/* 글자 좌우 위치 */
		margin: 40px;
	}
	
	h4 {	/* h4 태그 글자크기와 글자 색상 */
		color: #fe495c;
		font-size: 18px;
		margin-top: 25px;
		margin-bottom: 5px;
	}
	
	.box {	/* 아래 회원가입 돌아가기 박스 */
		text-align: center;
     	margin-top: 40px;
     	height: 35px;
     	border-radius: 8px;
        background-color: #fe4b60;
	}
	
	.pol {	/* 아래 회원가입 돌아가기	*/
		margin-top: 48px;
	    width: 100px;
	    height: 30px;
	    font-size: 15px;
	    line-height: 34px;
		text-decoration: none;
        color: #FFFFFF;
	}
	
	p span{  /* p태그에부모 있는 span태그자식 글자 크기  */
		font-size: 14px;
	}
	
</style>
</head>
<body>

	<div class="container">	<!-- 전체 박스 -->
	
		<div id="under_box">	<!-- 좌측상단 회원가입 -->
		
			<a class="under" href="/nearby/member/memberJoin"><i class="fas fa-reply" ></i> 회원가입 돌아가기</a>
			
		</div>
		
			<div class="center">	<!-- 중간 -->
			
				<div id="logo_box">	<!-- 이미지와 서비스 연결한는  -->
				
					<!-- 이미지 클리하면 전페이지 이동하기  -->
					<a href="/nearby/"><img id="logo_icon" src="${pageContext.request.contextPath}/resources/image/logo_color.png" width="200px;"></a>
					<h1>서비스 이용 약관</h1>
					
				</div>
				
				<!-- 글자 크기12px 글자색 :횐색으로  -->
				<p style="font-size: 12px; color: gray;" id="thing">최종 수정일:2021년 12월 31일</p>
			
			</div>
			
			<div class="ce">	<!-- ce: 글자 좌우 가운데 위치로 이동 박스 서비스 설명한 span:글자 크기와 &nbsp; 사이에 벌어져 -->
			
				<p><span>NEARBY에 오신것을 환영합니다.</span></p>
				<p><span>NEARBY는 사람들이 서로 교류하고 커뮤니티를 만들며 비즈니스를	성장시킬 수 있는 기술과 서비스를 개발합니다. (본 약관이 아니) 별도의 약관이 적용된다고 명시되어 있지 않은 한, 본 약관은 회원님의 NEARBY및 기타 NEARBY가 제공하는 제품하는 제품, 기능, 앱, 서브스, 기술, 소프트웨어 이용에 적용됩니다. 이런한 제품은 NEARBY,lnc.가	제공합니다.</span></p>
				
				<h4>제 1조 (목적)</h4>
				
				<p><span>이 약관은 NEARBY,lnc(이하"NARBY")가 제공하는 NEARBY 관련	제반 서비스의 이용과 관련하여 회원과의 권리, 의무 및 책임 사항,	기타 필요한 사항을 규정함을 목적으로 합니다</span></p>
				
				<h4>제 2조 (정의)</h4>
				
				<p><span>이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</span></p>
				<p><span>① "서비스"라 함은 구현되는 단말기(PC, TV, 휴대형단말기 등의 각종 유무선 장치를 포함)와 상관 없이 "회원"이 이용할 수 있는 NEARBY,lnc 및 NEARBY,lnc 관련 제반 서비스를 의미합니다.</span></p>
				<p><span>② "회원"이라 함은 NEARBY의 "서비스"에 접속하여 이 약관에 따라 "NEARBY"와 이용계약을 체결하고 "NEARBY"가 제공하는 "서비스"를 이용하는 고객을 말합니다.</span></p>
				<p><span>③ "아이디(ID)"라 함은 "회원"의 식별과 "서비스"이용을 위하여 "회원"이 정하고 "NEARBY"가 승인하는 SNS계정을 의미합니다.</span></p>
				<p><span>④ "비밀번호"라 함은 "회원"이 선택한 아이디(SNS계정) 의 비밀번호를 의미합니다.</span></p>
				<p><span>⑤ "게시물"이라 함은 "회원"이 "서비스"를 이용함에 있어 "서비스상"에 게시한부호 · 문자 · 음성 · 음향 · 화상 · 동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다.</span></p>
				
				<h4>제 3조 (약관의 게시와 개정)</h4>
				
				<p><span>① "NEARBY"는 이 약관의 내용을 "회원"이 쉽게 알 수 있도록 서비스 초기 화면에 게시합니다.</span></p>
				<p><span>② "NEARBY"는 "약관의 규제에 관한 법률", "정보통신망이용촉진 및 정보보호 등에 관한 법률(이하 "정보통신망법") 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</span></p>
				<p><span>③ "NEARBY"가 약관을 개정 할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 제1항의 방식에 따라 그 개정약관의 적용일자 30일 전부터 적용일자 전일까지 공지합니다.</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;단, "회원"의 권리, 의무에 중대한 영향을 주는 변경이 아닌 경우에는 적용일자 7일 전부터 공지하도록 합니다.</span></p>
				<p><span>④ 전항에 따라 시행일 이후에 "회원"이 "서비스"를 이용하는 경우에는 개정약관에 동의한것으로 간주합니다. "회원"은 변경된 약관에 동의하지 않을 경우 이용계약을 해지할 수 있습니다.</span></p>
				
				<h4>제 4조 (이용게약 체결)</h4>
				
				<p><span>① 이용계약"회원"이 되고자 하는자(이하 "가입신천자")가 약관이 내용에 대하여 동의를 한 다음 회원가임신청을 하고 "NEARBY"가 이러한 신청에 대하여 승낙함으로써 체결딥니다.</span></p>
				<p><span>② "NEARBY"는 "가임신천자"의 신청에 대하여 "서브스" 이용을 승낙함을 원칙으로 합니다. 다만, "NEARBY"는 다음 각 호에 해당하는 신청에 대하여는 승낙을 하지 않거나 사후에 이용게약을 해지할 수 있습니다.</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;1. 가입신청자가 이 약관에 의하여 이전에 회원자격을 상실하 적이 있는 경우, 다만, 회원자격 상실후 1년이 경과한 자로사 "NEARBY"의 회원 재 가입 승낙을 어은 경우에는 에외로 함.</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;2. 설명이 아니거나 타인의 명의를 이용한 경우</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;3. 허위의 정보를 기재하거나, "NEARBY"가 제시하는 내용을 기재하지 않은 경우</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;4. 이용자의 귀책가유로 인하여 승인이 불가능하거나 기타 규정한 제반 사항을 위반하여 신천하는 경우</span></p>
				<p><span>③ 제1항에 따른 신천에 있는 "NEARBY"는 "회원"의 종류에 따라 전문기관을 통하 실명확인 및 본인인증을 요청할 수 있습니다.</span></p>
				<p><span>④ "NEARBY"는 서브스관련설비의 여우가 없거나, 기술상 또는 업무상 문제가 있는 경우에는 승낙을 유보할 수 있습니다.</span></p>
				<p><span>⑤ 제2항과 제4항에 따라 회원가입신청의 승낙을 하지 아니하거나 유보한 경우, "NEARBY"는 원칙적으로 이를 가입신청자에게 알리도록 합니다.</span></p>
				<p><span>⑥ 이용계약의 성립 시기는 "NEARBY"가 가입완료를 신청절차 상에서 표시한 시점으로 합니다.</span></p>
				<p><span>⑦ "NEARBY"는 "회원"에 대하여 "영화 및 비디오물의 진흥에 관한법률" 및 "청소년보호법"등에 따른 등급 및 연령 준수를 위해 이용제한이나 등급별 제한을 할 수 있습니다.</span></p>
				
				<h4>제 5조 (회원정보의 변경)</h4>
				
				<p><span>① "회원"은 마이페이지화면을 통하여 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다. 다만, 서비스 관리를 위해 필요한 e-mail은 수정이 불가능합니다.</span></p>
				<p><span>② "회원"은 상품관련 수령을 위한 주소 및 연락처를 온라인으로 비밀글 게시판에 등록해 "NEARBY"에 알릴 수 있으며, "NEARBY"는 상품발송이외의 목적으로 이용하지 않으며 이용 이후 즉시 파기 합니다.</span></p>
				<p><span>③ 제2항의 상품관련 수령을 위한 주소 및 연락처를 "NEARBY"에 알리지 않아 발생한 불이익에 대하여 "NEARBY"는 책임지지 않습니다.</span></p>
				
				<h4>제 6조 (개인정보보호 의무)</h4>
				
				<p><span>"NEARBY"는 "정보통신망법" 등 관계 법령이 정하는 바에 따라 "회원"의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련법 및 "NEARBY"의 개인정보취급방침이 적용됩니다. 다만, "NEARBY"의 공식 사이트 이외의 링크된 사이트에서는 "NEARBY"의 개인정보취급방침이 적용되지 않습니다.</span></p>
				
				<h4>제 7조 (회원의 아이디 및 비밀번호의 관리에 대한 의무)</h4>
				
				<p><span>① "회원"의 "아이디"와 "비밀번호" 에 관리책임은 "회원"에게 있으면, 이를 제3자가 이용도록 하여는 안 됩니다.</span></p>
				<p><span>② "NEARBY"는 "회원"의 "아이디"가 개인정보 유출 우려가 있거나, 반사회적 또는 미풍양속에 어긋나거나 "NEARBY" 및 "NEARBY"의 운영자로 오인할 우려가 있는 경우, 해당 "아이디"의 이용을 제한할 수 있습니다.</span></p>
				<p><span>③ "회원"은 "아이디" 및 "비밀번호"가 도용되거나 제3자가 사용하고 인지한 경우에는 이를 즉시 "NEARBY"에 통지하고 "NEARBY"의 안내에 따라야 합니다.</span></p>
				<p><span>④ 제3힝의 경우에 해당 "회원"이 "회사"에 그 사실을 통지하지 않거나, 통지한 경우에도 "NEARBY"의 안내에 따르지 않아 발생한 불이익에 대하여"NEARBY"는 책임지지 않습니다.</span></p>
			
				<h4>제 8조 (회원에 대한 통지)</h4>
				
				<p><span>① "NEARBY"가 "회원"에 대한 통지를 하는 경우 이 약관에 별도 규정이 없는 한 "회원"이 지정한 전자우편주소를 할 수 있습니다.</span></p>
				<p><span>② "NEARBY"는 "회원" 전체에 대한 통지의 경우 7일 이상 "NEARBY"의 게시판에 게시함으로 제1항의 통지에 갈음할 수 있습니다.</span></p>
				
				<h4>제 9조 ("NEARBY"의 의무)</h4>
				
				<p><span>① "NEARBY"는 관련법과 이 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적이고 안정적으로 "서비스"를 제공하기 위하여 최선을 다하여 노력합니다.</span></p>
				<p><span>② "NEARBY"는 "회원"이 안전하게 "서비스"를 이용 할 수 있도록 개인정보 보호를 위해 보안시스템을 갖추어야 하며 개인정보취급방침을 공시하고 준수합니다.</span></p>
				<p><span>③ "NEARBY"는 서비스이용과 관련하여 "회원"으로부터 제기된 의견이나 불만이 정당하다고 인정할 경우에는 이를 처리하여야 합니다. "회원"이 제기한 의견이나 불만사항에 대해서는 게시판을 활용하거나</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;전자우편 등을 통하여 "회원"에게 처리과정 및 결과를 전달합니다.</span></p>
				
				<h4>제 10조 ("회원"의 의무)</h4>
				
				<p><span>① "회원"은 다음 행위를 하여서는 안 됩니다.</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;1. 신청 또는 변경 시 허위내용의 등록</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;2. 타인의 정보도용</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;3. "NEARBY"가 게시한 정보의 변경</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;4. "NEARBY"가 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;5. "NEARBY"와 기타 제3자의 저작권 등 지적재산권에 대한 침해</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;6. "NEARBY" 및 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 "서비스"에 공개 또는 게시하는 행위</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;8. NEARBY의 동의 없이 영리를 목적으로 "서비스"를 사용하는 행위</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;9. 기타 불법적이거나 부당한 행위</span></p>
				<p><span>② "회원"은 관계법, 이 약관의 규정, 이용안내 및 "서비스"와 관련하여 공지한 주의사항, "NEARBY"가 통지하는 사항 등을 준수하여야 하며, 기타 "NEARBY"의 업무에 방해되는 행위를 하여서는 안됩니다.</span></p>
				
				<h4>제 11 조 (서비스의 제공 등)</h4>
				
				<p><span>① NEARBY는 회원에게 아래와 같은서비스를 제공합니다.</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;1. 검색 서비스</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;2. 게시판형 서비스</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;3. VOD서비스 (OnAir, 다시보기)</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;4. News 기사 제공 서비스</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;5. 기타 "회사가" 추가 개발하거나 다른 회사와의 제휴계약 등을 통해 "회원"에게 제공하는 일체의 서비스</span></p>
				<p><span>② NEARBY는 "서비스"를 일정범위로 분할하여 각 범위 별로 이용가능시간을 별도로 지정할 수 있습니다. 다만, 이러한 경우에는 그 내용을 사전에 공지합니다.</span></p>
				<p><span>③ "서비스"는 연중무휴, 1일 24시간 제공함을 원칙으로 합니다.</span></p>
				<p><span>④ "NEARBY"는 컴퓨터 등 정보통신설비의 보수점검, 교체 및 고장, 통신두절 또는 운영상 당당한 이유가 있는경우 "서비스"의 제공을 일시적으로 중단할 수 있습니다. 이 경우 "NEARBY"는 제8조(회원에 대한 통지)에</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;정한 방법으로 "회원"에게 통지합니다. 다만, "NEARBY"가 사전에 통지할 수 없는 부득이한 사유가 있는 경우 사후에 통지할 수 있습니다</span></p>
				<p><span>⑤ "NEARBY"는 서비스의 제공에 필요한 경우 정기점검을 실시할 수 있으며, 정기점검시간은 서비스제공화면에 공지한 바에 따릅니다.</span></p>
				
				<h4>제 12 조 ("서비스"의 변경)</h4>
				
				<p><span>① "NEARBY"는 상당한 이유가 있는 경우에 운영상, 기술상의 필요에 따라 제공하고 있는 전부 또는 일부 "서비스"를 변경할 수 있습니다.</span></p>
				<p><span>② "서비스"의 내용, 이용방법, 이용시간에 대하여 변경이 있는 경우에는 변경사유, 변경될 서비스의 내용 및 제공일자 등은 그 변경 전 7일 이상 해당 서비스 초기화면에 게시하여야 합니다.</span></p>
				<p><span>③ "NEARBY"는 무료로 제공되는 서비스의 일부 또는 전부를 회사의 정책 및 운영의 필요상 수정, 중단, 변경할 수 있으며, 이에 대하여 관련법에 특별한 규정이 없는 한 "회원"에게 별도의 보상을 하지 않습니다.</span></p>
				
				<h4>제 13 조 (정보의 제공 및 광고의 게재)</h4>
				
				<p><span>① "NEARBY"는 "회원"이 "서비스" 이용 중 필요하다고 인정되는 다양한 정보를 공지사항이나 전자우편 등의 방법으로 "회원"에게 제공할 수 있습니다. 다만, "회원"은 관련법에 따른 거래관련 정보 및 고객문의</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;등에 대해 답변 등을 제외하고는 언제든지 전자우편 등에 대해서 수신 거절을 할 수 있습니다.</span></p>
				<p><span>② 제1항의 정보를 전화 및 모사전송기기에 의하여 전송하려고 하는 경우에는 "회원"의 사전 동의를 받아서 전송합니다. 다만, "회원"의 거래관련 정보 및 고객문의 등에 대한 회신에 있어서는 제외 됩니다.</span></p>
				<p><span>③ "NEARBY"는 "서비스"의 운영과 관련하여 서비스 화면, 홈페이지, 전자우편 등에 광고를 게재할 수 있습니다. 광고가 게재된 전자우편 등을 수신한 "회원"은 수신거절을 "회사"에게 할 수 있습니다.</span></p>
				
				<h4>제 14 조 ("게시물"의 저작권)</h4>
				
				<p><span>① "회원"이 "서비스"내에 게시한 "게시물"의 저작권은 해당 게시물의 저작자에게 귀속됩니다.</span></p>
				<p><span>② "회원"이 "서비스"내에 게시하는 "게시물"은 검색결과 내지 "서비스"프로모션 등에 노출될 수 있으며, 해당 노출을 위해 필요한 범위 내에서는 일부 수정, 편집되어 게시될 수 있습니다.</span></p>
				<p><span>&nbsp; &nbsp; &nbsp; 이 경우, "회원"은 언제든지 고객센터 또는 "서비스"내 관리 기능을 통해 게시물에 대해 삭제, 검색결과 제외, 비공개 등의 조치를 취할 수 있습니다.</span></p>
				<p><span>③ "NEARBY"는 제2항 이외의 방법으로 "회원"의 "게시물"을 이용하고자 하는 경우에는 전화, 팩스, 전자우편 등을 통해 사전에 "회원"의 동의를 얻어야 합니다.</span></p>
				
				<h4>제 15 조 ("게시물"의 관리)</h4>
				
				<p><span>① "회원"의"게시물"이 "정보통신망법" 및 "저작권법"등 관련법에 위반되는 내용을 포함하는 경우, 관리자는 관련법이 정한 절차에 따라 해당 "게시물"의 게시중단 및 삭제 등을 요청할 수 있으면,</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;"NEARBY"는 관련법에 따라 조치를 취하여야 합니다.</span></p>
				<p><span>② "NEARBY"는 전하에 따른 관리자의 요청이 없는 경우라도 권리치해가 인정될 만한 사유가 있거나 기타 NEARBY 정책 및 관련법에 따라 해당 "게시물"에 대해 임지조치 등을</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;취할 수 있습니다.</span></p>
				<p><span>③ 본 조에 따른 세부절차는 "정보통신망법" 및 "저작권법"이 규정한 범위 내에서 이메일을 통한 "게시중단요청서비스"를 요청 할수 있습니다.</span></p>
				
				<h4>제 16 조 (권리의 귀속)</h4>
				
				<p><span>① "서비스"에 대한 저작권 및 지적재산권은 "NEARBY"에 귀속됩니다. 단, "회원"의 "게시물"및 제휴계약에 따라 제공된 저작물 등의 제외 합니다.</span></p>
				<p><span>② "NEARBY"는 서비스와 관련하여 "회원"에게 "NEARBY"가 정한 이용조건에 따라 아이디, 콘텐츠등을 이용할 수 있는 이용권만을 부여하며, "회원"은 이를 양도,판매,담보제공 등의 처분행위를 할 수 없습니다.</span></p>
				
				<h4>제 17 조 (계약 해제, 해지 등)</h4>
				
				<p><span>① "회원"은 언제든지 서비스 초기하면의 이메일(nearby.corp@gmail.com)또는 마이페이지 메뉴등을 통하여 이용계약 해지 신청을 할 수 있으면, "회사"는 관련법 등이 정하는 바에 따라 이를 즉시 처리하여야</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;합니다.</span></p>
				<p><span>② "회원"이 계약을 해지할 경우, 권력법 및 개인정보취급방침에 따라 "NEARBY"가 회원정보를 보유하는 경우를 제외하고는 해지 즉시 "회원"의 모둔 데이터는 소명됩니다.</span></p>
				<p><span>③ "회원"이 계약을 해치하는경우, "회원"이 작성한 "게시물"은 삭제되지 않으니 사전에 삭제 후 탈퇴하시기 바람니다.</span></p>
				
				<h4>제 18 조 (이용제한 등)</h4>
				
				<p><span>① "NEARBY"는 "회원"이 약관의 의무를 위반하거나 "서비스의 정상적인 운용을 방해한경우, 게정강제삭제 등으로 "서비스" 이용이 제하될 수 있습니다.</span></p>
				<p><span>② "NEARBY"는 전항에도 불구하고, "주민등록법"을 위반한 명의도용, "저작권법" 및 컴퓨터프로그램보호법"을 위반한 불법프로그램의 제공 및 운영방해, "정보통신망법"을 위반한 불법통신 및 해킹,</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;악성프로그램의 배포, 접속권한 초과행위 등과 같이 관련법을 위반한 경우에는 즉시 영구이용정지를 할 수 있습니다. 본 항에 따른 영구이용정지 시 "서비스"이용을 통해 발생하는 상품수령,</span></p>
				<p><span>&nbsp; &nbsp; &nbsp;OnAir 시청 등의 "서비스"를 받을수 없으며 "NEARBY"는 이에 대해 별도로 보상하지 않습니다.</span></p>
				<p><span>③ "NEARBY"는 "회원"이 계속해서 1년 이상 로그인 하지 않는 경우, 회원정보의 보호 및 운영의 효율성을 위해 이용을 제한 할 수 있습니다.</span></p>
				<p><span>④ 본 조에 따라 "서비스"이용을 제한하거나 계약을 해지하는 경우에는 "NEARBY"는 "회원"에게 별도의 통지를 하지 않습니다.</span></p>
				<p><span>⑤ "회원"은 본 조에 따른 이용제한 등에 대해 "NEARBY"가 정한 절차에 따라 이의 신청을 할 수 있습니다. 이 때 이의가 정당하다고 "NEARBY"가 인정하는 경우 "NEARBY"는 즉시 "서비스"의 이용을 재개합니다.</span></p>
				
				<h4>제 19 조 (책임제한)</h4>
				
				<p><span>① "NEARBY"는 천재지변 또는 이에 준하는 불가항력으로 인하여 "서비스"를 제공 할 수 없는 경우에는 "서비스" 제공에 관한 책임이 면제됩니다.</span></p>
				<p><span>② "NEARBY"는 천재지변 또는 이에 준하는 불가항력으로 인하여 "서비스"를 제공 할 수 없는 경우에는 "서비스" 제공에 관한 책임이 면제됩니다.</span></p>
				<p><span>③ "NEARBY"는 "회원"이 "서비스"와 관련하여 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을 지지 않습니다.</span></p>
				<p><span>④ "NEARBY"는 "회원" 간 또는 "회원"과 제3자 상호간에 "서비스"를 매개로 하여 거래 등을 한 경우에는 책임이 면제됩니다.</span></p>
				<p><span>⑤ "NEARBY"는 무료로 제공되는 서비스 이용과 관련하여 관련법에 특별한 규정이 없는 한 책임을 지지 않습니다.</span></p>
				
				<h4>제 20 조 (준거법 및 재판관할)</h4>
				
				<p><span>① "NEARBY"와 "회원" 간 제기된 소송은 대한민국법을 준거법으로 합니다.</span></p>
				<p><span>② "NEARBY"와 "회원"간 발생한 분쟁에 관한 소송은 관할법원에 제소합니다.</span></p>
				
				<div class="box">	<!-- 아래 회원가입 돌아가기 -->
				
					<a class="pol" href="/nearby/member/memberJoin">회원가입 돌아가기</a>
					
				</div>
			
			</div>
	
	</div>	

</body>
</html>