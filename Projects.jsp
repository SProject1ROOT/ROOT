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
				function image_auto_resize(this_s,width,height){ 
 var ta_image = new Image(); 
 ta_image.src = this_s.src; 
  if(!width){this_s.removeAttribute('width'); 
  this_s.style.width='auto';} 
  else if(width < ta_image.width){ 
  this_s.width = width; 
  }else{ 
  this_s.width = ta_image.width; 
  } 
  if(!height){this_s.removeAttribute('height'); 
  this_s.style.height='auto';} 
  else if(height < ta_image.height){ 
  this_s.height = height; 
  }else{ 
  this_s.height = ta_image.height; 
  } 
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
				<li class="active"><a href="./Projects.jsp">Projects</a></li>
				<li><a href="./Musics.jsp">Musics</a></li>
			
			<%
			if(session.getAttribute("nickname")==null){
			%>
         <!--form id="form1" class="navbar-form navbar-right" method="post" action="login_control.jsp"-->
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
	</div>
</div>
<div class="container">
	<div class="row row-offcanvas row-offcanvas-right">
		<div id="sidebar" class="col-xs-6 col-xs-3 sidebar-offcanvas" role="navigation">
			<div class="well sidebar-nav">
				<ul class="nav">
					<li class="active">
						<a href="./Edit.jsp?project_id=insert" type="button" class="btn btn-primary">New Projects</a>
					</li>
					<li>
						<br>
						<img src="./image/ProjectIntro.PNG" alt="Projects Intro image" class="img-rounded" onload="image_auto_resize(this,170,130);" >
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
		int likes=rs.getInt("likes");
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
				<img src=<%=image_path %> alt="Projects no image" class="img-rounded" onload="image_auto_resize(this,130,130);" >
			</div>
			<div class="col-xs-4 navbar-collapse collapse">
			
				<ul class="nav navbar-nav">
					<a href="Edit.jsp?project_id=<%=id%>"><%=name%></a>
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
					<li><a class="btn btn-default" href="#" role="button">♥ <%=likes %></a></li>
				
				</ul>
			</div>
		</div>
	</div>
		
		<%
		
		/*
		out.println(i+"---------------------------------");
		out.println("id = "+id);
		out.println("likes = "+likes);
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