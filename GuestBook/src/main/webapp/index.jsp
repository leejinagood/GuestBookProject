<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <title>Write</title>
        <style>
            body{
                width: 800px;
                margin: 0 auto;
                text-align: center;
            }
            header {
                height: 100px;
                border-bottom: 1vw solid #3399CC;
                margin: 10px;
            }
            .headerbtn{
                text-align: right;
                margin-top: 30px;
            }
            section img{
                margin: 20px;
            }
            .search{
	            width: 50vw;
	            border: 1px solid #1b5ac;
	            background: #fffff;
	            text-align: center;
	            online: none;
	            color: #fffff;
            }
            #btn{
           	 	position: absolute;
           		color: rgba(30, 22, 54, 0.6);
				box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
				color: rgba(255, 255, 255, 0.85);
				box-shadow: rgba(30, 22, 54, 0.7) 0 0px 0px 40px inset;
            }
            
        </style>
    </head>
    <body>
        <img src="img/rogoimg.png" onclick="location.href='index.jsp'" style="width: 10vw">
            <div class="headerbtn">
            <header>
                <button onclick="location.href='List.jsp'">목록</button>
                <button onclick="location.href='Calender.jsp'">캘린더</button>
            </header>
            </div> 
        <section>
            <form >
                <img src="img/Kamera.png" onclick="location.href='Camera.html'" style="width: 40vw">
    
                <div class="write-content" >
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
                <button type="submit">등록</button>
            </form>
        </section>
    </body>
    </html>