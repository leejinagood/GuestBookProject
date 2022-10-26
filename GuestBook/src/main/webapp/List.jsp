@@ -1,5 +1,7 @@
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = " java.util.Vector" %>
<!DOCTYPE html>
<html>
<head>
<title>List</title>
</head>
<style>
			body{
				body{
                width: 800px;
                margin: 0 auto;
                text-align: center;
    
            header {
                height: 100px;
                border-bottom: 1vw solid #3399CC;
                border-bottom: 1px solid black;
                margin: 10px;
            }
    
            .headerbtn{
                text-align: right;
                margin-top: 30px;
                margin-top: 10px;
            }
            
            .search{
            width: 50vw;
            border: 1px solid #1b5ac;
            }
</style>
<body>
		<img src="img/rogoimg.png" onclick="location.href='index.jsp'" style="width: 10vw">
		<img src="img/rogo.png" onclick="location.href='index.jsp'" style="width: 10vw">
        <div class="headerbtn">
            <header>
	            <input class = "search" type="text" placeholder="제목+내용 검색하세요 " >
                <button onclick="location.href='Calender.jsp'">캘린더</button>
            </header>
         </div>        
        	
<% 
String sUrl = "jdbc:mysql://localhost:3306/guestbook_1";
String sUser = "root";
String sPwd = "abcd1234";

Class.forName("com.mysql.jdbc.Driver");
Connection MyConn = DriverManager.getConnection(sUrl, sUser, sPwd);
out.println("데이터베이스 연결이 성공했습니다.<br>");

String sSql = "SELECT * FROM guestbook_1.user_tb order by number desc;";

Statement stmt = null;
ResultSet rs = null;

try{
	stmt = MyConn.createStatement();
	rs = stmt.executeQuery(sSql);
	out.println("Select 성공. <br>");
%>

<%!

private final class TestDAO {
	private Connection conn; // 데이터에비스에 접근
	private PreparedStatement pstmt;
	
	
	public TestDAO(){ // 생성자
		String dbURL="jdbc:mysql://localhost:3306/guestbook_1";
		String dbID="root"; // db 아이디
		String dbPassword="abcd1234"; // db 비밀번호
		
		try{
			Class.forName("com.mysql.jdbc.Driver"); // 드라이버 로드
			conn=DriverManager.getConnection(dbURL, dbID, dbPassword); // 연결
		} catch(ClassNotFoundException e){
			e.printStackTrace();
		} catch(SQLException e){
			e.printStackTrace();
		}
	}	
	public int selectCnt (String table) {
		int result = 0;
		ResultSet rs = null;
		Statement stmt = null;
		String sql = "SELECT * FROM guestbook_1.user_tb order by number desc;";
	
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			
		}
		return result;
	}

	
	Vector<TestDTO> selectPage(String table, int start, int pageCnt){
		ResultSet rs=null;
		
		String SQL = "SELECT * FROM guestbook_1.user_tb order by number desc limit ?, ?";
		Vector<TestDTO> v = new Vector<TestDTO>();
		
		try{
			pstmt = conn.prepareStatement(SQL); // db에 연결하여 SQL 사용 준비
			pstmt.setInt(1, start);
			pstmt.setInt(2, pageCnt);
			rs = pstmt.executeQuery();
			while(rs.next()){
				TestDTO dto = new TestDTO();
				//dto.setnIDX(rs.getString("number"));
				dto.setvName(rs.getString("image"));
				dto.setnPoint(rs.getString("memo"));
				dto.setdRegDate(rs.getString("data"));
				v.add(dto);
			}
		}catch(Exception e){
			e.printStackTrace();
		} finally{
			
		}
		
		return v;
	}
}
	
	
	public final class TestDTO{
		private String  number;
		private String image;
		private String memo;
		private String data;
		
		
		public void setnIDX(String nIDX) {
	        this.number = nIDX;
	    }
	    public String  getnIDX() {
	        return number;
	    }
	    public void setvName(String vName) {
	        this.image = vName;
	    }
	    public String getvName() {
	        return image;
	    }
	    public void setnPoint(String nPoint) {
	        this.memo = nPoint;
	    }
	    public String getnPoint() {
	        return memo;
	    }
	    public void setdRegDate(String dRegDate) {
	        this.data = dRegDate;
	    }
	    public String getdRegDate() {
	        return data;
	    }
	}
	

%>

<style>
	td, th{
		border: 1px solid black;
	}
	table{
		width: 500px;
		border-collapse: collapse;
	}
</style>

</head>
<body>
	<% 
		TestDAO dao = new TestDAO();
		int count = dao.selectCnt("board"); // 전체행 갯수
		
		String tempStart = request.getParameter("page");
		// 현재 페이지를 받아옴 
		int startPage = 0; // limit의 시작값 -> 첫 limit 0,10
		int onePageCnt=10; // 한페이지에 출력할 행의 갯수
		
		count = (int)Math.ceil((double)count/(double)onePageCnt);
		// 페이지 수 저장
		
		if(tempStart != null){ // 처음에는 실행되지 않는다.
			startPage = (Integer.parseInt(tempStart)-1)*onePageCnt;
		}
		
		Vector<TestDTO> v = dao.selectPage("board", startPage, onePageCnt);
	%>
	게시판 테스트<br>
	<table>
		<tr>
			<th>글번호</th><th>사진</th><th>글쓴이</th><th>날짜</th>
		</tr>
		<%	
		for(int i=0; i<v.size(); i++){
			
			%>
			<tr>
				<td><%= i+1  %></td>
				<td><%= v.get(i).getvName() %></td>
				<td><a href="index2.jsp?nIDX=<%=i %>"><%= v.get(i).getnPoint() %> </td>
				<td><%= v.get(i).getdRegDate()%></td>
			</tr>
		<%
		} %>
	</table><br>
	<%
		for(int i=1; i<=count; i++){ %>
			
			<a href="List.jsp?page=<%=i %>">[<%=i%>]
			</a>
		<% }; %>
	
	<br>
	<button onclick="ContentUp()">글쓰기</button>
	<script>
		function ContentUp(){
			location.href="ContenUp.jsp"
		};
	</script>
<%
}catch(SQLException ex){ 
	out.println("Select 에러 <br>");
	out.println("SQLException : " + ex.getMessage());
} finally {
	if(rs!= null)
		rs.close();
	if(stmt!= null)
		stmt.close();
	if(MyConn != null)
		MyConn.close();
}
	%>
	

</body>
</html>