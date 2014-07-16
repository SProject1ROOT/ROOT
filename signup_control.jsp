
<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" %>
<%@ page import = "java.sql.*" %>
    
<html>
<head></head>
<body>
<form name=login_control method=post action="signup_result.jsp">
<table width="550" border="1">
<%

Connection conn = null;                                        // null로 초기화 한다.
PreparedStatement pstmt = null;

ResultSet rs=null;

try{
	String db_url = "jdbc:mysql://210.118.74.213:3306/akmu";        // 사용하려는 데이터베이스명을 포함한 URL 기술
	String db_id = "akmu";                                                    // 사용자 계정
	String db_pw = "akmu0369";                                                // 사용자 계정의 패스워드

	Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(db_url,db_id,db_pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.

	String email=request.getParameter("id_email");
	String nickname=request.getParameter("nickname");
	String password=request.getParameter("password1");

	String sql="select * from users where nickname=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1,nickname);

	rs=pstmt.executeQuery();

	if(rs.next()){
%>
<script type="text/javascript">
	alert("이미 존재하는 닉네임입니다. 다시 입력하세요");
	history.go(-1);
</script>
<%
	}
	else{
		sql="select * from users where email=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,email);
		
		rs=pstmt.executeQuery();
		
		if(rs.next()){
%>
<script type="text/javascript">
	alert("이미 존재하는 이메일 계정입니다. 다시 입력하세요.");
	history.go(-1);
</script>
<%
		}
	else{
		sql="insert into users(email,nickname,password,confirm,level,image) values(?,?,?,?,?,?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,email);
		pstmt.setString(2,nickname);
		pstmt.setString(3,password);
		pstmt.setInt(4,0);
		pstmt.setInt(5,1);
		pstmt.setString(6,"./image/profile.png");
		
		pstmt.executeUpdate();
%>
<script type="text/javascript">
	alert("이메일 인증 후, 회원가입을 완료해주세요.");
	document.location.href="/home.jsp";
</script>
<%
		}
	}
	
}catch(Exception e){
	e.printStackTrace();
	out.println("DB 호출 실패");
}finally{                                 
	if(rs != null) try{rs.close();}catch(SQLException sqle){}            
	if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   
	if(conn != null) try{conn.close();}catch(SQLException sqle){} 
}
%>
</table>
</form>
</body>
</html>