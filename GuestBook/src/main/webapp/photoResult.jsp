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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
</script>
<body>
	<%	
		
		String base64data = request.getParameter("photodata"); // 전달받는 photo URL Data
		String imgfile_name = "3"; // 최종적으로 사진 파일 명이 될 데이터 
		String path = "/Users/seodong-geun/Desktop/test/" + imgfile_name;  // 우선 imgfile_name 이름으로 생성할 폴더 경로 
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
%>
</body>
</html>