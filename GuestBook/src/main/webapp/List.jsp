<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List</title>
</head>
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
            .search{
            width: 50vw;
            border: 1px solid #1b5ac;
            background: #fffff;
            online: none;
            color: #fffff;
            }
</style>
<body>
		<img src="img/rogoimg.png" onclick="location.href='index.jsp'" style="width: 10vw">
        <div class="headerbtn">
            <header>
	            <input class = "search" type="text" placeholder="제목+내용 검색하세요 " >
	            <button>검색 </button>
	            <button onclick="location.href='index.jsp'">홈 </button>
                <button onclick="location.href='List.jsp'">목록</button>
                <button onclick="location.href='Calender.jsp'">캘린더</button>
            </header>
         </div>        
        	
</body>
</html>