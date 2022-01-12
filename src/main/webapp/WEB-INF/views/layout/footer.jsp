<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
	integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style>
	* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 14px;
	
	}

	a {
	text-decoration: none;
	color: black;
	}
	footer_wrap ul, li {
	list-style-type: none;
	float: left;
	}
	.footer_container {
		border: 1px solid black;
		background-color: #232323;
		width: 100%;
		height: 530px;
	}
	.footer_wrap {
		margin: 50px;
	}
	.footer_top {
		display: flex;
	}
	
	.footer_top_left {
		margin-left: 100px;
	}
	.footer_top_right {
		margin-top: 30px;
		margin-left: 60px;
		color: white;
		
	}
	.footer_top_right ul li {
		margin-left: 30px;
	}
	.footer_top_right ul li a {	
		color: #737273;
		font-size: 16px;
		font-weight: 300;
	}
	.footer_top_right ul li a:hover {
		color: rgb(180, 180, 180);
		font-weight: 400;		
	}
	.footer_mid {
		display: flex;
	}
	.footer_mid_icon_box {
		width: 700px;
		height: 50px;
		margin-left: 1440px;
	}
	.footer_mid_icon_box i{
		color: #737273;
		margin-left: 30px;
		font-size: 30px;
	}
	.footer_mid_icon_box i:hover {
		color: rgb(180, 180, 180);
		font-weight: 400;		
	}	
	
	
	.footer_bot {
		width:	1600px;
		height: 150px;
		border-top: 1px solid #737273;
		margin: 0 auto;
	}
	.footer_bot_left {
		margin-top: 10px;
	}
	
	.footer_bot_left p{
		color: #737273;
	}
	.copyright_text {
		margin-top: 30px;
		text-align: center;
		color: #737273;
	}
</style>
<script type="text/javascript">
		
</script>

<div class="footer_container">
	<div class="footer_wrap">
		<div class="footer_top">
			<div class="footer_top_left">
				<img id="logo" src="${pageContext.request.contextPath}/resources/image/logo_white.png" width="300px">	
			</div>
			<div class="footer_top_right">
				<ul>
					<li><a href="#">회사소개</a></li>
					<li><a href="#">법인경영</a></li>
					<li><a href="#">사이트맵</a></li>
					<li><a href="#">개발자</a></li>
					<li><a href="#">이용약관</a></li>
					<li><a href="#">개인정보처리방침</a></li>
				</ul>
			</div>
		</div>
		<div class="footer_mid">
			<div class="footer_mid_icon_box">
			<a title="인스타그램" href="#"><i class="fab fa-instagram"></i></a>
			<a title="페이스북" href="#"><i class="fab fa-facebook"></i></a>
			<a title="유튜브" href="#"><i class="fab fa-youtube"></i></a>
			<a title="트위터" href="#"><i class="fab fa-twitter"></i></a>
			</div>
		</div>
		<div class="footer_bot">
			<div class="footer_bot_left">
				<p>(주)NEARBY CORPS.</p>   
				<p>주소: 서울특별시 동대문구 장안동 444-2(천호대로91길 57)</p>
				<p>개인정보보호책임자: 박종진 상무</p>
				<p>대표전화 : 1588-9999*(유료)</p>
				
			</div>
			
			<p class="copyright_text">COPYRIGHT© 2022 NEARBY.ALL RIGHTS RESERVED.</p>
		</div>
	</div>
</div>

