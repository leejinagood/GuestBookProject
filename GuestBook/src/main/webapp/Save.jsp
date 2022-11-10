<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "java.util.Base64" %>
<%@ page import = "java.io.IOException" %>
<%@ page import = "java.io.File" %>
<%@ page import = "java.io.ByteArrayInputStream" %>
<%@ page import = "java.awt.image.BufferedImage" %>
<%@ page import = "javax.imageio.ImageIO" %>
<%@page import="java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.sql.ResultSet" %>
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
    // 전 페이지에서 넘어온 값 저장
    request.setCharacterEncoding("UTF-8");
		// 넘어온 정보들을 저장하고 다시 홈으로 돌아가는 페이지
		// 작성한 게시글(텍스트)정보와 촬영한 사진을 저장한다.
		
		// String img_nameNum = request.getParameter("NIdx"); // DB에서 넘어온는 pm키 번호 값이 곧 파일 이름이 되어 이미지 파일 이름 중복 방지
		// String imgfile_name = "img_nameNum";  최종적으로 사진 파일 명이 될 데이터
		
		String base64data = request.getParameter("photodata"); // 전달받는 photo URL Data
		int imgfile_name = 1; // 최종적으로 사진 파일 명이 될 데이터 (받아오는 값 혹은 자동 증가값 예정)
		String file_Type = ".jpeg";
		String basic_path = "C:/Users/iojl1/OneDrive/문서/GitHub/GuestBookProject/GuestBook/src/main/webapp/img/"; // 서버로 사용할 컴퓨터에 사진 저장 폴더 경로
		///Users/jina-lee/Desktop/test/
		///Users/seodong-geun/Desktop/test/
		// C:/Users/iojl1/OneDrive/문서/GitHub/GuestBookProject/GuestBook/src/main/webapp/img/
		
		// 파일 덮어쓰기 방지 코드
		File newFile1 = new File(basic_path);   // 로컬 서버의 사진폴더 객체를 생성
		File filelist [] = newFile1.listFiles(); // 사진폴더 파일들을 리스트화
		String path=null;
		// 로컬 사진 폴더 속 모든 파일을 검사하는 반복문
		for (int i=0; i < filelist.length; i++){
			// 만약 파일속에서 imgfile_name변수와 동일한 파일이 있다면(파일 이름이 숫자인 파일이 없다고 생각하고 작성)
			if(filelist[i].isFile()){
				imgfile_name++; // 파일 이름을 1증가시키고  ex) 3.jpg가 있다면 -> 4로 파일 명 수정
				path = (basic_path + Integer.toString(imgfile_name) + file_Type);  // 폴더명 + 새로운 파일 명을 경로에 넣어준다.
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
				path = (basic_path + Integer.toString(imgfile_name) + file_Type);  // imgfile_name 이름으로 생성할 폴더 경로 
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
		<%     
      // 전 페이지에서 넘어온 값 저장
      request.setCharacterEncoding("UTF-8");
      String sPhoto = request.getParameter("photo"); //사진 데이터 받아오기
      String sWrite = request.getParameter("write"); //게시판 정보 받아오기
      
      // DB연결
      Connection MyConn = null;
      String sUrl = "jdbc:mysql://localhost:3306/guestbook";
      String sUser = "root";
      String sPwd = "1234";
      
      
      Class.forName("com.mysql.jdbc.Driver");
      MyConn = DriverManager.getConnection(sUrl, sUser, sPwd);
      //out.println("데이터베이스 연결이 성공했습니다.<br>");
      
      PreparedStatement pstmt = null;
      
      try{
    	 String sSql = "insert into board values(null,?,?, Now());";

      
      pstmt = MyConn.prepareStatement(sSql);
      
      
      // ?가 2개이므로 set(값을 집어넣는 곳 을 생성)
      pstmt.setString(1, path);  //사진 insert
      pstmt.setString(2, sWrite); //게시판 insert
      pstmt.executeUpdate();
      
      //out.println("데이터 입력 성공.");
      
      } catch (SQLException ex) {
      out.println("데이터 입력 실패 <br>");
      out.println("SQLEXception : " + ex.getMessage());
      }
      %>
	<div class="text">
	<br> 사진 결과 <br> <img src="<%=base64data%>"> <br>
		<% 
		out.println("내용 <br>"+ sWrite +"<br>");	
%></div>
<script type="text/javascript">
  alert("등록되었습니다. ");
</script>
 <button class="btn1" id="btn_main" onclick="location.href='index.jsp'">홈 </button>
</body>

</html>