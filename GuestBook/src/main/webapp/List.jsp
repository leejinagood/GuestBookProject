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
		String sPwd = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection MyConn = DriverManager.getConnection(sUrl, sUser, sPwd);
		out.println("데이터베이스 연결이 성공했습니다.<br>");
		
		String sSql = "SELECT * FROM guestbook.board order by Idx desc;";
		
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
		String dbURL="jdbc:mysql://localhost:3306/guestbook";
		String dbID="root"; // db 아이디
		String dbPassword="1234"; // db 비밀번호
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
		String sql = "SELECT * FROM guestbook.board order by Idx desc;";
	
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
		
		String SQL = "SELECT * FROM guestbook.board order by Idx desc limit ?, ?";
		Vector<TestDTO> v = new Vector<TestDTO>();
		
		try{
			pstmt = conn.prepareStatement(SQL); // db에 연결하여 SQL 사용 준비
			pstmt.setInt(1, start);
			pstmt.setInt(2, pageCnt);
			rs = pstmt.executeQuery();
			while(rs.next()){
				TestDTO dto = new TestDTO();
				dto.setIdx(rs.getString("Idx"));
				dto.setphoto(rs.getString("photo"));
				dto.setwrite(rs.getString("write"));
				dto.setdate(rs.getString("date"));
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
		private String write;
		private String date;
		
		public void setIdx(String Idx) {
	        this.Idx = Idx;
	    }
	    public String  getIdx() {
	        return Idx;
	    }
	    public void setphoto(String photo) {
	        this.photo = photo;
	    }
	    public String getphoto() {
	        return photo;
	    }
	    public void setwrite(String write) {
	        this.write = write;
	    }
	    public String getwrite() {
	        return write;
	    }
	    public void setdate(String date) {
	        this.date = date;
	    }
	    public String getdate() {
	        return date;
	    }
	}
	

%>
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
	<table>
		<tr>
			<th>글번호</th>
			<th>사진</th>
			<th>게시글</th>
			<th>날짜</th>
		</tr>
		<%
		for(int j=0; j<v.size(); j++){
		%>
			<tr>
				<td><%= v.get(j).getIdx()%></td>
				<td><%= v.get(j).getphoto() %></td>
				<td><%= v.get(j).getwrite() %> </td>
				<td><%= v.get(j).getdate()%></td>
			</tr>
		<% 
		}
		%>
	</table><br>

	   <%
		for(int j=1; j<=count; j++){ %>
			<a href="List.jsp?page=<%=j %>">[<%=j%>]</a>
		<%  }; %>
	
	<br>
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