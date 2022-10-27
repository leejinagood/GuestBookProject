<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
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
      String sPhoto = request.getParameter("photo"); //사진 데이터 받아오기
      String sWrite = request.getParameter("write"); //게시판 정보 받아오기
      
      out.println(sPhoto + "<br>");
      out.println(sWrite + "<br>");
      
      
      // DB연결
      Connection MyConn = null;
      String sUrl = "jdbc:mysql://localhost:3306/guestBook_1";
      String sUser = "root";
      String sPwd = "abcd1234";
      
      
      Class.forName("com.mysql.jdbc.Driver");
      MyConn = DriverManager.getConnection(sUrl, sUser, sPwd);
      out.println("데이터베이스 연결이 성공했습니다.<br>");
      
      PreparedStatement pstmt = null;
      
      try{
      String sSql = "insert into board values(null,?,?, Now());";
      
      pstmt = MyConn.prepareStatement(sSql);
      
      
      // ?가 2개이므로 set(값을 집어넣는 곳 을 생성)
      pstmt.setString(1, sPhoto);  //사진 insert
      pstmt.setString(2, sWrite); //게시판 insert
      pstmt.executeUpdate();
      
      out.println("데이터 입력 성공.");
      
      } catch (SQLException ex) {
      out.println("데이터 입력 실패 <br>");
      out.println("SQLEXception : " + ex.getMessage());
      }
      %>
<%    response.sendRedirect("index.jsp"); %>
</body>
</html> --%>



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
      String sPhoto = request.getParameter("photo"); //사진 데이터 받아오기
      String sWrite = request.getParameter("write"); //게시판 정보 받아오기
      
      out.println(sPhoto + "<br>");
      out.println(sWrite + "<br>");
      
      
      // DB연결
      Connection MyConn = null;
      String sUrl = "jdbc:mysql://localhost:3306/guestBook_1";
      String sUser = "root";
      String sPwd = "abcd1234";
      
      
      Class.forName("com.mysql.jdbc.Driver");
      MyConn = DriverManager.getConnection(sUrl, sUser, sPwd);
      out.println("데이터베이스 연결이 성공했습니다.<br>");
      
      PreparedStatement pstmt = null;
      
      try{
    	 String sSql = "insert into user_tb(image, memo, data)values(?,?, Now());";
      
      pstmt = MyConn.prepareStatement(sSql);
      
      
      // ?가 2개이므로 set(값을 집어넣는 곳 을 생성)
      pstmt.setString(1, sPhoto);  //사진 insert
      pstmt.setString(2, sWrite); //게시판 insert
      pstmt.executeUpdate();
      
      out.println("데이터 입력 성공.");
      
      } catch (SQLException ex) {
      out.println("데이터 입력 실패 <br>");
      out.println("SQLEXception : " + ex.getMessage());
      }
      %>
<%    response.sendRedirect("Save.jsp"); %>
</body>
</html>
