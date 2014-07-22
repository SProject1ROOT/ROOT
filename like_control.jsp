<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<!--meta name="viewport" content="width=device-width, initial-scale=1.0"-->
		<meta name="description" content="">
		<meta name="author" content="">
		<link rel="shortcut icon" href="../../assets/ico/favicon.png">

		<title>Projects</title>

		<!-- Bootstrap core CSS -->
		<link href="css/bootstrap.css" rel="stylesheet">
		<link href="css/non-responsive.css" rel="stylesheet">
		<!-- Custom styles for this template -->
		<link href="css/jumbotron.css" rel="stylesheet">
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
			<script src="../../assets/js/html5shiv.js"></script>
			<script src="../../assets/js/respond.min.js"></script>
		<![endif]-->
	</head>
<body>
	<%
	
	
	Connection conn = null;                                        // null로 초기화 한다.
	PreparedStatement pstmt = null;

	ResultSet rs=null;
	
	int project_id=Integer.parseInt(request.getParameter("project_id"));
	if((String)session.getAttribute("uid")==null){
		out.println("<script>alert('로그인해주세요.');</script>");
		out.println("<script>history.go(-1);</script>");
	}
	int user_id=Integer.parseInt((String)session.getAttribute("uid"));
	
	try{
		String db_url = "jdbc:mysql://210.118.74.213:3306/akmu";        // 사용하려는 데이터베이스명을 포함한 URL 기술
		String db_id = "akmu";                                                    // 사용자 계정
		String db_pw = "akmu0369";                                                // 사용자 계정의 패스워드
	System.out.println("-----------------------------------------");
			System.out.println("디비 접속");
		Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		conn=DriverManager.getConnection(db_url,db_id,db_pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
		
		String sql="select * from likes where user_id=? and project_id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1,user_id);
		pstmt.setInt(2,project_id);

		rs=pstmt.executeQuery();
		
		if(rs.next()){
			System.out.println("이미 눌렀땅");
			
		}
		else{
		System.out.println("Insert----------------------------");
		
		sql="insert into likes(project_id,user_id) values(?,?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1,project_id);
		pstmt.setInt(2,user_id);
			
		pstmt.executeUpdate();
		System.out.println("select---------------------------");
		
		sql="select * from projects where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1,project_id);
		
		rs=pstmt.executeQuery();
		int likes=0;
		if(rs.next())
			likes=rs.getInt("likes");
		
		System.out.println("update---------------------------");
		System.out.println("like : "+likes);
		System.out.println("id : "+project_id);
		sql="update projects set likes=? where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1,likes+1);
		pstmt.setInt(2,project_id);
			
		pstmt.executeUpdate();
		}
		
		}catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
		e.printStackTrace();
		out.println("DB 호출 에러");
	}finally{                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
		if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset 객체 해제
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement 객체 해제
		if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제
	}
	response.sendRedirect((String)session.getAttribute("backpage"));
	session.setAttribute("backpage",request.getRequestURI());
		%>

<!--
/.container
-->
<!-- Bootstrap core JavaScript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>
</div>
</div>