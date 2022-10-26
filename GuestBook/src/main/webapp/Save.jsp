<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "java.util.Base64" %>
<%@ page import = "java.io.IOException" %>
<%@ page import = "java.io.File" %>
<%@ page import = "java.io.ByteArrayInputStream" %>
<%@ page import = "java.awt.image.BufferedImage" %>
<%@ page import = "javax.imageio.ImageIO" %>


<!DOCTYPE html>
<html>
<head>
<a href="https://dept.daelim.ac.kr/com/index.do"><img class="daelim" src="img/daelim.png" ></a><br><br>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
</script>
<link rel="stylesheet" href="Save.css">
<body>
 <img class="rogoimg" src="img/rogoimg.png" onclick="location.href='index.jsp'"><br><br><br>
	<%
		// 넘어온 정보들을 저장하고 다시 홈으로 돌아가는 페이지
		// 작성한 게시글(텍스트)정보와 촬영한 사진을 저장한다.
		
		// String img_nameNum = request.getParameter("NIdx"); // DB에서 넘어온는 pm키 번호 값이 곧 파일 이름이 되어 이미지 파일 이름 중복 방지
		// String imgfile_name = "img_nameNum";  최종적으로 사진 파일 명이 될 데이터
		
		String base64data = request.getParameter("photodata"); // 전달받는 photo URL Data
		int imgfile_name = 1; // 최종적으로 사진 파일 명이 될 데이터 (받아오는 값 혹은 자동 증가값 예정)
	
		String notetext = request.getParameter("text"); // 전달받은 게시글 Data
		String basic_path = "/Users/jina-lee/Desktop/test/"; // 서버로 사용할 컴퓨터에 사진 저장 폴더 경로
		///Users/jina-lee/Desktop/test/
		///Users/seodong-geun/Desktop/test/
		
		// 파일 덮어쓰기 방지 코드
		File newFile1 = new File(basic_path);   // 로컬 서버의 사진폴더 객체를 생성
		File filelist [] = newFile1.listFiles(); // 사진폴더 파일들을 리스트화
		
		// 로컬 사진 폴더 속 모든 파일을 검사하는 반복문
		for (int i=0; i < filelist.length; i++){
			// 만약 파일속에서 imgfile_name변수와 동일한 파일이 있다면(파일 이름이 숫자인 파일이 없다고 생각하고 작성)
			if(filelist[i].isFile()){
				imgfile_name++; // 파일 이름을 1증가시키고  ex) 3.jpg가 있다면 -> 4로 파일 명 수정
				String path = (basic_path + Integer.toString(imgfile_name));  // 폴더명 + 새로운 파일 명을 경로에 넣어준다.
				File newFile = new File(path); // 파일 생성
				if(newFile.isFile()){ // 새로운 경로에도 파일이 있다면 2번째 파일 부터 다시 탐색
					continue;
				}
				String data = base64data.split(",")[1]; // 문자열 데이터를 ","부터 자르기 
				byte[] imageBytes = Base64.getDecoder().decode(data);

				// 이미지 파일 저장
				try {
					
					BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(imageBytes));
					ImageIO.write(bufImg, "jpeg", newFile);			
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			}
			// 파일명이 겹치지 않으면 동작하는 조건문 == 파일 저장 코드
			if(filelist[i].isFile()){
				String path = (basic_path + Integer.toString(imgfile_name));  // imgfile_name 이름으로 생성할 폴더 경로 
				File newFile = new File(path);
				
				String data = base64data.split(",")[1]; // 문자열 데이터를 ","부터 자르기 
				byte[] imageBytes = Base64.getDecoder().decode(data);

				// 이미지 파일 저장
				try {
					
					BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(imageBytes));
					ImageIO.write(bufImg, "jpeg", newFile);			
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			}
		}%>
	<div class="text">
		<% 
		out.println("내용 : "+ notetext +"<br>");	
%></div>
<script type="text/javascript">
  alert("등록되었습니다. ");
</script>
 <button class="btn1" id="btn_main" onclick="location.href='index.jsp'">홈 </button>
</body>

</html>