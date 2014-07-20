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

    <title>Home</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/non-responsive.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="css/jumbotron.css" rel="stylesheet">
  </head>

  <body>
	<%session.setAttribute("backpage",request.getRequestURI());%>

	<%
			if(session.getAttribute("nickname")==null){
				out.println("<script>alert('로그인 해주세요.');</script>");
				out.println("<script>history.go(-1);</script>");
			}
		
		
	%>
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
