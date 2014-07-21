<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="../../assets/ico/favicon.png">

<title>Musics</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="css/jumbotron.css" rel="stylesheet">
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="../../assets/js/html5shiv.js"></script>
      <script src="../../assets/js/respond.min.js"></script>
    <![endif]-->
		<script language="javascript">
		function check_submit()
			{
			//var form = document.getElementById("form1");
			var email = document.getElementById("id_email_id");
			var password = document.getElementById("password");
			
			var pattern=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
			if(email==null || email.value.length<6){
				alert("올바른 이메일을 입력하세요.");
				return;
			}
			else if(!pattern.test(email.value)){
				alert("올바른 이메일을 입력하세요.");
				return;
			}
			
			var form1 = document.createElement('form');
			var $form =  $('<form></form>');
			$form.attr('action', 'login_control.jsp');
			$form.attr('method', 'post');
			$form.css('visibility', 'hidden');
			$form.appendTo('body');
			
			var button_email_id = $('<input type="text" value="'+email.value+'" name="id_email" style="visibility:hidden;">');
			var button_password = $('<input type="password" value="'+password.value+'" name="password" style="visibility:hidden;">');
 
			$form.append(button_email_id).append(button_password);
			$form.submit();
		
			}
		function signup_submit(){
			location.href="./signup.jsp";
		}
		function signout_submit(){
			location.href="./sessionLogout.jsp";
		}
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
				<li><a href="./Projects.jsp">Projects</a></li>
				<li class="active"><a href="./Musics.jsp">Musics</a></li>
				
			<%
			if(session.getAttribute("nickname")==null){
			%>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<!--form id="form1" class="navbar-form navbar-right" method="post" action="login_control.jsp"-->
					<li>
						<input type="text" id="id_email_id" name="id_email" placeholder="Email" class="form-control">
					</li>
					<li>
						<input type="password" id="password" name="password" placeholder="Password" class="form-control">
					</li>
					<li>
						<button id="button_signin" type="button" class="btn btn-success" onclick="check_submit();">Sign in</button>
					</li>
					<li>
						<button onclick="signup_submit();" class="btn btn-primary" type="button">Sign up</button>
					</li>
			</ul>
				<!--/form-->
			<%}
			else{
			%>         
			</ul>
			
				<ul class="nav navbar-nav">
				<li class="form-group">
					<a href="./mypage.jsp">MyPage</a>
				</li>			
				</ul>
				
				<ul class="nav navbar-nav navbar-right">
				<!--form class="navbar-form navbar-right"-->
					<li class="form-group">
						<h4><font color="white"><%=session.getAttribute("nickname")%></font></h4>
					</li>
					<li class="form-group">
						<button onclick="signout_submit();" class="btn btn-success" type="button">Sign Out</a>
					</li>
				</ul>
				
				
			</ul>
			<%
			}
			%>
		</div>
		<!--/.navbar-collapse -->
	</div>
</div>
<div class="container">
	<div class="row row-offcanvas row-offcanvas-right">
		<div id="sidebar" class="col-xs-6 col-xs-3 sidebar-offcanvas" role="navigation">
			<div class="well sidebar-nav">
				<ul class="nav">
					<li> Category </li>
					<li class="active">
						<a href="#">Category1</a>
					</li>
					<li>
						<a href="#">Category2</a>
					</li>
					<li>
						<a href="#">Category3</a>
					</li>
					<li>
						<a href="#">Category4</a>
					</li>
					<li>
						<a href="#">Category5</a>
					</li>
					<li>
						<a href="#">Category6</a>
					</li>
					<li>
						<a href="#">Category7</a>
					</li>
					<li>
						<a href="#">Category8</a>
					</li>
					<li>
						<a href="#">Category9</a>
					</li>
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

	String sql="select * from musics";
	pstmt=conn.prepareStatement(sql);

	rs=pstmt.executeQuery();
	int i=0;
	while(rs.next()){
		int id=rs.getInt("id");
		Date date=rs.getDate("date");
		String music_path=rs.getString("music_path");
		String description=rs.getString("description");
		int play_cnt=rs.getInt("play_cnt");
		String name=rs.getString("name");
		int recording=rs.getInt("recording");
		%>

		<div class="col-xs-12 col-xs-9">
		<br>
				<div class="row">
					<a href="Edit.jsp?id="+<%=id %>><%=name%></a>
				</div>
				
				<div class="row">
					<small><%=description %></small>
				</div>
				<br>
			
				<div class="row">
					<a class="btn btn-default" href="#" role="button">Add to Music Cart</a>
					<a class="btn btn-default" href="#" role="button">Share</a>
					<a class="btn btn-default" href="#" role="button">▶ <%=play_cnt %></a>
				
				</div>
	</div>
		<!--
        /span
        -->	
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
	<!--
    /row
    -->
	<hr>
	</hr>
	<footer>
	<p>
		 © Company 2013
	</p>
	</footer>
</div>
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