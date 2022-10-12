<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>방명록에 등록할 사진을 촬영해 보세요!</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
        
    <style type="text/css">
        button {
            width: 120px;
            padding: 10px;
            display: block;
            margin: 20px auto;
            border: 2px solid #111111;
            cursor: pointer;
            background-color: white;
        }
        
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
</head>

<body>	
    <button id="start-camera">촬영시작</button>    
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
            
            click_button.style.display = 'none'; <!--[촬영] 버튼 클릭시 [촬영] 버튼 숨기기--> 
            re_click_button.style.display = 'bolck'; <!--[촬영] 버튼 클릭시 [재촬영] 버튼 보이기-->           
            dataurl_container.style.display = 'block'; <!--[촬영] 버튼 클릭시 '사진결과' 영역 보이기-->  
            Confirmation.style.display = 'block'; <!--[촬영] 버튼 클릭시 [사진결정] 버튼 보이기-->                    
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
</body>

</html>

