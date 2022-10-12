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
    
    <video id="video" width="320" height="240" autoplay></video>

    <button id="click-photo">촬영</button>
    <button id="re_click-photo">재촬영</button>

    
    <div id="dataurl-container">
   		<div id="dataurl-header">촬영결과</div>	
        <canvas id="canvas" width="320" height="240"></canvas>
       
         <!-- <textarea id="dataurl" readonly></textarea> -->
         
    	<form action = "photoResult.jsp" method = "Post" name = "MyForm">
			<input type="hidden" name="photodata" value=""> 
    		<button = "submit" id = "Confirmation" display = 'none'>사진 결정</button>
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
            video.style.display = 'block';
            camera_button.style.display = 'none';
            click_button.style.display = 'block';
            re_click_button.style.display = 'block';
            
            
            const Confirmation__btn = document.getElementById('Confirmation');
            // photo_btn 숨기기 (display: none)
            if(Confirmation.style.display !== 'none') {
            	Confirmation.style.display = 'none';
            }           
         
        });
        
        
        
        click_button.addEventListener('click', function() {
            canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
            let image_data_url = canvas.toDataURL('image/jpeg');
			document.MyForm.photodata.value = image_data_url;

            // data URL 화면 숨기기  dataurl.value = image_data_url;
            
            click_button.style.display = 'none';
            re_click_button.style.display = 'bolck';
            
            dataurl_container.style.display = 'block';
           
            
            const Confirmation__btn = document.getElementById('Confirmation');
            // photo_btn 숨기기 (display: none)
            if(Confirmation.style.display !== 'block') {
            	Confirmation.style.display = 'block';
            }  
        });   
        
        re_click_button.addEventListener('click', function() {
            canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
            let image_data_url = canvas.toDataURL('image/jpeg');
			document.MyForm.photodata.value = image_data_url;

            // data URL 화면 숨기기  dataurl.value = image_data_url;
            
            dataurl_container.style.display = 'block';
             
        }); 
    </script>
</body>

</html>

