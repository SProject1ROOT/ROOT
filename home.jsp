<%@ page contentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <!--meta name="viewport" content="width=device-width, initial-scale=1.0"-->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.png">

    <title>Home</title>

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
            <li class="active"><a href="./home.jsp">Home</a></li>
            <li><a href="./Projects.jsp">Projects</a></li>
            <li><a href="./Musics.jsp">Musics</a></li>
          
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
						<button onclick="signout_submit();" class="btn btn-success" type="button">Sign Out</button>
					</li>
				</ul>
				<!--/form-->	
				
			</ul>
			<%
			}
			%>
			</div>
        </div><!--/.navbar-collapse -->
      </div>
    </div>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
      <div class="container">
        <h1>樂動뮤직</h1>
        <p>다양한 음원 병합 및 공유 기능을 제공하며,
		별도의 다운로드 및 설치없이 웹 상에서 사용가능 하도록 제공합니다.</p>
        <p><a class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
      </div>
    </div>

    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-xs-4">
          <h2>Projects</h2>
          <p>음원 병합을 진행하는 프로젝트 목록 열람과 음원 재생이 가능한 페이지입니다.</p>
          <p><a class="btn btn-default" href="#">View details &raquo;</a></p>
        </div>
        <div class="col-xs-4">
          <h2>Musics</h2>
          <p>프로젝트에 사용되는 음원 목록 열람 및 재생 가능한 페이지입니다.</p>
          <p><a class="btn btn-default" href="#">View details &raquo;</a></p>
       </div>
        <div class="col-xs-4">
          <h2>MyPage</h2>
          <p>내가 참여한 프로젝트 목록, 재생했었던 음원 리스트 및 관심있는 음원을 볼 수 있는 페이지입니다.</p>
          <p><a class="btn btn-default" href="#">View details &raquo;</a></p>
        </div>
      </div>
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
