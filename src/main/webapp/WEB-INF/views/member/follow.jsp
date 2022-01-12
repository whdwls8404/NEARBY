<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/follow.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script type="text/javascript">

	$(document).ready(function(){
		fnFollowSeeNo();
		fnCheckFollow();
		fnCheckLogin();
	});
	
	function fnFollowSeeNo(){
		$('#right_select_box').click(function (){
			$('#right_select_box').addClass('checked').removeClass('unchecked');
			$('#left_select_box').addClass('unchecked').removeClass('checked');
			$('#right_follow_box').addClass('follow_see').removeClass('follow_no');
			$('#left_follow_box').addClass('follow_no').removeClass('follow_see');
			$('#follower_text').addClass('unchecked1').removeClass('checked1');
			$('#following_text').addClass('checked1').removeClass('unchecked1');		
			
		});
		
		$('#left_select_box').click(function (){
			$('#left_select_box').addClass('checked').removeClass('unchecked');// 'border-bottom-right-radius':'0' );
			$('#right_select_box').addClass('unchecked').removeClass('checked');//'border-bottom-left-radius':'10px' );
			$('#right_follow_box').addClass('follow_no').removeClass('follow_see');
			$('#left_follow_box').addClass('follow_see').removeClass('follow_no');
			$('#follower_text').addClass('checked1').removeClass('unchecked1');		
			$('#following_text').addClass('unchecked1').removeClass('checked1');
		});   
	}
	//fnCheckFollow();
	function fnCheckFollow() {
		let pId = '${user[0].profile.id}';
		let follow = JSON.stringify({
	  	  profile : {id : pId} 
		  	});
		$.ajax({
			url: '/nearby/follow/checkFollow',
			type: 'post',
			data: follow,
	  	  	contentType: 'application/json',
	  	  	dataType: 'json',
		    success: function(map) {
		    	  console.log(map);
		    	  if(map.result == 1) { 
			    	  console.log('팔로잉중');
			    	 
			    	 
		    	  	
		    	  
		    	  } else if (map.result == 0) {
		    	 	  console.log('팔로우하기');		  
		    	 	 
		    	 	  
		    	 	  
		    	  }
		    	 
		    	  
		    	  
		      },
		     error: function(xhr) {
		    	  console.log(xhr.responseText);
		     }
		});
		
	}
	// fnMoveUserHome();
	function fnMoveUserHome(id) {
		location.href='/nearby/board/selectUserHome?id='+ id; 
	}
	/* ----------------------------------------- fnCheckLogin() --------------------------------  */
 	function fnCheckLogin(){
		let loginInfo = '${loginUser.id}';
		console.log('logincheck ???? : ' + loginInfo);
		if (loginInfo == '') {
			
		 Swal.fire({
				text: '로그인 세션이 만료되었습니다. 로그인 화면으로 이동하시겠습니까?',
		        icon: 'warning',
		        showCancelButton: true,
		        confirmButtonColor: '#D4D4D4',  // confirm
		        cancelButtonColor: '#D4D4D4',   // cancel
		        confirmButtonText: '이동',
		        cancelButtonText: '취소'	
		     }).then((result) => {
				if(result.isConfirmed) { // confirm이 false이면 return
					location.href='/nearby/';
				}
		     })
		}
	}	 	 		

	
	
	
	
	
</script>
<style>




</style>
</head>
<body>
	<header class="header">
		<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
	</header>
	
	
	<section class="board">

       <!-- 프로필 사진, 이름, 게시물, 팔로워, 팔로잉, 프로필 설정-->
        <div class="user_box">
            <div class="user_img_box">
            	<c:if test="${empty loginUser.profile.pSaved}">
            		<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="pointer defaultImg">
            	</c:if>
            	<c:if test="${not empty loginUser.profile.pSaved}">
            		<img id="user_img" src="/nearby/${loginUser.profile.pPath}/${loginUser.profile.pSaved}" class="pointer">         	
            	</c:if>
            </div>
            
        	<div class="user_item_box">
                <span>${loginUser.id}</span>
				
				<div class="friend_box">
					<c:if test="${not empty followingList}">
						<c:forEach items="${followingList}"  var="followingList" begin="0" end="4">
								
								<c:if test="${empty followingList.profile.pSaved}">
									<img title="${followingList.profile.id}" id="friends_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="defaultImg pointer" onclick="fnMoveUserHome('${followingList.profile.id}')">
								</c:if>
								<c:if test="${not empty followingList.profile.pSaved}">
									<img title="${followingList.profile.id}" id="friends_img" src="${pageContext.request.contextPath}/${followingList.profile.pPath}/${followingList.profile.pSaved}" class="pointer" onclick="fnMoveUserHome('${followingList.profile.id}')">
								</c:if>	
						</c:forEach>
					</c:if>		
				</div>    
            </div>
         </div>
         
      <div class="follow_container">
         	<div class="select_box">
         		<div id="left_select_box" class="checked">
         			<p id="follower_text" class="checked1">팔로워(${fn:length(followedList)})</p>
         		</div>
         		<div id="right_select_box" class="unchecked">
         			<p id="following_text" class="unchecked1">팔로잉(${fn:length(followingList)})</p>
          		</div>
           	</div>
           	<div class="content_box">
           		<div id="left_follow_box" class="left_follow_box follow_see">
           			<c:if test="${empty followedList}">
             			<div class="each_follow_box no_follow_box">
             				<p class="no_follow">팔로워 없음<p>
             			</div>
             		</c:if>
           			<c:if test="${not empty followedList}">
						<c:forEach items="${followedList}"  var="followedList">
							<div class="each_follow_box" >
								<c:if test="${empty followedList.profile.pSaved}">
									<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="defaultImg pointer" onclick="fnMoveUserHome('${followedList.followingId}')">
								</c:if>
								<c:if test="${not empty followedList.profile.pSaved}">
									<img id="user_img" src="${pageContext.request.contextPath}/${followedList.profile.pPath}/${followedList.profile.pSaved}" onclick="fnMoveUserHome('${followedList.followingId}')">
								</c:if>
								<div class="profile_next_id" onclick="fnMoveUserHome('${followedList.followingId}')">${followedList.followingId}</div>
								<div class="profile_next_content">${followedList.profile.pContent}</div>		
							</div>	
						</c:forEach>
					</c:if>
           		</div>
           		<div id="right_follow_box" class="right_follow_box follow_no">
           			<c:if test="${empty followingList}">
			 		<div class="each_follow_box no_follow_box">
			 			<p class="no_follow">팔로잉하는 사람 없음</p>
			 		</div>
			 	</c:if>
           			<c:if test="${not empty followingList}">
						<c:forEach items="${followingList}"  var="followingList">
							<div class="each_follow_box">
								<c:if test="${empty followingList.profile.pSaved}">
									<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="defaultImg"  onclick="fnMoveUserHome('${followingList.followedId}')">
								</c:if>
								<c:if test="${not empty followingList.profile.pSaved}">
									<img id="user_img" src="${pageContext.request.contextPath}/${followingList.profile.pPath}/${followingList.profile.pSaved}"  onclick="fnMoveUserHome('${followingList.followedId}')">
								</c:if>
								<div class="profile_next_id"  onclick="fnMoveUserHome('${followingList.followedId}')">${followingList.followedId}</div><br>	
								<div class="profile_next_content">${followingList.profile.pContent}</div>
							</div>	
						</c:forEach>
					</c:if>			
           		</div>
           	</div>
  	  </div>
  	  
  	  
  	
	
	</section>
<footer>
	<br><br><br><br><br><br><br>
</footer>
	

</body>
</html>