<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%     
		// 전 페이지에서 넘어온 값 저장
		request.setCharacterEncoding("UTF-8");
		String sName = request.getParameter("mName");
		String sPoint = request.getParameter("mPoint");
		
		out.println(sName + "<br>");
		out.println(sPoint + "<br>");
		
		
		// DB연결
		Connection MyConn = null;
		String sUrl = "jdbc:mysql://localhost:3306/class2jsp";
		String sUser = "root";
		String sPwd = "1234";
		
		
		Class.forName("com.mysql.jdbc.Driver");
		MyConn = DriverManager.getConnection(sUrl, sUser, sPwd);
		out.println("데이터베이스 연결이 성공했습니다.<br>");
		
		PreparedStatement pstmt = null;
		
		try{
		String sSql = "insert into tb_study(vName, nPoint, dRegDate)values(?,?, Now());";
		
		pstmt = MyConn.prepareStatement(sSql);
		
		
		// ?가 2개이므로 set(값을 집어넣는 곳 을 생성)
		pstmt.setString(1, sName);					// 문자
		pstmt.setString(2, sPoint); // 숫자
		pstmt.executeUpdate();
		
		out.println("데이터 입력 성공.");
		
		} catch (SQLException ex) {
		out.println("데이터 입력 실패 <br>");
		out.println("SQLEXception : " + ex.getMessage());
		} 
		%>
<% 
 

	String sSql = "select * from class2jsp.tb_study";
	
	Statement stmt = null;
	ResultSet rs = null;
	
	
		stmt = MyConn.createStatement();
		rs = stmt.executeQuery(sSql);
		out.println("Select 성공. <br>");
	
	%>
	<script type="text/javascript">window.alert("입력 성공");</script>
	
	
	


</body>
</html>