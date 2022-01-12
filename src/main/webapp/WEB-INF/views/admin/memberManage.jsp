<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminHeader.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/memberManage.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Insert title here</title>

<script type="text/javascript">

  $(document).ready(function(){
	 let today = new Date();
	 let year = today.getFullYear();
	 let month = today.getMonth() + 1;
	 let day = today.getDate();
	 
	 $('.today').text(year+"년 "+month +"월 "+ day+"일");
  });


// fnProfileBtn();
function fnShowBtnBox() {
	$('#profile_menu').toggleClass('profile_see');
}

// 회원 비활성화 ajax
function fnMemberDelete(i){
	
   Swal.fire({
		        text: '유저 번호'+ i+'번을 삭제하겠습니다.',
		        icon: 'warning',
		        showCancelButton: true,
		        closeOnClickOutside: false,
		        confirmButtonColor: '#D4D4D4',  // confirm
		        cancelButtonColor: '#D4D4D4',   // cancel
		        confirmButtonText: '삭제',
		        cancelButtonText: '취소'
		        }).then((result) => {
                    if (result.isConfirmed) {
	                        $.ajax({
									url : "/nearby/admin/deleteMember",
									type: "get",
									data : "mNo="+i,
									dataType: 'json',
									contentType:'application/json',
									success : function(map){
										 if(map.result.result > 0){
										  $('#mNoReInsert'+i).addClass('member_delete');
										  $('#mNo'+i).removeAttr('onclick');
										  location.href="/nearby/admin/findMember";
									 } else {
										 alert('삭제실패');
									 }
									}, 
									error: function(xhr){
										alert('삭제서버 실패');
										console.log(xhr.responseText);
									}
								})
                        }
                })
      }
 
 // 회원 비활->활성
 function fnReInsert(i){

	  Swal.fire({
			//title: '정말로 삭제하시겠습니까',
	        text: '유저 번호'+ i+'번을 활성화시키겠습니다.',
	        icon: 'warning',
	        closeOnClickOutside: false,
	        showCancelButton: true,
	        confirmButtonColor: '#D4D4D4',  // confirm
	        cancelButtonColor: '#D4D4D4',   // cancel,
	        closeOnConfirm : false,
	        confirmButtonText: '활성화',
	        cancelButtonText: '취소'
	        }).then((result) => {
              if (result.isConfirmed) {
           
                      $.ajax({
                    		url : "/nearby/admin/reInsertMember",
            				type: "get",
            				data : "mNo="+i,
            				dataType: 'json',
            				contentType:'application/json',
            				success : function(map){
            				 if(map.result.result > 0){
            					 $('#mNo'+i).addClass('member_delete');
            					 location.href="/nearby/admin/findMember";
            				 } else {
            					// alert('삭제실패');
            				 }
            				}, 
            				error: function(xhr){
            				//	alert('삭제서버 실패');
            					console.log(xhr.responseText);
            				}
					 }) // ajax
                }
          }) // 
 }
</script>

</head>
<body>
	<header class="header">
		<jsp:include page="/WEB-INF/views/layout/adminHeader.jsp" flush="true" />
	</header>
    
    <c:if test="${map.query == null }">
		 <div class="search_result">전체 회원 목록 </div>
	</c:if>
   

	<c:if test="${map.query != null }">
		 <div class="search_result">"${map.query}" 검색결과  ${map.cnt}명이 조회되었습니다. </div>
	</c:if>
<input type="hidden" value="${map.cnt}" id="cnt">


<div class="search_result_wrap">
<table class="memberSearch" id="memberSearch">
		<thead>
			<tr class="list_thead">
			
				<td>회원번호</td>
				<td>아이디</td>
				<td>이름</td>
				<td>이메일</td>
				<td>생일</td>
				<td>번호</td>
				<td>성별</td>
				<td>가입일</td>
				<td>회원비활성화</td>
			</tr>
		</thead>
		<tbody>

		<c:if test="${map.searchResult != null }">
		 <c:forEach items="${map.searchResult}" var="memberSearch" varStatus="vs">
			<tr>
				<td>${memberSearch.mNo}</td>
				<td>${memberSearch.id}</td>
				<td>${memberSearch.name}</td>
				<td>${memberSearch.email}</td>
				<td>${memberSearch.birthday}</td>
				<td>${memberSearch.phone}</td>
				<c:if test="${memberSearch.gender == 'f'}"><td>F</td></c:if>
				<c:if test="${memberSearch.gender == 'm'}"><td>M</td></c:if>
				<c:if test="${memberSearch.gender == 'n'}"><td>N</td></c:if>
				<td><fmt:formatDate value="${memberSearch.mCreated}" pattern="yyyy-MM-dd " /></td>
				<c:if test="${memberSearch.state == 0 }">
					<td><i class="fas fa-user user_cursor" id="mNo${memberSearch.mNo}" onclick="fnMemberDelete(${memberSearch.mNo})" ></i></td>
				</c:if>
				<c:if test="${memberSearch.state == -1 }">
					<td><i class="fas fa-user member_delete" id="mNoReInsert${memberSearch.mNo}" onclick="fnReInsert(${memberSearch.mNo})" ></i></td>
				</c:if>
			</tr>
		 </c:forEach>
		</c:if>
			
		</tbody>
		<tfoot>
			<tr>
				<td colspan="9">${map.pageEntity}</td>			
			</tr>
		</tfoot>
	</table>
</div>


</body>
</html>