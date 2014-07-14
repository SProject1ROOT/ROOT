
<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->

<html>
<head></head>
<body>
<form name=login_control method=post action="login_result.jsp">
<table width="550" border="1">
<%

Connection conn = null;                                        // null로 초기화 한다.
PreparedStatement pstmt = null;

ResultSet rs=null;

//try{
String db_url = "jdbc:mysql://210.118.74.213:3306/akmu";        // 사용하려는 데이터베이스명을 포함한 URL 기술
String db_id = "akmu";                                                    // 사용자 계정
String db_pw = "akmu0369";                                                // 사용자 계정의 패스워드

Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
conn=DriverManager.getConnection(db_url,db_id,db_pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.

String sql = "select * from users where email = ? and password = ?";                        // sql 쿼리
pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
pstmt.setString(1,request.getParameter("id_email"));
pstmt.setString(2,request.getParameter("password"));

rs = pstmt.executeQuery();   

if(!rs.next()){
%>
<script type="text/javascript">
alert("아이디/비밀번호가 올바르지 않습니다. 다시 로그인 하세요.");
history.go(-1);
</script>
<%
	}
else{
while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.

String id = rs.getString("email");
String pw = rs.getString("password");
int confirm = rs.getInt("confirm");
String nickname = rs.getString("nickname");

if(confirm == 1){
	out.print("id : "+id+" , pw : "+pw);
}
else{
%>
<script type="text/javascript">
alert("아이디/비밀번호가 올바르지 않습니다. 다시 로그인 하세요.");
history.go(-1);
</script>

<%
			}
		}
	}
//}catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
//e.printStackTrace();
//out.println("Users 테이블 호출에 실패했습니다.");
//}finally{                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset 객체 해제
if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement 객체 해제
if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제
//}
%>
</table>
</form>
</body>
</html>