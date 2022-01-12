<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Insert title here</title>

<script type="text/javascript">
  $(document).ready(function(){
	 let today = new Date();
	 let year = today.getFullYear();
	 let month = today.getMonth() + 1;
	 let day = today.getDate();
	 
	 $('.today').text(year+"년 "+month +"월 "+ day+"일");
	 
	 fnMemberSearch();
	 
  });

// fnProfileBtn();
function fnShowBtnBox() {
	$('#profile_menu').toggleClass('profile_see profile_no');
}

// 검색 클릭하면 
function fnMemberSearch(){
	$('#search_btn').click(function(){
		// 검색하는 것에 따라 이동경로 다르게 설정함
		if ( $('#column').val() == 'ID' || $('#column').val() == 'NAME' || $('#column').val() == 'M_NO'  ||  $('#column').val() == 'EMAIL'  || $('#column').val() == 'BIRTHDAY' || $('#column').val() == 'GENDER' ) {
			location.href='/nearby/admin/findMember?column=' + $('#column').val() + '&query=' + $('#query').val();				
		}
		else {
			Swal.fire({
                icon: 'error',
                title: '실패',
                text: '잘못입력하셨습니다.',
            });
		}
	})
}

</script>

</head>
<body>

		<jsp:include page="/WEB-INF/views/layout/adminHeader.jsp" flush="true" />

		<!--  <span class="today"></span> 날짜 나옴 -->
		<div class="nearbyInfWrap">
			<div class="nearbyInfo" >
				<div class="totalInfoWrap">
					<ul class="totalInfo">
						<li class="total_info_name" >총 회원 수 </li>
						<li class="total_info_result" >${fn:length(member) }</li>
					</ul>
					<ul class="totalInfo">
						<li class="total_info_name">오늘 가입자</li>
						<li class="total_info_result" >${fn:length(memberCreatedDay) }</li>
					</ul>
					<ul class="totalInfo">
						<li class="total_info_name">총 게시글</li> 
						<li class="total_info_result" >${fn:length(board) }</li>
					</ul>
				</div>
			</div>
		</div>


		<c:forEach var="entry" items="${adminBoardMap}" varStatus="status"> 
		<tr> 
			<td><input type="hidden" value="${entry.key}"  ></td> 
			<td><input type="hidden" value="${entry.value}"  id="${entry.key}"></td> 
		</tr> 
		</c:forEach>


		<input type="hidden" id="men" value="${fn:length(memberMen) } ">
		<input type="hidden" id="women" value="${fn:length(memberWomen) } ">
		<input type="hidden" id="noGender" value="${fn:length(memberNoGender) } ">
		<input type="hidden" id="age10" value="${fn:length(memberAge10)} ">
		<input type="hidden" id="age20" value="${fn:length(memberAge20)} ">
		<input type="hidden" id="age30" value="${fn:length(memberAge30)} ">
		<input type="hidden" id="age40" value="${fn:length(memberAge40)} ">
		<input type="hidden" id="age50" value="${fn:length(memberAge50)} ">

 
		<div class ="chartjs">
		 <div class="genderAndAge">
			<div class ="donutchart"><canvas id="donutchart" height="300" width="500"></canvas></div>
			<div class ="barchart1"><canvas id="barchart1" height="300" width="500"></canvas></div>
		 </div>
			<div class ="barchart2"><canvas id="barchart2" height="300" width="1250"></canvas></div>
		</div>


<script type="text/javascript">
let age10 = $('#age10').val()
let age20 = $('#age20').val()
let age30 = $('#age30').val()
let age40 = $('#age40').val()
let age50 = $('#age50').val()
new Chart(document.getElementById("barchart1"), {
    type: 'bar',
    data: {
      labels: ["10대", "20대", "30대", "40대", "50대이상"],
      datasets: [
        {
          label: "AGE",
          backgroundColor: ["#b5e5e9", "#b5e5e9","#b5e5e9","#b5e5e9","#b5e5e9"],
          data: [age10, age20, age30, age40, age50  ]
        }
      ]
    },
    options: {
      legend: { display: false },
      title: {
        display: true,
        text: '연령별 유저',
        fontSize: 17
      },
      responsive: false     
    }
});
console.log($('#seoul').val())
new Chart(document.getElementById("barchart2"), {
    type: 'bar',
    data: {
      labels: ["서울특별시", "인천광역시", "부산광역시", "대구광역시", "대전광역시","울산광역시","광주광역시","세종특별자치시", "강원도", "경기도", "충청북도",
    	        "충청남도","경상북도","경상남도", "전라남도","전라북도","제주특별자치도"],
      datasets: [
        {
          label: "Location",
          backgroundColor: ["#ffa358", "#ffa358","#ffa358","#ffa358","#ffa358","#ffa358","#ffa358","#ffa358","#ffa358","#ffa358","#ffa358","#ffa358","#ffa358","#ffa358","#ffa358", "#ffa358","#ffa358"],
          data: [ $("#seoul").val() , $("#incheon").val(),  $("#busan").val(), $("#daegu").val(), $("#daejun").val(),
        	      $("#ulsan").val(), $("#gwangju").val(), $("#sejong").val(), $("#gangwon").val(),$("#gyeonggi").val(), 
        	      $("#chungcheongbuk").val(), $("#chungcheongnam").val(), $("#gyeongsangbuk").val(), $("#gyeongsangnam").val(), 
        	      $("#jeollanam").val(), $("#jeollabuk").val(),  $("#jeju").val() ]
        }
      ]
    },
    options: {
      legend: { display: false },
      title: {
        display: true,
        text: '각 지역별 게시글',
        fontSize: 17
      },
      responsive: false
      
    }
    
});

 let men = $('#men').val()
 let women = $('#women').val()
 let noGender = $('#noGender').val()
 console.log(men + noGender + women)
 
var ctx = $('#donutchart').get(0).getContext('2d');
var donutdata =
{
   labels : ["여자", "남자", "선택안함"],
    datasets:
        [{
            backgroundColor: [
            	'rgb(255 122 122)',
            	'rgb(112,212,255)',
            	'#babaad'
            ],
            hoverBorderColor : '#fff',
            data: [women, men, noGender]
        }]
};
var donutoptions = { 
		responsive: false,
		legend : {
			display: true,
			position : 'bottom'
		},
		title: { 
			display: true, 
			text: '유저 성비', 
			fontSize: 17, 
			fontColor: 'rgba(46, 49, 49, 1)' 
		},

		tooltips: {
            displayColors: false, // 툴팁 바 컬러 표시 여부
       },
};
var donutChart = new Chart(ctx,{          
	type: 'doughnut',
	data: donutdata,
	options: donutoptions
});

</script>



</body>
</html>