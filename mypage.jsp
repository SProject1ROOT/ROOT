<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<!--meta name="viewport" content="width=device-width, initial-scale=1.0"-->
<meta name="description" content="">
<meta name="author" content="">


<meta http-equiv="Cache-Control" content="no-cache"/> 
<meta http-equiv="Expires" content="0"/> 
<meta http-equiv="Pragma" content="no-cache"/>

<link rel="shortcut icon" href="../../assets/ico/favicon.png">
<title>Projects</title>
<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="css/jumbotron.css" rel="stylesheet">
<link href="css/non-responsive.css" rel="stylesheet">
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
			$form.attr('target', 'iFrm');
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
	<% 
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache"); 
 response.setDateHeader("Expires",0);
%>

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
				<li><a href="./Musics.jsp">Musics</a></li>
				
			<%
			if(session.getAttribute("nickname")==null){
				out.println("<script>alert('잘못된 접근입니다');</script>");
				out.println("<script>history.go(-1);</script>");
			}
			else{
			%>         
			</ul>
			
				<ul class="nav navbar-nav">
				<li class="form-group active"">
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
		<div id="sidebar" class="col-xs-6 col-xs-2 sidebar-offcanvas" role="navigation">
			<div class="well sidebar-nav"  style="display: inline-block;text-align: center;">
				<ul class="nav">
					<li> <h2>Profile</h2> </li>
					<li class="active">
						<img src=<%=session.getAttribute("image") %> alt="user image" class="img-rounded" onload="image_auto_resize(this,130,130);" >
					</li>
					<li>
						<p class="lead"><%=session.getAttribute("nickname")%></p>
						<p><a class="btn btn-lg btn-success" href="#">Level <%=session.getAttribute("level") %></a></p>
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

//try{
	String db_url = "jdbc:mysql://210.118.74.213:3306/akmu";        // 사용하려는 데이터베이스명을 포함한 URL 기술
	String db_id = "akmu";                                                    // 사용자 계정
	String db_pw = "akmu0369";                                                // 사용자 계정의 패스워드

	Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(db_url,db_id,db_pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
%>
		<div class="col-xs-12 col-xs-9">
    <div class="col-xs-4"  style="display: inline-block;text-align: center;">
        <h2>
            My Projects
        </h2>
		<%  
			String sql="select projects.id, projects.image_path from projects,users_projects where users_projects.user_id=? and users_projects.project_id=projects.id";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,(String)session.getAttribute("uid"));
			
			rs=pstmt.executeQuery();
			while(rs.next()){
				int project_id=rs.getInt("id");
				String image_path=rs.getString("image_path");
		%>
        <p>
            <a class="btn btn-default" href="Edit.jsp?project_id=<%=project_id%>">
                <img src=<%=image_path %> alt="Project_image" class="img-rounded" onload="image_auto_resize(this,130,130);" >
            </a>
        </p>
		
		<% }%>
    </div>
	<div class="col-xs-4"  style="display: inline-block;text-align: center;">
        <h2>
            My Musics
        </h2>
		<%  
			sql="select name, id from musics where user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,(String)session.getAttribute("uid"));
			
			rs=pstmt.executeQuery();
			while(rs.next()){
				int id=rs.getInt("id");
				String name=rs.getString("name");
		%>
        <p>
			<!--button type="button" class="btn btn-default btn-lg"><%=name%></button-->
                <a class="btn btn-default btn-block" href="#?id=<%=id%>" role="button"><%=name%></a>
        </p>
		<% }%>
    </div>
    <div class="col-xs-4"  style="display: inline-block;text-align: center;">
        <h2>
            Bookmarks
        </h2>
		<%  
			sql="select musics.id, musics.name from musics,users_bookmark where users_bookmark.user_id=? and users_bookmark.music_id = musics.id";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,(String)session.getAttribute("uid"));
			
			rs=pstmt.executeQuery();
			while(rs.next()){
				int id=rs.getInt("id");
				String name=rs.getString("name");
		%>
        <p>
            <a class="btn btn-default btn-block" href="#?id=<%=id%>" role="button"><%=name%></a>
       
        </p>
		<% }%>
    </div>

		</div>
		<!--
        /span
        -->
	</div>
	<!--
    /row
    -->
	<hr>
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