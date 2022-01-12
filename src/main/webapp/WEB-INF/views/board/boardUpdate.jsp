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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/boardUpdate.css">
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4lnq99nnpg&submodules=geocoder"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
	$(document).ready(function(){
		map();
		fnTextLimit(); // 글자수제한
		fnCheckLogin();
		// 글 수정 날짜
	    let today = new Date();
	    let year = today.getFullYear();
	    let month = today.getMonth() + 1;
	    let day = today.getDate();
	    let hour = today.getHours();
	    let minute = today.getMinutes();
	    let amPm = '';
	    if( hour < 12) { amPm = '오전'; }
	    if( 12<= hour <24 ) { amPm = '오후'; }
	    if (hour   < 10) {hour   = "0"+hour;}
	    if (minute < 10) {minute = "0"+minute;}
	    
	    $('#today').text(month +"월 "+ day+"일 "+ amPm +" "+ hour+":"+minute);
	    
	})
	
	
	 function fnTextLimit(){
	   $('#content').on('keyup', function(){
	   //console.log(  $('#content').val());
		   if( $('#content').val().length > 2000) {
			   Swal.fire({
					icon: 'warning',
					text: '글자수는 2000자까지입니다.',
				})
			   $(this).val( $(this).val().subString() );
		   }
	   });
   }
	function fnSetting(){
		$('.delete_update_form').toggleClass('see no');
	}
	
	function fnDelete(){
	 Swal.fire({
		        text: '게시글을 삭제하시겠습니까?',
		        icon: 'warning',
		        showCancelButton: true,
		        confirmButtonColor: '#d4d4d4',
		        cancelButtonColor: '#d4d4d4',
		        confirmButtonText: '삭제',
		        cancelButtonText: '취소'
		        }).then((result) => {
                    if (result.isConfirmed) {
                    	location.href= '/nearby/board/deleteBoard?bNo='+${board.bNo};
                    }
	      })
	} // fnDelete
	///////////////////////// file update ///////////////////////////////
 	function readURL(input) {
		if (input.files && input.files[0]) {
			let image = ["JPG", "PNG", "JPEG", "GIF", "JFIF"];
			let video = ["MP4", "MPEG", "AVI", "MOV", "M4V"];
			var reader = new FileReader();
			reader.onload = function(e) {
					$('#image').remove();
					$('#video').remove();
				if(  image.includes(input.files[0].name.split('.').pop().toUpperCase() )){
				document.getElementById('previewImg').src = e.target.result;
				
					$("#previewImg").css('display', 'block');
					$("#previewVideo").css('display', 'none');
				}
				 else if (    video.includes(input.files[0].name.split('.').pop().toUpperCase() )        )  {
					 document.getElementById('previewVideo').src = e.target.result;
						$("#previewVideo").css('display', 'block');
						$("#previewImg").css('display', 'none');
				 }
			};
				reader.readAsDataURL(input.files[0]);
			// console.log(input.files[0].name.split('.').pop().toLowerCase());
			$('#modify_file').css('display', 'block');
			$("#previewImg").css('display', 'block');
			$('#img_wrap').css('padding', '0');
			$('#file_label').css('display', 'none');
			$('#upload').css('display', 'none');
		} else {
			document.getElementById('preview').src = "";
		}
	}
	/////////////////////   MAP API     //////////////////////////////////////////////////////////////////////////////////////////////
	function map() {
		$("#map").css('display', 'block');
		
		var map = new naver.maps.Map("map", {
			  center: new naver.maps.LatLng(37.55415109162072, 126.93582461156707),
			  zoom: 15,
			  mapTypeControl: true
			});

		 map.setOptions({       //모든 지도 컨트롤 숨기기
	            scaleControl: false,
	            logoControl: false,
	            mapDataControl: false,
	            zoomControl: false,
	            mapTypeControl: false
	        });
			var infoWindow = new naver.maps.InfoWindow({
			    anchorSkew: true,
			    backgroundColor: "none",
			    Color: "pink",
			    borderColor: "none",
			    borderWidth: "none",
			    anchorSize: new naver.maps.Size(0, 0),
			    display:  "none"
			});
			var marker = new naver.maps.Marker({
			    position: new naver.maps.LatLng(37.55415109162072, 126.93582461156707),
			    map: map
			});

			naver.maps.Event.addListener(map, 'click', function(e) {
			    marker.setPosition(e.coord);
			});
			
			map.setCursor('marker');

	 // 포인트(클릭)
	function searchCoordinateToAddress(latlng) {

		  infoWindow.close();

		  naver.maps.Service.reverseGeocode({
		    coords: latlng,
		    orders: [
		      naver.maps.Service.OrderType.ADDR,
		      naver.maps.Service.OrderType.ROAD_ADDR
		    ].join(',')
		  }, function(status, response) {
		    if (status === naver.maps.Service.Status.ERROR) {
		      if (!latlng) {
		        return alert('다시 입력해주세요');
		      }
		      if (latlng.toString) {
		        return  alert('다시 입력해주세요');
		      }
		      if (latlng.x && latlng.y) {
		        return  alert('다시 입력해주세요'); 
		      }
		      return  alert('다시 입력해주세요'); 
		    }

		    var address = response.v2.address,
		        htmlAddresses = [];
		   
		    var sub = address.jibunAddress.split(' ');
		    var nearbyAddress = sub[0]+" "+sub[1]+" "+sub[2];
		    console.log("nearbyAddress : "+ nearbyAddress)
		    document.getElementById('address').value = nearbyAddress;

		    if (address.jibunAddress !== '') {
		        htmlAddresses.push(nearbyAddress);
		    }

		    infoWindow.setContent([
		      '<div style="padding:10px;min-width:100px;line-height:100%;font-size:10px; display:none">',
		      htmlAddresses.join('<br />'),
		      '</div>'
		    ].join('\n'));
		    
		 
		    $('#address').val(htmlAddresses);
		    infoWindow.open(map, latlng);
		  });
		}
	 
	 //검색했을 때
	function searchAddressToCoordinate(address) {
		  naver.maps.Service.geocode({
		    query: address
		  }, function(status, response) {
		    if (status === naver.maps.Service.Status.ERROR) {
		      if (!address) {
		        return alert('죄송합니다. 다시 입력해주세요');
		      }
		      return  alert('죄송합니다. 다시 입력해주세요');
		    }

		    if (response.v2.meta.totalCount === 0) {
		      return  alert('죄송합니다. 다시 입력해주세요');
		    }
		    
		    var htmlAddresses = [],
		      item = response.v2.addresses[0],
		      point = new naver.maps.Point(item.x, item.y);
		  //  console.log(item);	  // item 객체에 지번, 도로명, 위도, 경도 필드존재함
		 //   document.getElementById('address').value = address.jibunAddress;
		    console.log(item.jibunAddress);
		    var sub = item.jibunAddress.split(' ');
		   
		    var nearbyAddress = sub[0]+" "+sub[1]+" "+sub[2];
		    document.getElementById('address').value = nearbyAddress;
		   
		    console.log("검색 : " +nearbyAddress )
		    
         // 주소 검색 할 때 item.x   item.y

		    if (item.jibunAddress) {
		    	  ////////////////////////////////////회의필요//////////////////////////////////////////
	  		  //  htmlAddresses.push( item.jibunAddress);
	  		    htmlAddresses.push( nearbyAddress);
		    }

		    infoWindow.setContent([
		      '<div style="padding:10px;min-width:50px;line-height:100%;font-size:10px;  display:none;">',
		      htmlAddresses.join('<br />'),
		      '</div>'
		    ].join('\n'));
			
		    map.setCenter(point);
		    infoWindow.open(map, point);
		    
		  });
		}
	
	function initGeocoder() {
		  if (!map.isStyleMapReady) {
		       return;
		  }
		  map.addListener('click', function(e) {
		    searchCoordinateToAddress(e.coord);
		  });
		  $('#address').on('keydown', function(e) {
		    var keyCode = e.which;

		    if (keyCode === 13) { // Enter Key
		      searchAddressToCoordinate($('#address').val());
		    }
		  });
		  $('#submit').on('click', function(e) {
		    e.preventDefault();

		    searchAddressToCoordinate($('#address').val());
		  });
		  searchAddressToCoordinate($('#address').val());
		}
		naver.maps.onJSContentLoaded = initGeocoder;
		naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
	}
	

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
</head>
<body>
	<header class="header">
		<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
	</header>
 <div class="mainBoard_wrap">
	<form id="mainBoardWrap_form" method="post" action="/nearby/board/updateBoard" enctype="multipart/form-data">
	    <div class="boardIntro"> 
	    	<div class="profileImg"  id="p_img">
	    	 <c:if test="${empty loginUser.profile.pSaved}">
				<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" onclick="fnShowBtnBox()" class="pointer defaultImg">
			</c:if>
	    	<c:if test="${not empty loginUser.profile.pSaved}">
		    		<img id="user_img" src="/nearby/${loginUser.profile.pPath}/${loginUser.profile.pSaved}"  class="pointer">
	        </c:if>
	        </div>
	    	<input type="hidden" name="bNo" id="bNo" value="${board.bNo}">
	    	<input type="hidden" name="id" value="${loginUser.id}">
	    	<div class="id_wrap">
    	   		<span id="board_writer">${loginUser.id}</span>
	    	   	<div class="date">
		    	    <span id="today"></span>
		    	    <i class="fas fa-globe-asia" ></i>
		        </div>
		   </div>
	    
		<c:if test="${board.id == loginUser.id}">   
		 <div class="setting_wrap">	
	    	<i class="fas fa-cog setting" onclick="fnSetting()" >
	    	</i>
	    	<ul class="delete_update_form no">
		    		<li class="delete_link" onclick="fnDelete(); return false; ">게시글 삭제</li>
		    </ul>
		   </div> 
	    </c:if>	
	 </div>
  		<!-------------------- 이미지/비디오 삽입할때ㅐ---------------->		  
		      <div class="addressAndImage" >
			    <div class="my_map">
			         <i class="fas fa-map-marker-alt"></i>
			    </div>
			         <div id="map_wrap"></div>
		        <div class="search" >
		            <input type="text" name="location"  id="address"  class="location" value="${board.location}"  >
		            <input id="submit" type="button" value="주소 검색"  />
		        </div>
			<div id="map" ></div>  
		<!------------------ 이미지 및 영상 관련 ----------------------------------------->
		
  		<input type="file" name="file" id="modify_file" value="${board.saved}" onchange="readURL(this);">
		<div id="img_wrap" >
			  <label for="modify_file" id="file_label" class="file_label"> 
			  <i class="fas fa-photo-video" id="upload"></i>
			       사진 / 동영상을 올려주세요   </label>
			      <div class="preview">
			           <img id="previewImg" />
 				       <video id="previewVideo" controls></video>
 				   </div>
  					   <c:set value="${board.saved}" var="video"></c:set>
		  				 <c:if test="${not f:contains(video, 'video')}">
		  						 <div class="imgSize">
		  						   <img alt="${board.origin}" src="/nearby/${board.path}/${board.saved}" id="image" > 
		  						 </div>
		  				  </c:if>
		  				<c:if test ="${f:contains(video, 'video')}">
		  				   <div class="imgSize">
			  				    <video autoplay controls loop muted poster="video"  id="video">
			  						<source src="/nearby/${board.path}/${board.saved}"  type="video/mp4" >
			  					</video>
		  					</div>
		  				</c:if>
		  					<input type="hidden" name="path" value="${board.path}">
		  					<input type="hidden" name="origin"  id="origin" value="${board.origin}">
		  					<input type="hidden" name="saved" value="${board.saved}">
		  		</div>
           			    <div class="content_wrap">
        					<textarea rows="5" cols="5"  name="content" id="content">${board.content}</textarea>
    				    </div>
		 </div>
		  	
		  		<input type="submit" id="updateBtn" value="수정" >
		</form>
	
</div>
	
</body>
</html>