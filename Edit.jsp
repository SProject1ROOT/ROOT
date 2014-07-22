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
	<script src="/js/ajax.js"></script>
	<script>
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

window.onload=function(){
	loadCommentList();
}
function loadCommentList(){
	new ajax.xhr.Request("commentlist.jsp","",loadCommentResult,'GET');
}
function loadCommentResult(req){
	if(req.readyState==4){
		if(req.status==200){
			var xmlDoc=req.responseXML;
			var code=xmlDoc.getElementsByTagName('code').item(0).firstChild.nodeValue;
			if(code=='success'){
				var commentList=eval("("+xmlDoc.getElementsByTagName('data').item(0).firstChild.nodeValue+")");
				
				var listDiv=document.getElementById('commentList');
				for(var i =0;i<commentList.length;i++){
					var commentDiv=makeCommentView(commentList[i]);
					listDiv.appendChild(commentDiv);
				}
			}
			else if(code=='error'){
				var message=xmlDoc.getElementsByTagName('message').item(0).firstChild.nodeValue;
				alert("에러 발생 : "+message);
			}
			else{
				alert("댓글 목록 로딩 실패 : "+req.status);
			}
		}
	}
}

function makeCommentView(comment){
	var commentDiv=document.createElement('div');
	commentDiv.setAttribute('id','c'+comment.id);
	var html='<strong>'+comment.id+'</strong><br/>'+comment.date+'<br/>'+comment.comment+'<br/>';
	
	commentDiv.innerHTML=html;
	commentDiv.comment=comment;
	commentDiv.className="comment";
	return commentDiv;
	
}


function sendSNS(){
 var str_href;
 var str_u = location.href;
 // 타이틀 태그 안에 > 로 depth표시가 되어 있기 때문에 replace
 var str_t = $("title").html().replaceAll(" &gt; ", ">");
 
 $("#sns_facebook").click(function(){
  str_href = $(this).attr("href");
  $(this).attr("href", str_href + "?u=" + encodeURIComponent(str_u) + "&t=" + encodeURIComponent(str_t));
 });
 $("#sns_twitter").click(function(){
  str_href = $(this).attr("href");
  $(this).attr("href", str_href + "?url=" + encodeURIComponent(str_u) + "&text=" + encodeURIComponent(str_t));
 });
 $("#sns_me2day").click(function(){
  str_href = $(this).attr("href");
  str_t = '"' + str_t + '"';
  $(this).attr("href", str_href + "?new_post[body]=" + encodeURIComponent(str_t) + ":" + encodeURIComponent(str_u));
 });
}

	</script>
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
    <div class="jumbotron" align="center">
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
			<div id="commentAdd">
				<form action="" name="addForm">
				<ul class="nav navbar-nav">
				<li><img src=<%=(String)session.getAttribute("image")%> alt="profile_image" class="img-rounded" onload="image_auto_resize(this,35,35)";></li>
				<li><input type="text" id="id_email_id" name="id_email" placeholder="댓글을 입력하세요..." class="form-control"></li>
				<li><input type="button" value="등록" class="btn btn-primary" onclick="addComment()"/></li>
				</ul>
				</form>
				</div>
				
		</div>
	  </div>
	  <a target="blank" id="sns_facebook" href="http://www.facebook.com/share.php" title="페이스북에 이 페이지 공유하기"  class="btn btn-default">Facebook Share</a>
	  <a target="blank" id="sns_facebook" href="http://www.facebook.com/share.php" title="페이스북에 이 페이지 공유하기"  class="btn btn-default">Facebook Share</a>
	  <a target="blank" id="sns_facebook" href="http://www.facebook.com/share.php" title="페이스북에 이 페이지 공유하기"  class="btn btn-default">Facebook Share</a>
    </div>
	
					


<%}%>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
