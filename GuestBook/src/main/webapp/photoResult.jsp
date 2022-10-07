<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "org.apache.commons.net.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%	
	
	String sID = request.getParameter("photodata"); 
	
	String imageDataBytes = completeImageData.substring(completeImageData.indexOf(",")+1);

	InputStream stream = new ByteArrayInputStream(Base64.decode(imageDataBytes.getBytes(), Base64.DEFAULT));
	decoder(sID,"/사용자/seodong-geun/데스크탑/photodatafile" );
	
	/*byte[] binary = Base64.decodeBase64("text a");
	FileOutputStream fos = null;
	fos = new FileOutputStream("/사용자/seodong-geun/데스크탑/photodatafile");
	fos.write ( binary , 0 , binary.length );
	fos.close();
	 */
	
%>
	<image src="<%=sID %>">
</body>
</html>