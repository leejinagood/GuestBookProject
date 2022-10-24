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
        <section>
            <form >
                <img src="img/Kamera.png" onclick="location.href='Camera.jsp'" style="width: 40vw">
                <p><br>카메라를 클릭하세요!<br><br>
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
                <button class="btn1" id="btn_main" type="submit">등록</button><br><br>
            </form>
        </section>
    </body>
    </html>