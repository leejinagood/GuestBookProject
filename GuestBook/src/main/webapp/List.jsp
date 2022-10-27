<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = " java.util.Vector" %>
<!DOCTYPE html>
<html>
<head>
<title>List</title>
</head>
<a href="https://dept.daelim.ac.kr/com/index.do"><img class="daelim" src="img/daelim.png" ></a><br><br>
    <link rel="stylesheet" href="List.css">

<body>
		<img src="img/rogoimg.png" onclick="location.href='index.jsp'" style="width: 10vw">
        <div class="headerbtn">
            <header>
            	<button class="btn1"  onclick="location.href='index.jsp'">홈 </button>
            	<button class="btn1" id="btn_main" onclick="location.href='List.jsp'">목록</button>
                <button class="btn1 color2" onclick="location.href='Calender.jsp'">캘린더</button>
            </header>
         </div>      
         
         <div class="ser">
    <input type="text" class="serc">
    <button class="serch" onclick="location.href = '주소';">검색</button>
    </div>
       
<% 
String sUrl = "jdbc:mysql://localhost:3306/guestbook";
String sUser = "root";
String sPwd = "abcd1234";

Class.forName("com.mysql.jdbc.Driver");
Connection MyConn = DriverManager.getConnection(sUrl, sUser, sPwd);

String sSql = "SELECT * FROM guestbook.board order by Idx ASC;";

Statement stmt = null;
ResultSet rs = null;

try{
	stmt = MyConn.createStatement();
	rs = stmt.executeQuery(sSql);
%>

<%!

private final class TestDAO {
	private Connection conn; // 데이터에비스에 접근
	private PreparedStatement pstmt;
	
	
	public TestDAO(){ // 생성자
		String dbURL="jdbc:mysql://localhost:3306/guestbook";
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
		String sql = "SELECT * FROM guestbook.board order by Idx ASC;";
	
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
		
		String SQL = "SELECT * FROM guestbook.board order by Idx ASC limit ?, ?";
		Vector<TestDTO> v = new Vector<TestDTO>();
		
		try{
			pstmt = conn.prepareStatement(SQL); // db에 연결하여 SQL 사용 준비
			pstmt.setInt(1, start);
			pstmt.setInt(2, pageCnt);
			rs = pstmt.executeQuery();
			while(rs.next()){
				TestDTO dto = new TestDTO();
				//dto.setnIDX(rs.getString("number"));
				dto.setvName(rs.getString("photo"));
				dto.setnPoint(rs.getString("wirite"));
				dto.setdRegDate(rs.getString("date"));
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
		private String  Idx;
		private String photo;
		private String wirite;
		private String date;
		
		
		public void setnIDX(String nIDX) {
	        this.Idx = nIDX;
	    }
	    public String  getnIDX() {
	        return Idx;
	    }
	    public void setvName(String vName) {
	        this.photo = vName;
	    }
	    public String getvName() {
	        return photo;
	    }
	    public void setnPoint(String nPoint) {
	        this.wirite = nPoint;
	    }
	    public String getnPoint() {
	        return wirite;
	    }
	    public void setdRegDate(String dRegDate) {
	        this.date = dRegDate;
	    }
	    public String getdRegDate() {
	        return date;
	    }
	}
	

%>

<style>
	td, th{
		
	}
	table{
		
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
	<br><br><br>
	<div class="table">
	<table>
		<tr>
			<th>글 번호</th><th>사진</th><th>내용 </th><th>날짜</th>
		</tr>
		<%	
		for(int i=0; i<v.size(); i++){
			
			%>
			<tr>
				<td><%= i+1  %></td>
				<td><%= v.get(i).getvName() %></td>
				<td><%= v.get(i).getnPoint() %> </td>
				<td><%= v.get(i).getdRegDate()%></td>
			</tr>
		<%
		} %>
	</table><br></div>
	<%
		for(int i=1; i<=10; i++){ %>
			
			<a href="List.jsp?page=<%=i %>">[<%=i%>]
			</a>
		<% }; %>
	
	<br><br><br><br>
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