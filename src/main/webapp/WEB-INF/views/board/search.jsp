<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/search.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/outputReplyOnly.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>


<style>
	.replyCount {
		margin-left: 100px;
	}
</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		fnLike();
		fnSendBno();
		fnReply();
		var txtArea = $(".content_height");
	    if (txtArea) {
	        txtArea.each(function(){
	            $(this).height(this.scrollHeight);
	        });
	    }
	    
	    fnCheckLogin();
	});
	//fnMoveUserHome();
	function fnMoveUserHome(id) {
		location.href='/nearby/board/selectUserHome?id='+ id; 
	}
	
	function fnSendBno(){
		
		$.each($('.output_reply_table'), function(i, replyTable) {	
 		let bNo = $(replyTable).parent().prev().val();
 		$.ajax({
 			      url: '/nearby/board/boardBnoList',
			      type: 'get',
			      data: "bNo=" + bNo,
			      dataType: 'json',
 			      success: function(map) {
			    //	  console.log('성공했을때');
			    //	  console.log(map.count);
			    	    if( map.count == 1 ){
			    	    	// 색 있는 하트
			   // 	    	 console.log("색 채우기")
			    	    	 	$("#like"+bNo).addClass('like');
			    	    	    
			    	    	 
			    	    } else if (map.count == 0) {
			    	    	// 빈 하트
			   // 	    	 console.log("색이 없기")
			    	    	$("#like"+bNo).removeClass('like');
			    	    }
			    	  
			      },
			      error: function(xhr) {
			    	  console.log(xhr.responseText);
 			      }
 			   }) // End ajax			
		
 		}); // each
 	} //  fnSendBno()
	
