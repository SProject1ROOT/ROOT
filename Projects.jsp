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
		<script language="javascript">
		
		</script>
	</head>
<body>
	<%session.setAttribute("backpage",request.getRequestURI());%>
<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="./home.jsp">Akdong Music</a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li><a href="./home.jsp">Home</a></li>
				<li class="active"><a href="./Projects.jsp">Projects</a></li>
				<li><a href="./Musics.jsp">Musics</a></li>
				<li><a href="./mypage.jsp">MyPage</a></li>
			</ul>
			<%
			if(session.getAttribute("nickname")==null){
			%>
          <form id="form1" class="navbar-form navbar-right" method="post" action="login_control.jsp">
            <div class="form-group">
              <input type="text" id="id_email_id" name="id_email" placeholder="Email" class="form-control">
            </div>
            <div class="form-group">
              <input type="password" name="password" placeholder="Password" class="form-control">
            </div>
            <button type="button" class="btn btn-success" onclick="check_submit();">Sign in</button>
			<a href="signup.jsp" class="btn btn-primary" role="button">Sign up</a>
			</form>
			<%}
			else{
			%>         
			<form class="navbar-form navbar-right">
            <div class="form-group">
              <h4><font color="white"><%=session.getAttribute("nickname")%></font></h4>
            </div>
            <a href="sessionLogout.jsp" class="btn btn-success" >Sign Out</a>
          </form>	
			<%
			}
			%>
		</div>
	</div>
</div>
<div class="container">
	<div class="row row-offcanvas row-offcanvas-right">
		<div id="sidebar" class="col-xs-6 col-xs-3 sidebar-offcanvas" role="navigation">
			<div class="well sidebar-nav">
				<ul class="nav">
					<li class="active">
						<a href="./Edit.jsp?project_id=" type="button" class="btn btn-primary">New Projects</a>
					</li>
					<li>
						<br>
						<img src="./image/ProjectIntro.PNG" alt="Projects Intro image" class="img-rounded">
					</li>
					<br>
					<li>음원을 병합하고 편집하기 위한 프로젝트를 생성하세요. 다양한 사용자들이 참여할 수 있으며 음원 추가 및 병합 기능이 제공됩니다.</li>
				</ul>
			</div>
			<!--
            /.well 
            -->
		</div>
		<!--
        /span
        -->
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

	String sql="select * from projects";
	pstmt=conn.prepareStatement(sql);

	rs=pstmt.executeQuery();
	int i=0;
	while(rs.next()){
		int id=rs.getInt("id");
		int like=rs.getInt("like");
		Date date_create=rs.getDate("date_create");
		Date date_modify=rs.getDate("date_modify");
		String image_path=rs.getString("image_path");
		String description=rs.getString("description");
		int play_cnt=rs.getInt("play_cnt");
		String name=rs.getString("name");
		%>
		<div class="col-xs-12 col-xs-9">
		<br>
		<div class="col-xs-12">
			<div class="col-xs-4">
				<img src=<%=image_path %> alt="Projects no image" class="img-rounded">
			</div>
			<div class="col-xs-4 navbar-collapse collapse">
			
				<ul class="nav navbar-nav">
					<a href="Edit.jsp?project_id="+<%=id %>><%=name%></a>
				</ul>
				<br>
				<br>
				<ul class="nav navbar-nav">
					<small><%=description %></small>
				</ul>
				<br>
				<br>
				<ul class="nav navbar-nav">
					<li><a class="btn btn-default" href="#" role="button">Likes</a></li>
					<li><a class="btn btn-default" href="#" role="button">Share</a></li>
					<li><a class="btn btn-default" href="#" role="button">▶ <%=play_cnt %></a></li>
					<li><a class="btn btn-default" href="#" role="button">♥ <%=like %></a></li>
				
				</ul>
			</div>
		</div>
	</div>
		
		<%
		
		/*
		out.println(i+"---------------------------------");
		out.println("id = "+id);
		out.println("like = "+like);
		out.println("date_create = "+date_create);
		out.println("date_modify = "+date_modify);
		out.println("image_path = "+image_path);
		out.println("description = "+description);
		out.println("play_cnt = "+play_cnt);
		out.println("name = "+name);
		*/
		i++;
	}
	
	}catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
	e.printStackTrace();
	out.println("DB 호출 에러");
}finally{                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
	if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset 객체 해제
	if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement 객체 해제
	if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제
}

		%>

</div>
</div>
	<hr>
	</hr>
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