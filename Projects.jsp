<%@ page contentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">
		<link rel="shortcut icon" href="../../assets/ico/favicon.png">

		<title>Projects</title>

		<!-- Bootstrap core CSS -->
		<link href="css/bootstrap.css" rel="stylesheet">
		<!--link href="css/non-responsive.css" rel="stylesheet"-->
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
			var form = document.getElementById("form1");
			var email = document.getElementById("id_email_id");
			var pattern=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
			if(email==null || email.value.length<6){
				alert("올바른 이메일을 입력하세요.");
				return;
			}
			else if(!pattern.test(email.value)){
				alert("올바른 이메일을 입력하세요.");
				return;
			}
			form.submit();
		
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
		<div id="sidebar" class="col-xs-6 col-sm-3 sidebar-offcanvas" role="navigation">
			<div class="well sidebar-nav">
				<ul class="nav">
					<li class="active">
						<a href="./Projects.jsp" type="button" class="btn btn-primary">New Projects</a>
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
		<div class="col-xs-12 col-sm-9">
		<br>
		<div class="col-lg-12">
			<div class="col-md-3">
				<img src="./image/ProjectNoImage.PNG" alt="Projects no image" class="img-rounded">
			</div>
			<div class="col-md-8">
				<div class="row">
					<h3>Projects1</h3>
				</div>
				<div class="row">
					<small>This is Project1.</small>
				</div>
				<br>
			
				<div class="row">
					<a class="btn btn-default" href="#" role="button">Likes</a>
					<a class="btn btn-default" href="#" role="button">Share</a>
					<a class="btn btn-default" href="#" role="button">▶</a>
					<a class="btn btn-default" href="#" role="button">♥</a>
				
				</div>
			</div>
		</div>
	</div>
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