function fnLike(i){
	       let likeBtn = $('.like_btn');
	       let bNo = likeBtn.attr('id');
	          
	          if( $("#"+i).find('i').hasClass('like') == false )  {
	            	$("#"+i).find('i').addClass('like');
		            $.ajax({
		 				url : '/nearby/board/likes',
		 				type: 'post',
						data: "bNo="+i, 
						dataType: 'json',
		 				success: function(board){
		 					console.log(board);
		 					console.log("좋아요 누른 카운트"+ board.likes);
  			  			    $( '#like_count'+bNo ).text(board.likes);
  		  			        location.href = "/nearby/board/boardList";
		 					
		 				},
		 				error : function(xhr, error){
		 					console.log(xhr.status);
		 					console.log(error);
		 				}				
		 			 }); 
		            return
		   }
 			
	 	//	  console.log("likehasClass = " + $("#"+i).children('i').hasClass('like') )
  
  
	    if(  $("#"+i).find('i').hasClass('like') ) {
	    	$("#"+i).find('i').removeClass('like');
	    	
	 		$.ajax({
	  				url : '/nearby/board/likesCancel',
	  				type: 'post',
	  				data: "bNo="+i, 
	 				dataType: 'json',
	  				success: function(board){
	  				   $( '#like_count'+ bNo ).text(board.likes);
	  			   location.href = "/nearby/board/boardList";
	  				},
	  				error : function(xhr, error){
	  					console.log(xhr.status);
	  					console.log(xhr.error)
	  				}				
	  			});  // ajax
	  			return;
	      } // if 
	    }	 
 			
	
 /* ----------------------------------------- fnReply() --------------------------------  */

	
	function fnReply(){
	
			
		$.each($('.output_reply_table'), function(i, replyTable) {
			let bNo = $(replyTable).parent().prev().val();
			var page = 1;
			$.ajax({
				      url: '/nearby/reply/replyList',
				      type: 'get',
				      data: "bNo=" + bNo + "&page=" + page,
				      dataType: 'json',
				      success: function(map) {
							fnPrintReplyList(map);
				      },
				      error: function(xhr) {
				         console.log(xhr.responseText);
				      }
				   }) // End ajax			
		
			function fnPrintReplyList(map){
				$(replyTable).empty();
	
				 var p = map.pageUtils;
				 let id = '${loginUser.id}';
			
				if (p.totalRecord == 0) {
				    $('<tr>')
				    .append( $('<td colspan="5" class="reply_none">').text('첫 번째 댓글의 주인공이 되어보세요!') )
				    .appendTo( replyTable );
				 } else {
				    
					$.each(map.replyList, function(i, reply){
					    if ( reply.profile.pSaved != null ) { 
							let pSaved = reply.profile.pSaved;
							let pPath = reply.profile.pPath;
							$(replyTable).append( $('<tr>').html( $('<td rowspan="2" class="reply_user_image_area"><img class="reply_user_img" src="/nearby/'+pPath+'/'+pSaved+'"></td>') ) );
					      } else if ( reply.profile.pPath == null ) { 
							$(replyTable).append( $('<tr>').html( $('<td rowspan="2" class="reply_user_image_area"><img class="reply_user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png"></td>') ) );
					      } // End if 프사 부분 
					
				         let strContent = reply.rContent;
				         let reply_content = ''; 
						
				         if (strContent.length > 30) {
							reply_content = strContent.substring(0, 30) + '...';
						} else {
							reply_content = strContent;
						}
						
						$('<tr class="reply_show">')
						.append( $('<td class="reply_user_name_area">').html( $('<a id="link_'+reply.rNo+'" class="user_page_link">'+reply.id+'</a>') ) )
						.append( $('<td class="like_icon_area">').html( $('<td colspan="4" class="pointer re_content_area" onclick="fnShowViewPage('+reply.bNo+')">'+reply_content+'</td><td></td>') ) )
						.appendTo( replyTable );
						
						// 유저 이름당 링크 만들기
						if (reply.id != id) {
							$('.user_page_link[id=link_'+reply.rNo+']').attr('href','/nearby/board/selectUserHome?id='+reply.id);
						} else if(reply.id == id) {
							$('.user_page_link[id=link_'+reply.rNo+']').attr('href','/nearby/board/myHome');
						}
						
						
					}) // End inner each
					
					// 게시글당 댓글 수 삽입부
					$(".reply_count_per_board[id=\""+bNo+"\"]").text(map.total);
					
					
					// 게시글당 댓글 수에 따른 아이콘 색상변경부
			 		if (map.total > 0 ) {
						$('.countIcon[id=icon_'+bNo+']').addClass('like').removeClass('unlike');
					} else if (map.total < 0 ) {
						$('.countIcon[id=icon_'+bNo+']').addClass('unlike').removeClass('like');
					}
			 		
	
					
				 } // End if 
	
			} // End fnPrintReplyList
		}); // End outer each
	} // End fnReply 

	/* ----------------------------------------- fnCheckLogin() --------------------------------  */
 	function fnCheckLogin(){
		let loginInfo = '${loginUser.id}';
		if (loginInfo == '') {
			
		 Swal.fire({
				text: '세션이 만료되었습니다. 로그인 화면으로 이동하시겠습니까?',
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
  .board_icon{
  color: gray;
  cursor: pointer;
  }
   .like {
   		color: #fe4662; cursor: pointer;
   }
  .header {
  	margin-top: 130px;
  }
 
</style>
</head>
<body>
	 <c:if test="${loginUser.id != 'admin'}"> 
		<header class="header">
			<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
		</header>
	</c:if>
	
	 <c:if test="${loginUser.id == 'admin'}"> 
			<jsp:include page="/WEB-INF/views/layout/adminHeader.jsp" flush="true" />
	</c:if>	
	
	<div class="search_result_text">
		<c:if test="${empty list[0] and empty profileList}">
			<div class="search_result_wrap"><h3>" ${query} " </h3> 에 대한 검색 결과가 없습니다.</div>
		</c:if>
		<c:if test="${not empty list[0] or not empty profileList}">
			<div class="search_result_wrap"><h3>" ${query} " </h3> 에 대한 검색 결과</div>
		</c:if>
	</div>

	<div class="board_container">
	
	 <c:if test="${not empty profileList}">
            <div class="profile_list_container">
                <c:forEach items="${profileList}" var="profileList">
                    <c:if test="${not empty profileList.pSaved}" >
                        <div class="profile_each_container">
                            <img id="user_img" src="/nearby/${profileList.pPath}/${profileList.pSaved}" onclick="fnMoveUserHome('${profileList.id}')" class="pointer">
                            <p>${profileList.id}</p>
                        </div>

                    </c:if>
                    <c:if test="${empty profileList.pSaved}">
                        <div class="profile_each_container">
                            <img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" onclick="fnMoveUserHome('${profileList.id}')" class="pointer defaultImg">
                            <p>${profileList.id}</p>
                        </div>

                    </c:if>
                </c:forEach>
            </div>
   	  </c:if>
	 	 
	 
	 <c:if test="${not empty list[0]}"> 
	  	<c:forEach items="${list}" var="board">

	    <%-- 	보드 값 확인 용 ${board} --%>
		<div id="mainBoardWrap" >
		    <div class="boardIntro"> 
		    	<div class="profileImg"  id="p_img">
		    <c:if test="${empty board.profile.pSaved}">
				<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" onclick="fnMoveUserHome('${board.profile.id}')"  class="pointer defaultImg">
			</c:if>
		    <c:if test="${board.profile.id == board.id and not empty board.profile.pSaved}" >
		    		<img id="user_img" src="/nearby/${board.profile.pPath}/${board.profile.pSaved}"  class="pointer" onclick="fnMoveUserHome('${board.profile.id}')" >
		    </c:if>
		    	</div>
		    	<input type="hidden" id="bNo" value="${board.bNo}">
		    	<input type="hidden" id="origin" value="${board.origin}">
		    	<input type="hidden" id="saved" value="${board.saved}">
		    	<input type="hidden" id="location" value="${board.location}">
		    	<div class="id">
		    	   <a href="/nearby/board/selectUserHome?id=${board.id}" id="board_writer">${board.id}</a>
		    	</div>
		 </div>
  		<!--------------------- 내용만 삽입할 때 ------------------------------->
 			 <c:if test="${ null == board.origin }">
	  			<div class="AddrAndContent"  onclick="location.href='/nearby/board/selectBoard?bNo=${board.bNo}';">
	  				  <div class="addrAndMap">
						       		  <i class="fas board_icon fa-map-marker-alt" style="color:#fe4662; font-size:15px; width:30px"></i>
						              <span class="address"> ${board.location} </span>
				      </div>
		  		      <div class="content onlyContent">
			  		   	 <div class="content textarea">
		       	            <pre style='white-space:pre-wrap; word_wrap:break-word; word-break: break-all; width:505px;'>${board.content}</pre>
		       	    	 </div>
			       	  </div>
	  		    </div>
		  </c:if>
  		<!-------------------- 이미지/비디오 삽입할 때---------------->		  
		 <c:if test="${board.saved ne null}">	  
		      <div class="addressAndImage"  onclick="location.href='/nearby/board/selectBoard?bNo=${board.bNo}';">
			      <div class="addrAndMap">
			       		  <i class="fas board_icon fa-map-marker-alt" style="color:#fe4662; font-size:15px; width:30px"></i>
			              <span class="address"> ${board.location} </span>
			      </div>
		    	  <!------------------ 이미지 및 영상 관련 ----------------------------------------->
  					   <c:set value="${board.saved}" var="video"></c:set>
		  				 <c:if test="${not f:contains(video, 'video')}">
		  						 <div class="imgSize">  <img alt="${board.origin}" src="/nearby/${board.path}/${board.saved}" id="image">  </div>
		  				  </c:if>
		  				
		  				<c:if test ="${f:contains(video, 'video')}">
		  				   <div class="imgSize">
			  				    <video autoplay controls loop muted poster="video"  id="video">
			  						<source src="/nearby/${board.path}/${board.saved}"  type="video/mp4" >
			  					</video>
		  					</div>
		  				</c:if>
		  					<input type="hidden" name="path" value="${board.path}">
		  					    <div class="content textarea">
		       		            	<pre style='white-space:pre-wrap; word_wrap:break-word; word-break: break-all; width:484px;'>${board.content}</pre>
		       		   			</div>
		  		</div>
		  		
		  </c:if>		
		  
		  		<!--------------  댓글 + 좋아요 수 ----------------------->
		  		<div class="likesAndReplyCount">
			  		<div class="countIcon likesCount"> 
			  			<span class="like_btn" id="${board.bNo}"  data-bno="${board.bNo}" onclick="fnLike(${board.bNo})" style="width: 30px;">
	  			 	    	<i class="fas board_icon fa-thumbs-up" id="like${board.bNo}" > </i>
		  					<span class="like_count"  id="like_count${board.bNo}">
		  						${board.likes}
		  					</span> 
  					    </span>
			  		</div>
			  			<div class="countIcon replyCount">
			  				<i class="fas board_icon fa-comments countIcon replyCount"  id="icon_${board.bNo}" onclick="location.href='/nearby/board/selectBoard?bNo=${board.bNo}';"></i>
			  				<span class="reply_count_per_board" id="${board.bNo}">0</span>
				  		</div>
		  		</div>
		  			<!--  댓글 보이기  -->
	  			<div class="input_reply_area">	  			
			  		<div class="reply_wrap">
			  			<!-- 댓글 뿌리기 -->
			  			<div class="output_reply_area">
				  			<form>
				  				<input type="hidden" name="bNo" value="${board.bNo}">
					  			<table>
					  				<tbody class="output_reply_table"></tbody>
					  			</table>
				  			</form>
			  			</div>
			  		</div>
	  			</div> <!-- End class input_reply_area DIV tag -->
		</div>
	  </c:forEach>
	 </c:if> 
	
</div>	
</body>
</html>