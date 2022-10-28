<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Base64" %>
<%@ page import = "java.io.IOException" %>
<%@ page import = "java.io.File" %>
<%@ page import = "java.io.ByteArrayInputStream" %>
<%@ page import = "java.awt.image.BufferedImage" %>
<%@ page import = "javax.imageio.ImageIO" %>
    <!DOCTYPE html>
    <html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
        
     <!-- 카메라 관련 css -->       
     <style type="text/css">
        #start-camera {
            margin-top: 50px;
            border: 0px;
        }
        
        #video {
            display: none;
            margin: 50px auto 0 auto;
        }
        
        #click-photo {
            display: none;
            width: 10vw;
            margin: 0 auto;
            text-align: center;
            background-color: #fff;
			cursor: pointer;
            height: 3vw;
        }
        
        #re_click-photo {
            display: none;
        }
        
        #dataurl-container {
            display: block;
    		
        }
        
        #canvas {
            display: block;
            margin: 0 auto 20px auto;
        }
        
        #dataurl-header {
            text-align: center;
            font-size: 15px;
        }
        
        #dataurl {
            display: block;
            height: 100px;
            width: 320px;
            margin: 10px auto;
            resize: none;
            outline: none;
            border: 1px solid #111111;
            padding: 5px;
            font-size: 13px;
            box-sizing: border-box;
        }
        #Confirmation{
        	color: #fff;
        }
        #cameraResult{
        	color: #000;
        	background-color: #fff;
        	border: 1px solid black;
        	border-radius: 0px;
        }
    </style>  
      
    <title>지공모 방문게시판..</title>
    </head>
    <a href="https://dept.daelim.ac.kr/com/index.do"><img class="daelim" src="img/daelim.png" ></a><br><br>
    <link rel="stylesheet" href="index.css">
    
    <!-- 헤더 영역 시작 -->
    <body>
    <div class="head">
        <img class="rogoimg" src="img/rogoimg.png" onclick="location.href='index.jsp'">
            <div class="headerbtn">
            <header>
            <button class="btn1" id="btn_main" onclick="location.href='index.jsp'">홈 </button>
            	<button class="btn1" onclick="location.href='List.jsp'">목록</button>
                <button class="btn1 color2" onclick="location.href='Calender.jsp'">캘린더</button>
            </header>
            </div> 
    </div>
    <!-- 헤더 영역 끝 -->
    
    <!-- 사진 촬영 영역 -->
    <div id = "camera_font" ><p><br>카메라를 클릭하세요!</div>
    <button id="start-camera"><img src="img/Kamera.png"style="width: 40vw"></button>   
    <video id="video" width="320" height="240" autoplay></video><br>
    <button id="click-photo">촬영</button>
    <div id = "photo_font" style="display:block"><br>[촬영]버튼을 눌러주세요!<br><br></div>
	<!-- 촬영한 사진 결과 영역-->
    <div id="dataurl-container">
    <br><br>
        <canvas id="canvas" width="320" height="240" ></canvas>    
         <!-- <textarea id="dataurl" readonly></textarea> 사진 데이터는 표시 안함-->                
    	<form action = "Save.jsp" method = "Post" name = "MyForm">
			<input type="hidden" name="photodata" value=""> 		   
	</div>
	
    

    <div id = "save_font"style="display:none"><br>[사진저장] 클릭 후 재촬영은 불가합니다! <br><br></div>
     
    <!-- 사진촬영 스크립트 영역-->
    <script>   
        let camera_button = document.querySelector("#start-camera");
        let video = document.querySelector("#video");
        let click_button = document.querySelector("#click-photo");
        let re_click_button = document.querySelector("#re_click-photo");
        let canvas = document.querySelector("#canvas");
        let dataurl = document.querySelector("#dataurl");
        let dataurl_container = document.querySelector("#dataurl-container");
        

    	<!-- [촬영시작] 버튼 클릭시 동작하는 함수-->
        camera_button.addEventListener('click', async function() {
            let stream = null;
            
            try {
                stream = await navigator.mediaDevices.getUserMedia({
                    video: true,
                    audio: false
                });
            } catch (error) {
                alert(error.message);
                return;
            }
			
            video.srcObject = stream;
            
            video.style.display = 'block'; <!--[촬영시작] 버튼 클릭시 웹 캠 보이기-->   
            camera_button.style.display = 'none'; <!--[촬영시작] 버튼 클릭시 [촬영시작] 버튼 숨기기-->   
            click_button.style.display = 'block'; <!-- [촬영시작] 버튼 클릭시 [촬영] 버튼 보이기-->   
            re_click_button.style.display = 'bolck'; <!-- [촬영시작] 버튼 클릭시 [재촬영] 버튼 보이기--> 
            document.getElementById("camera_font").style.display="none";
            document.getElementById("photo_font").style.display="block";

        });
        
        
    	<!-- [촬영] 버튼 클릭시 동작하는 함수-->
        	click_button.addEventListener('click', function() {
            canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
            let image_data_url = canvas.toDataURL('image/jpeg');
			document.MyForm.photodata.value = image_data_url;

            // data URL 표시 안함 dataurl.value = image_data_url;
            
            click_button.style.display = 'block'; <!--[촬영] 버튼 클릭시 [촬영] 버튼 숨기기 이지만 현재 구현에 어려움이 있음으로 우선 표시로 진행--> 
            re_click_button.style.display = 'bolck'; <!--[촬영] 버튼 클릭시 [재촬영] 버튼 보이기-->           
            dataurl_container.style.display = 'block'; <!--[촬영] 버튼 클릭시 '사진결과' 영역 보이기-->  
            Confirmation.style.display = 'block'; <!--[촬영] 버튼 클릭시 [사진결정] 버튼 보이기-->    
            document.getElementById("camera_font").style.display="none";
            
        });            
    </script>
    
	<!-- 게시글 작성 영역-->
    <div>
       <textarea id="summernote" name="write" ></textarea>
    </div>
    
    <!-- 게시글 스크립트 영역-->
       <script>
            $('#summernote').summernote({
               height: 350,
               toolbar: [
                   ['fontname', ['fontname']],
                   ['fontsize', ['fontsize']],
                   ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
                   ['color', ['forecolor','color']],
                   ['table', ['table']],
                   ['para', ['ul', 'ol', 'paragraph']],
                   ['height', ['height']],
                   ['insert',['picture','link','video']],  
                   ['view', ['fullscreen', 'help']]
               ],
               fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
               fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
            });
       </script>
       <br><br><br>
       <!-- form(MyForm)과 내용을 담고 Save.jsp로 전달하는 버튼-->
         <button type="submit" class="btn1" id="Confirmation" formaction="Save.jsp" >등록 </button>
       <br><br><br>
     </form>
                
     
    </body>
    </html>