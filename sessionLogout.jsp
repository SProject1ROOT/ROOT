<%@ page language="java" contentType="text/html; charset=utf-8" %>

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
<!-- Custom styles for this template -->
<link href="css/jumbotron.css" rel="stylesheet">
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="../../assets/js/html5shiv.js"></script>
      <script src="../../assets/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>


<% String back=(String)session.getAttribute("backpage");
if(back.equals("/mypage.jsp")){	back="/home.jsp";}
session.invalidate();%> 


<center>
    <div class="jumbotron">
      <div class="container">
        <h3>로그아웃 되었습니다.</h3>
        <a href=<%="."+back%> class="btn btn-primary btn-lg">이전 페이지</a></p>
      </div>
    </div>
</center>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>

