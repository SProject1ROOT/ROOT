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
		
	Connection conn = null;                                        // null로 초기화 한다.
	PreparedStatement pstmt = null;
	
	ResultSet rs=null;
		
		System.out.println("id : " + request.getParameter("project_id"));
	if(request.getParameter("project_id").equals("insert")){
	System.out.println("If 문");
				out.println("<script>alert('프로젝트 생성 필요');</script>");
				out.println("<script>history.go(-1);</script>");
	}
	else{
	
	int id=Integer.parseInt((String)request.getParameter("project_id"));

	//try{
		String db_url = "jdbc:mysql://210.118.74.213:3306/akmu";        // 사용하려는 데이터베이스명을 포함한 URL 기술
		String db_id = "akmu";                                                    // 사용자 계정
		String db_pw = "akmu0369";     

		Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		conn=DriverManager.getConnection(db_url,db_id,db_pw);
		
		
		String sql="select * from projects where id=?";
		pstmt=conn.prepareStatement(sql);
		
		pstmt.setInt(1, id);
		
		rs=pstmt.executeQuery();
		String image_path="";
		String description="";
		String name="";
		
		while(rs.next()){
			image_path=rs.getString("image_path");
			description=rs.getString("description");
			name=rs.getString("name");
		}
	%>
    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
      <div class="container" >
        <div class="col-xs-4">
			<h2><%=name %></h2>
			<img src=<%= image_path%> alt="Project_image" class="img-rounded"><br>
			<small><%=description %></small>
		</div>
		<div class="col-xs-4">
			<h2>History</h2>
		</div>
		<div class="col-xs-4">
			<h2>Comments</h2>
		</div>
	  </div>
    </div>


<%}%>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
