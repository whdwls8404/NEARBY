<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/boardInsert.css" />
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4lnq99nnpg&submodules=geocoder"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>


<script>
  $(document).ready(function(){
		fnFileCheck();
		fnSubmitCheck();
		fnTextLimit(); // content 2000자 막기
		// file 클릭시 map 안보이게 처리
		$("#file").click(function(){
			$("#map").css('display', 'none');
		})
		
		// textarea 크기 보이게 함 
		var txtArea = $(".content_height");
	    if (txtArea) {
	        txtArea.each(function(){
	            $(this).height(this.scrollHeight);
	        });
	    }
	    // 글 삽입 날짜
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
	    
	    fnCheckLogin();
	}); // document 
    
  
   function fnTextLimit(){
	      $('#content').on('keyup', function(event){
	      //console.log(  $('#content').val());
	      
	         if( $('#content').val().length > 2000) {
	         //alert("글자수는 2000자까지입니다.");
	         Swal.fire({
	               text: '글자수는 2000자까지입니다.',
	            })
	         $('#content').val( $('#content').val().substring(0,2000) );
	         return;
	         }
	      });
	   }
  
  
// submit 막기
   function fnSubmitCheck(){
       $('#insertBtn').click(function(event){
          
          // 위치 파일 내용 빈값일때
          if( $('.location').val() == ''  && $('#content').val() == '' && $('#modify_file').val() == '' )  {
             Swal.fire({
                text: '당신의 일상을 적어주세요.'
             })
               event.preventDefault();
          
          // 위치는 빈값 이고 내용이나 파일은 있을 때
          } else if (  $('.location').val() == ''  &&  ( $('#content').val() != '' || $('#modify_file').val() != '' ) )  {
           if(confirm('주변 사람들에게 위치를 알려주세요! ') ){
               event.preventDefault();
                map();
                $("#map").css('display', 'block');
           }
        
        // 위치는 빈값이 아니나 파일이랑 내용이 빈값일 때 
          } else if ( $('.location').val() != ''  &&   $('#content').val() == '' && $('#modify_file').val() == '' )  {
           //  alert("사진이나 일상을 입력해주세요.");
             Swal.fire({
                text: '사진이나 일상을 적어주세요.'
                
             })
             event.preventDefault();
           }  
        })
  }
  
	// 이미지 및 비디오 확장자 및 크기  체크
	function fnFileCheck(){
		
		$("#modify_file").on('change',function(){
			let origin = $(this).val();      // 첨부된 파일명
			let extName = origin.substring(origin.lastIndexOf(".")+1 ).toUpperCase();     // 확장자 대문자로 저장 
			
			// 확장자 정보
			if( $.inArray(extName, ["JPG", "PNG", "JPEG", "GIF","MP4", "MPEG", "AVI", "MOV", "M4V", "JFIF"])  == -1 )  {  // 첨부된 파일이 ["JPG", "PNG", "JPEC", "GIF"] 중 하나가 아니면
			// 	alert('업로드 할 수 없는 확장자입니다.');
			 	Swal.fire({
					text:'업로드 할 수 없는 확장자입니다.'
				})
				$(this).val('');
				return;
		   }
			
			// 파일크기점검
			let maxSize = 1024 * 1024 * 1000;   		   // 최대크기 10MB
			let fileSize = $(this)[0].files[0].size;       // 첨부된 파일 크기
			if ( fileSize > maxSize ){
			//	alert('1GB 이하의 파일만 업로드가 가능합니다.');
				Swal.fire({
					text:'1GB 이하의 파일만 업로드가 가능합니다.'
				})
				$(this).val('');
				return;
			}
		});
	}
	
	// file 클릭하고 변경시 이미지 및 비디오 변경가능하게 하는 함수
	function readURL(input) {
		if (input.files && input.files[0]) {
			let image = ["JPG", "PNG", "JPEG", "GIF","JFIF"];
			let video = ["MP4", "MPEG", "AVI", "MOV", "M4V"];
			var reader = new FileReader();
			reader.onload = function(e) {
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
	
	
   // 맵 메인 함수
	function map() {
		$("#map").css('display', 'block');
		
		var map = new naver.maps.Map("map", {
			  center: new naver.maps.LatLng(37.55415109162072, 126.93582461156707),
			  zoom: 15,
			  mapTypeControl: true
			});

		 map.setOptions({ //모든 지도 컨트롤 숨기기(확대 축소 일반지도 위성지도)
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
	

	 // 클릭 포인트 함수(위도경도)
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
		    
			// null 값은 빈문자 처리함 
		    document.insertBoard_Form.location.value = address.jibunAddress;
		    var sub = address.jibunAddress.split(' ');
		    var nearbyAddress = sub[0]+" "+sub[1]+" "+sub[2];
		    for(var i=0; i<3; i++){
		    	console.log(sub[i]);
		    	var addressSum = "";
		    	
		    	if( typeof sub[i] == "undefined" || sub[i] == null || sub[i] == ""  ){
		    		//console.log("널 : " + i);
		    		sub[i] = " ";
		    		addressSum += sub[i];
		            document.insertBoard_Form.location.value = addressSum;
		    	}  else {
		    		addressSum += sub[i];
		    		document.insertBoard_Form.location.value =  nearbyAddress;
		    	}
		    }
		    document.insertBoard_Form.addr_remove.value ='';
		    
		    if (address.jibunAddress !== '') {
		        htmlAddresses.push(address.jibunAddress);
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
	 
	 //검색했을 때(주소)
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
		    //console.log(item);	  // item 객체에 지번, 도로명, 위도, 경도 필드존재함
		    document.insertBoard_Form.location.value = item.jibunAddress;
		 //   console.log(item.jibunAddress);
		   // var sub = item.jibunAddress.split(' ');
	
		    var sub = item.jibunAddress.split(' ');
		    var nearbyAddress = sub[0]+" "+sub[1]+" "+sub[2];
		    for(var i=0; i<3; i++){
		    	console.log(sub[i]);
		    	var addressSum = "";
		    	// undefined가 나오는 부분은 ""로 처리함
		    	if( typeof sub[i] == "undefined" || sub[i] == null || sub[i] == ""  ){
		    	//	console.log("널 : " + i);
		    		sub[i] = " ";
		    		addressSum += sub[i];
		            document.insertBoard_Form.location.value = addressSum;
		    	}  else {
		    		document.insertBoard_Form.location.value =  nearbyAddress;
		    	}
		    }
		    document.insertBoard_Form.addr_remove.value ='';
		    
         // 주소 검색 할 때 item.x   item.y
		    if (item.jibunAddress) {
	      		htmlAddresses.push( item.jibunAddress);
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
	// 맵의 초기화 (초기화는 학원주소로 설정(노고산동))
	function initGeocoder() {
		  if (!map.isStyleMapReady) {
		    return;
		  }

		  map.addListener('click', function(e) {
		    searchCoordinateToAddress(e.coord);
		   // alert(e.coord.lat() + ', ' + e.coord.lng());  // 클릭하면 위도경도
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

		  searchAddressToCoordinate('노고산동 106-1');
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
<style>
</style>
</head>
<body>
	
	<header class="header">
		<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
	</header>
	
	<div class="insert_wrap">
	<form id="insertBoard_Form" action="/nearby/board/insertBoard" method="post" enctype="multipart/form-data" name="insertBoard_Form">
		<div class="profileImg"  id="p_img">
			<c:if test="${empty loginUser.profile.pSaved}">
				<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png"  class="pointer defaultImg">
			</c:if>
			<c:if test="${not empty loginUser.profile.pSaved}">
	    		<img id="user_img" src="/nearby/${loginUser.profile.pPath}/${loginUser.profile.pSaved}"  class="pointer">
	    	</c:if>
	    </div>
		<div class="id_wrap">
    	   <span id="board_writer">${loginUser.id}</span>
    	   	<div class="date">
	    	    <span id="today"></span>
	    	    <i class="fas fa-globe-asia" ></i>
	        </div>
		 </div>
		 <input type="hidden" name="id" class="id" value="${loginUser.id}" >
			
	     <div class="myMap">
		     <span onclick="map()" id="my_location">내 위치   <i class="fas fa-map-marker-alt" onclick="map()"></i>
		     	<input type="text" name="location" class="location" value=""  readonly="readonly"  >
		     </span>
	     </div>
	     
	     <div id="map_wrap"></div>
	    
	<div id="map" style="width:500px; height:200px;">
        <div class="search" style="">
            <input id="address" type="text" name="addr_remove" placeholder="주소를 입력해주세요(ex. 서울특별시, 마포구, 노고산동)" />
            <input id="submit" type="button" value="주소 검색" />
        </div>
    </div>  
	    
	    <input type="file" name="file" id="modify_file" style="display:none;" onchange="readURL(this);">
		<div id="img_wrap" >
			  <label for="modify_file" id="file_label" class="file_label" style="font-size:20px;"> 
			  <i class="fas fa-photo-video" id="upload" ></i>
			       사진 / 동영상을 올려주세요   </label>
			      <div class="preview">
			           <img id="previewImg" width="320px" />
 				       <video id="previewVideo" controls></video>
 				   </div>
		</div>
		<div class="content_wrap">
			<textarea name="content" id="content" class="content_height"  placeholder="당신의 일상을 공유해주세요"></textarea>
		</div>
		<button id="insertBtn">게시</button>
	</form>
</div>
	<footer id="footer_wrap"></footer>
	
	

	
</body>
</html>