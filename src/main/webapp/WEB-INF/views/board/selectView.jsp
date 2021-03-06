<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/boardFindView.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/selectViewReply.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<style>
   .board_icon{
       margin-left: 25px;
	   color: gray;
	   width: 35px;
	   line-height: 32px;
	   cursor: pointer;
    }
   .like   { color: #fe4662; cursor: pointer;  }
   .unlike { color: gray; cursor: pointer;     }
   	.pointer {
   		cursor: pointer;
   	} 
   	.textarea {
		border: none;
		margin: 0 -10px;
		background-color: rgba(255, 250, 250, 0.8);
		width: 500px;
		padding: 10px 6px 20px 10px;
	}


  /* sweet alert */
  .swal2-popup { padding: 0.5em; }
  .swal2-icon {
  	width: 4.5em;
  	height: 4.5em;
  }
   .swal2-styled { margin:  0.5em; }
   .swal2-styled.swal2-confirm { width: 100px; background-color: #d4d4d4;  }
   .swal2-styled.swal2-cancel {width: 100px;}
   .swal2-icon.swal2-warning { color: pink; border-color: pink;}
   .swal2-header{ height: 100px; }


</style>
<script>
	$(document).ready(function(){
		fnSendBno();     // ????????? ????????? ????????? ????????? ??? ?????? 
		fnReplyList();	 // ????????? ?????? ?????????
		fnInsertReply(); // ?????? ??????
		fnChangePage();  // ?????????
		fnShowUpdateBtn();
		fnUpdateReply(); // ?????? ??????
		fnDeleteReply(); // ?????? ??????
	    fnCheckLogin();
		
	    var txtArea = $(".content_height");
	    if (txtArea) {
	        txtArea.each(function(){
	            $(this).height(this.scrollHeight);
	        });
	    }
	    
	})

	function fnSetting(){
		$('.delete_update_form').toggleClass('b_see b_no');
		$('.delete_form').toggleClass('b_see b_no');
	}
	
	function fnDelete(){
		 Swal.fire({
				text: '???????????? ?????????????????????????',
		        icon: 'warning',
		        showCancelButton: true,
		        closeOnClickOutside: false,
		        confirmButtonColor: '#D4D4D4',  // confirm
		        cancelButtonColor: '#D4D4D4',   // cancel
		        confirmButtonText: '??????',
		        cancelButtonText: '??????'	
		     }).then((result) => {
	             if (result.isConfirmed) {
	            		location.href= '/nearby/board/deleteBoard?bNo='+${board.bNo};
	             }
		     })    
	   }
	
	function fnAdminDelete(i){
		if( confirm('????????? ?????? '+i+'??? ?????????????????????????') ){
 			$.ajax({
 				url : '/nearby/admin/adminBoardDelete',
 				type: "get",
 				data : "bNo="+i,
 				dataType: 'json',
 				contentType:'application/json',
 				success: function(map){
 					 if(map.result.result > 0){
 						location.href= "/nearby/board/boardList";
 					 } else {
 					 }
 					}, 
 				error: function(){
 				//	alert("ajax???????????????")
 				}
 			})
 		}
	}
	
	function fnUpdate(){
	/* 	if(confirm('???????????? ?????????????????????????') )
			location.href= '/nearby/board/updateBoardPage?bNo='+${board.bNo}; */
		 Swal.fire({
			text: '???????????? ?????????????????????????',
	        icon: 'warning',
	        showCancelButton: true,
	        closeOnClickOutside: false,
	        confirmButtonColor: '#D4D4D4',  // confirm
	        cancelButtonColor: '#D4D4D4',   // cancel
	        confirmButtonText: '??????',
	        cancelButtonText: '??????'	
	     }).then((result) => {
             if (result.isConfirmed) {
            	 location.href= '/nearby/board/updateBoardPage?bNo='+${board.bNo}; 
             }
	     })    
			
			
	}
	
    function fnSendBno(){
		
		$.each($('.output_reply_table'), function(i, replyTable) {	
 		let bNo = '${board.bNo}';
 		$.ajax({
 			      url: '/nearby/board/boardBnoList',
			      type: 'get',
			      data: "bNo=" + bNo,
			      dataType: 'json',
 			      success: function(map) {
			    	    if( map.count == 1 ){
			    	    	 console.log("??? ?????????")
			    	    	 	$("#like"+bNo).addClass('like');
			    	    } else if (map.count == 0) {
			    	    	$("#like"+bNo).removeClass('like');
			    	    }
			      },
			      error: function() {
 			      }
 			   }) // End ajax			
		
 		}); // each
 	} //  fnSendBno()
	
	
	
	function fnLike(i){
	       let likeBtn = $('.like_btn');
	       let bNo = '${board.bNo}';
	          
	          if( $("#"+i).find('i').hasClass('like') == false )  {
	            	$("#"+i).find('i').addClass('like');
		            $.ajax({
		 				url : '/nearby/board/likes',
		 				type: 'post',
						data: "bNo="+i, 
						dataType: 'json',
		 				success: function(board){
  			  			   $( '#like_count'+bNo ).text(board.likes);
  			  			   location.href="/nearby/board/selectBoard?bNo="+bNo;
		 					
		 				},
		 				error : function(xhr, error){
		 					console.log(xhr.status);
		 					console.log(error);
		 				}				
		 			 }); 
		            return
		   }
 			
  
	    if(  $("#"+i).find('i').hasClass('like') ) {
	    	$("#"+i).find('i').removeClass('like');
	    	
	 		$.ajax({
	  				url : '/nearby/board/likesCancel',
	  				type: 'post',
	  				data: "bNo="+i, 
	 				dataType: 'json',
	  				success: function(board){
	  			//	  console.log("????????? ?????? ?????????" + board.likes);
	  				   $( '#like_count'+ bNo ).text(board.likes);
	  				 location.href="/nearby/board/selectBoard?bNo="+bNo;
	  				   
	  				},
	  				error : function(xhr, error){
	  //					console.log(xhr.error)
	  				}				
	  			});  // ajax
	  			return;
	      } // if 
	    }	 
 			
 	

	
	/* ----------------------------------------- fnReplyList() --------------------------------  */
	var page = 1; // ????????? ????????? 1page?????????. 1??? ?????????
	function fnReplyList(){
	   $.ajax({
	      url: '/nearby/reply/replyList',
	      type: 'get',
	      data: "bNo=" + '${board.bNo}' + "&page=" + page,
	      dataType: 'json',
	      success: function(map) {
	         fnReplyTotalCount(map);
	         if (map.total != 0 ) {
		         fnPrintPaging(map.pageUtils);
	         } else if (map.total == 0) {
	        	 $('#paging').empty();
	         }
	         fnPrintReplyList(map);
	      },
	      error: function(xhr) {
	         console.log(xhr.responseText);
	      }
	   }) // End ajax
	} // End fnReplyList

	function fnReplyTotalCount(map) {
	         $('#reply_count_per_board').text(map.total);
	         if (map.total > 0 ) {
	            $('.replyCount').addClass('like').removeClass('unlike');
	         } else if (map.total == 0) {
	            $('.replyCount').addClass('unlike').removeClass('like');
	         }
	}

	   /* ----------------------------------------- fnPrintReplyList() --------------------------------  */

		function fnPrintReplyList(map){
			 $('.output_reply_table').empty();
			 
			 var p = map.pageUtils;
			 let id = '${loginUser.id}';
			 
			 if (p.totalRecord == 0) {
			    $('<tr>')
			    .append( $('<td colspan="5" class="reply_none">').text('??? ?????? ????????? ???????????? ???????????????!') )
			    .appendTo( '.output_reply_table' );
			 } else {
			    
			    $.each(map.replyList, function(i, reply){
			         if ( reply.profile.pSaved != null ) { // ?????? ???????????? ????????? ????????? ?????? ??? ????????? ????????? ????????????
			        
							let pSaved = reply.profile.pSaved;
							let pPath = reply.profile.pPath;
			        
							$('.output_reply_table').append( $('<tr>').html( $('<td rowspan="2" class="reply_user_image_area"><img class="reply_user_img" src="/nearby/'+pPath+'/'+pSaved+'"></td>') ) );
			           } else if(reply.profile.pPath == null) { // ?????? ???????????? ????????? ????????? ?????? ??? ????????? ????????? ????????????.
							$('.output_reply_table').append( $('<tr>').html( $('<td rowspan="2" class="reply_user_image_area"><img class="reply_user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png"></td>') ) );
			           } // End if ?????? ?????? 
					
					$('<tr class="icon_row">')
					.append( $('<td class="reply_user_name_area">').html( $('<a id="link_'+reply.rNo+'" class="user_page_link">'+reply.id+'</a>') ) )
					.append( $('<td class="like_icon_area">') )
					.append( $('<td class="btn_area">').html( $('<input type="button" class="show_reply_btn pointer disapear reply_btns" data-upno="'+reply.rNo+'" value="??????" data-login="'+id+'" data-writer="'+reply.id+'"></td>') ) )
					.append( $('<td class="btn_area">').html( $('<input type="button" class="delete_reply_btn pointer disapear reply_btns" data-no="'+ reply.rNo +'" value="??????" data-login="'+id+'" data-writer="'+reply.id+'" ></td>') ) )
					.appendTo( '.output_reply_table' );
					$('.output_reply_table').append( $('<tr class="input_row">').html( $('<td colspan="4"><input type="text" class="reply_content" id="updateContent" value="'+reply.rContent+'" readonly></td><td class="btn_area"><input type="button" class="update_reply_btn pointer reply_btns disapear reply_insert_btns" data-updateno="'+reply.rNo+'" value="??????"></td>') ) );

					
					// ?????? ????????? href ?????? ?????????
					if (reply.id != id) {
						$('.user_page_link[id=link_'+reply.rNo+']').attr('href','/nearby/board/selectUserHome?id='+reply.id);
					} else if(reply.id == id) {
						$('.user_page_link[id=link_'+reply.rNo+']').attr('href','/nearby/board/myHome');
					}
					
			    }) // End each
			    
				$.each( $('.icon_row') , function(i, row) {
					
					let update_btn = $($(this).find('.reply_btns')[0]);
					let delete_btn = $($(this).find('.reply_btns')[1]);
					if (update_btn.data('login') == update_btn.data('writer')){			
						update_btn.removeClass('disapear');
						delete_btn.removeClass('disapear');
					}
					
				});
			    
			 } // End if 
		} // End fnPrintReplyList
   

		   
		/* ----------------------------------------- fnInsertReply() ----------------------------------------- */
		function fnInsertReply(){
		   $('#insert_reply_btn').on('click', function(){
			   if ( $('#rContent').val().length > 40) {
						Swal.fire({
							icon: 'warning',
							text: '????????? ???????????? 40??? ????????? ??????????????????'
						});
				   return;
			   } 
			   
			   if( $('#rContent').val().trim() == '' ) {
						Swal.fire({
							icon: 'warning',
							text: '????????? ????????? ????????????.'
						});
				   $('#rContent').focus();
				   return;
			   }
			   
		      let reply = JSON.stringify({
		         bNo: '${board.bNo}',
		         id: '${loginUser.id}',
		         rContent: $('#rContent').val(),
		         depth: 0,
		         groupNo: 0,
		         groupOrd: 0
		      }); 
		      $.ajax({
		         url: '/nearby/reply/insertReply',
		         type: 'post',
		         data: reply,
		         contentType: 'application/json',
		         dataType: 'json',
		         success: function(map) {
		               fnReplyList();
		               if (map.errorMsg != null) {
			   				Swal.fire({
								icon: 'warning',
								text: map.errorMsg
							});
		               } else {
			               $('#rContent').val(''); // ????????? ?????? ????????? ??? ??????
		               }

		         },
		         error: function(xhr) {
		            console.log(xhr.responseText);
		         }
		      }) // End ajax
		   }) // End click event
		}  // End fnInsertReply

/* ----------------------------------------- fnDeleteReply() ----------------------------------------- */

	function fnDeleteReply(){
		$('body').on('click', '.delete_reply_btn', function(){
			let deleteNo = $(this).data('no');
			//console.log(deleteNo);
			alert(deleteNo);
				$.ajax({
					url: '/nearby/reply/deleteReply',
					type: 'get',
					data: 'rNo=' + deleteNo,
					dataType: 'json',
					success: function(map){
						fnReplyList();
					},
					error: function(xhr){
					}
				})// end ajax
		})
	} // end fnDeleteMember
/* ----------------------------------------- fnShowUpdateBtn() ----------------------------------------- */

	function fnShowUpdateBtn(){
		$('body').on('click', '.show_reply_btn', function(){
			let upNo = $(this).data('upno');
			let content = $(this).parent().parent().next().children().find('input');
			let completeBtn = $(this).parent().parent().next().children().next().find('input');
			
			content.removeAttr('readonly');
			completeBtn.toggleClass('disapear');
		}) // fnShowUpdateBtn
	}
	/* ----------------------------------------- fnDeleteReply() ----------------------------------------- */

	function fnDeleteReply(){
		$('body').on('click', '.delete_reply_btn', function(){
			let deleteNo = $(this).data('no');
			//console.log(deleteNo);
				$.ajax({
					url: '/nearby/reply/deleteReply',
					type: 'get',
					data: 'rNo=' + deleteNo,
					dataType: 'json',
					success: function(map){
						fnReplyList();
					},
					error: function(xhr){
					}
				})// end ajax
		})
	} // end fnDeleteMember
/* ----------------------------------------- fnShowUpdateBtn() ----------------------------------------- */

	function fnShowUpdateBtn(){
		$('body').on('click', '.show_reply_btn', function(){
			let upNo = $(this).data('upno');
			let content = $(this).parent().parent().next().children().find('input');
			let completeBtn = $(this).parent().parent().next().children().next().find('input');
			
			content.removeAttr('readonly');
			completeBtn.toggleClass('disapear');
		}) // fnShowUpdateBtn
	}

/* ----------------------------------------- fnUpdateReply() ----------------------------------------- */
		
	function fnUpdateReply(){
		$('body').on('click', '.update_reply_btn', function(){
			let updateNo = $(this).data('updateno');
			let updateContent = $(this).parent().prev().find('input').val();
			if ( updateContent.trim() == '') {
				Swal.fire({
					icon: 'warning',
					text: '????????? ????????? ????????????'
				});
				return;
			} else if (updateContent.length > 40) {
				Swal.fire({
					icon: 'warning',
					text: '????????? ???????????? 40??? ????????? ??????????????????'
				});
				return;
			}
	          let reply = JSON.stringify({
	              rNo : updateNo,
	              rContent: updateContent
	           });
			 	$.ajax({
					url: '/nearby/reply/updateReply',
					type: 'post',
					contentType: 'application/json',
					data: reply,
					dataType: 'json',
					success: function(map){
						fnReplyList();
			               if (map.errorMsg != null) {
				   				Swal.fire({
									icon: 'warning',
									text: map.errorMsg
								});
			               }
					},
					error: function(){
						alert('?????? ??????');
					}
				})// end ajax 
		})
	} // end fnUpdateReply


	/* ----------------------------------------- fnPrintPaging() ----------------------------------------- */
	// ????????? ?????? ??????
		function fnPrintPaging(p) {
			$('#paging').empty();
		   // 1???????????? ??????
			if (page == 1) {
				$('<div class="disable_link">PREV</div>').appendTo('#paging');
			} else {
				$('<div class="enable_link" data-page="1">PREV</div>').appendTo('#paging'); 
			}
			// ?????? ???????????? ??????
			if (page <= p.pagePerBlock) {
				$('<div class="disable_link">&nbsp;&nbsp;&nbsp;&lt;</div>').appendTo('#paging');
			} else {
				$('<div class="enable_link" data-page="'+(p.beginPage-1)+'">&nbsp;&nbsp;&nbsp;&lt;</div>').appendTo('#paging');
			}
			// ????????? ??????
			for (let i = p.beginPage; i <= p.endPage; i++) {
				if (i == page) {
				   $('<div class="disable_link now_page">'+i+'</div>').appendTo('#paging');
				} else {
				   $('<div class="enable_link" data-page="'+i+'">'+i+'</div>').appendTo('#paging');
				}
			}
			// ?????????????????? ??????
			if (p.endPage == p.totalPage) {
				$('<div class="disable_link">&gt;</div>').appendTo('#paging');
			} else {
				$('<div class="enable_link" data-page="'+(p.endPage+1)+'">&gt;</div>').appendTo('#paging');
			}
			
			// ????????? ???????????? ??????
			if (page == p.totalPage) {
				$('<div class="disable_link">NEXT</div>').appendTo('#paging');
			} else {
				$('<div class="enable_link" data-page="'+p.totalPage+'">NEXT</div>').appendTo('#paging');
			}
		} // End fnPrintPaging

	/* ----------------------------------------- fnChangePage() ----------------------------------------- */
	// ????????? ?????? ?????? ??????
		function fnChangePage() {
			$('body').on('click', '.enable_link', function(){
				page = $(this).data('page');
				fnReplyList();
			}) // body click event
		} // End fnChangePage   
		
		/* ----------------------------------------- fnCheckLogin() --------------------------------  */
	 	function fnCheckLogin(){
			let loginInfo = '${loginUser.id}';
			if (loginInfo == '') {
				
			 Swal.fire({
					text: '????????? ?????????????????????. ????????? ???????????? ?????????????????????????',
			        icon: 'warning',
			        showCancelButton: true,
			        confirmButtonColor: '#D4D4D4',  // confirm
			        cancelButtonColor: '#D4D4D4',   // cancel
			        confirmButtonText: '??????',
			        cancelButtonText: '??????'	
			     }).then((result) => {
					if(result.isConfirmed) { // confirm??? false?????? return
						location.href='/nearby/';
					}
			     })
			}
		}	 	 		
	
</script>
</head>
<body>
	 <c:if test="${loginUser.id != 'admin'}"> 
      <header class="header">
         <jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
      </header>
   </c:if>
   
    <c:if test="${loginUser.id == 'admin'}"> 
      <header class="header">
         <jsp:include page="/WEB-INF/views/layout/adminHeader.jsp" flush="true" />
      </header>
    </c:if>   
	
	<div class="mainBoardWrap" >
	    <div class="boardIntro"> 
	    	<div class="profileImg" id="p_img">
	    	  <c:if test="${empty board.profile.pSaved}">
				<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="pointer defaultImg">
			</c:if>
		    <c:if test="${board.profile.id == board.id and not empty board.profile.pSaved}" >
		    		<img id="user_img" src="/nearby/${board.profile.pPath}/${board.profile.pSaved}"  class="pointer">
		    </c:if>
	    	</div>
	    	<input type="hidden" id="bNo" value="${board.bNo}">
	    	<div class="idAndDate">	
		    	<c:if test="${loginUser.id != board.id}">
					<a href="/nearby/board/selectUserHome?id=${board.id}">${board.id}</a>                
				</c:if>
				<c:if test="${loginUser.id == board.id}">
					<a href="/nearby/board/myHome">${board.id}</a>                
				</c:if>
	    		<div class="date">
			    	    <fmt:formatDate value="${board.created}" pattern="MM??? dd???  a hh:mm" />
			    	    <i class="fas fa-globe-asia" ></i>
			    </div>
	    	</div> 
	    
		<c:if test="${board.id == loginUser.id}">   
		 <div class="setting_wrap">	
	    	<i class="fas fa-ellipsis-h setting" onclick="fnSetting()"></i>
	    	<ul class="delete_update_form b_no">
    			<li class="update_link" onclick="fnUpdate(); return false;">????????? ??????</li>
	    		<li class="delete_link" onclick="fnDelete(); return false; ">????????? ??????</li>
		    </ul>
		   </div> 
	    </c:if>	
	    
    	<!-- ?????????????????? ????????????  ????????? ?????? -->
   		<c:if test="${ 'admin' == loginUser.id}">   
   		 <div class="setting_wrap">	
			<i class="fas fa-ellipsis-h setting" onclick="fnSetting()"></i>
			 <ul class="delete_form b_no">
			   		<li class="delete_link" onclick="fnAdminDelete(${board.bNo}); return false;">???????????????</li>
	  		 </ul>
  		</div>
	   </c:if>
	    	
	 </div>
		<!--------------------- ????????? ????????? ??? ------------------------------->
 			 <c:if test="${ null == board.origin }">
	  			<div class="AddrAndContent"  onclick="location.href='/nearby/board/selectBoard?bNo=${board.bNo}';">
	  				  <div class="addrAndMap">
						       		  <i class="fas fa-map-marker-alt" style="color:#fe4662; font-size:15px; width:30px"></i>
						              <span class="address"> ${board.location} </span>
				      </div>
		       		   <div class="content">
		       		         <pre style='white-space:pre-wrap; word_wrap:break-word; word-break: break-all; width:505px;'>${board.content}</pre>
		       		   </div>
	  		    </div>
		  </c:if>
  		<!-------------------- ?????????/????????? ???????????? ---------------->		  
		 <c:if test="${board.saved ne null}">	  
		      <div class="addressAndImage"  onclick="location.href='/nearby/board/selectBoard?bNo=${board.bNo}';">
			      <div class="addrAndMap">
			       		  <i class="fas fa-map-marker-alt" style="color:#fe4662; font-size:15px; width:30px"></i>
			              <span class="address"> ${board.location} </span>
			      </div>
		    	  <!------------------ ????????? ??? ?????? ?????? ----------------------------------------->
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
		  		      <div class="content">
		       		         <pre style='white-space:pre-wrap; word_wrap:break-word; word-break: break-all; width:499px;'>${board.content}</pre>
		       		   </div>
		  		</div>
		  </c:if>		
	  		<!--------------  ?????? + ????????? ??? ----------------------->
	  		<div class="likesAndReplyCount">
		  		<div class="countIcon likesCount"> 
		  			<span class="like_btn" id="${board.bNo}"  data-bno="${board.bNo}" onclick="fnLike(${board.bNo})">
  			 	    	<i class="fas board_icon fa-thumbs-up" id="like${board.bNo}" > </i>
	  					<span class="like_count"  id="like_count${board.bNo}">${board.likes}</span> 
  					</span>
	            </div>
			  		<div class="countIcon reply_count_box">
			  			<i class="fas fa-comments countIcon replyCount"></i>
		  				<span id="reply_count_per_board">0</span>
			  		</div>
		  		</div>
	 
<!--  ?????? ?????????  -->
	<div class="input_reply_area">
		<!-- ?????? ?????? -->
		<table id="input_reply_table">
			<tr>
				<td>
					<c:if test="${empty loginUser.profile.pSaved}">
						<img class="reply_user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="pointer defaultImg">
					</c:if>
					<c:if test="${not empty loginUser.profile.pSaved}">
						<img class="reply_user_img" src="/nearby/${loginUser.profile.pPath}/${loginUser.profile.pSaved}" class="pointer">
					</c:if>
				</td>
				<td>
					<input type="text" name="rContent" id="rContent" placeholder="????????? ???????????????">
				</td>
				<td id="insert_btn_area">
					<input type="button" id="insert_reply_btn" class="pointer reply_insert_btns" value="??????">
				</td>
			</tr>
		</table>
	</div>
		<div class="reply_wrap">
		<!-- ?????? ????????? -->
  			<div class="output_reply_area">
	  			<table>
	  				<tbody class="output_reply_table"></tbody>
					<tfoot>
						<tr>
							<td colspan="5"><div id="paging"></div></td>
						</tr>
					</tfoot>
	  			</table>
  			</div>
  		</div>
	</div>
</body>
</html>