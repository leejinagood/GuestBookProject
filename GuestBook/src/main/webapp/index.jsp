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
        }
        
        #video {
            display: none;
            margin: 50px auto 0 auto;
        }
        
        #click-photo {
            display: none;
        }
        
        #re_click-photo {
            display: none;
        }
        
        #dataurl-container {
            display: none;
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
    </style>
    
        <title>지공모 방문게시판</title>
    </head>
    <a href="https://dept.daelim.ac.kr/com/index.do"><img class="daelim" src="img/daelim.png" ></a><br><br>
    <link rel="stylesheet" href="index.css">
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
                <button id="start-camera"><img src="img/Kamera.png"style="width: 40vw"></button>   
    <video  id="video" width="320" height="240" autoplay></video>
    <button id="click-photo">촬영</button>
    <button id="re_click-photo">재촬영</button>

	<!-- 촬영한 사진 결과 영역-->
    <div id="dataurl-container">
   		<div id="dataurl-header">촬영결과</div>	
        <canvas id="canvas" width="320" height="240"></canvas>    
         <!-- <textarea id="dataurl" readonly></textarea> 사진 데이터는 표시 안함-->                
    	<form action = "photoResult.jsp" method = "Post" name = "MyForm">
			<input type="hidden" name="photodata" value=""> 
    		<button = "submit" id = "Confirmation" display='none'>사진 결정</button>
        </form>
    </div>
	
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
            document.getElementById("click_camera_font").style.display="none";
            
        });
        
        
    	<!-- [재촬영] 버튼 클릭시 동작하는 함수-->
        re_click_button.addEventListener('click', function() {
            canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
            let image_data_url = canvas.toDataURL('image/jpeg');
			document.MyForm.photodata.value = image_data_url;
            
            dataurl_container.style.display = 'block'; <!--[재촬영] 버튼 클릭시 결과사진 영역 보이기-->  
            Confirmation.style.display = 'block'; <!--[재촬영] 버튼 클릭시 [사진결정] 버튼 보이기-->
        }); 
    </script>
        <section>
            <form>
               <div id = "click_camera_font"><p><br>카메라를 클릭하세요!<br><br></div>
                <div>
                    <textarea id="summernote">
                    </textarea>
                </div>
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
                <button class="btn1" id="btn_main" type="submit" name="javascript">등록</button><br><br>
                
                <script type="text/javascript">
  				if(summernote==0)
                alert("내용을 입력하세요 ");
  				else
  					alert("등록 되었습니다.";)
				</script>
				
            </form>
        </section>
    </body>
    </html>