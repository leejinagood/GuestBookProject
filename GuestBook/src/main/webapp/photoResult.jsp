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
		// String img_nameNum = request.getParameter("NIdx"); // DB에서 넘어온는 pm키 번호 값이 곧 파일 이름이 되어 이미지 파일 이름 중복 방지
		String base64data = request.getParameter("photodata"); // 전달받는 photo URL Data
		int imgfile_name = 6; // 최종적으로 사진 파일 명이 될 데이터 (받아오는 값 혹은 자동 증가값 예정)
		// String imgfile_name = "img_nameNum";  최종적으로 사진 파일 명이 될 데이터
		
		File newFile1 = new File("/Users/seodong-geun/Desktop/test/"); 
		File filelist [] = newFile1.listFiles();
		
		for (int i=0; i < filelist.length; i++){
			if(filelist[i].isFile()){
				imgfile_name++;
				String path = ("/Users/seodong-geun/Desktop/test/" + Integer.toString(imgfile_name));  // imgfile_name 이름으로 생성할 폴더 경로 
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
			}
		}

		
%>
</body>
</html>