<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" %>

<html lang="en"><head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.png">

    <title>Signin Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/signin.css" rel="stylesheet">

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
		var password1 = document.getElementById("password1_id");
		var password2 = document.getElementById("password2_id");
		
		var pattern=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if(email==null||email.value.length<6){
			alert("올바른 이메일을 입력하세요.");
			return;
		}
		else if(!pattern.test(email.value)){
			alert("올바른 이메일을 입력하세요.");
			return;
		}
		
		if(password1.value != password2.value){
			alert("비밀번호가 같지 않습니다.");
			return;
		}
		else if(password1.value.length<8||password1.value.length>16){
			alert("비밀번호 길이는 8자리 이상 16자리 이하으로 입력하세요");
			return;
		}
		else if(!password1.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)){
			alert("비밀번호는 문자, 숫자, 특수문자의 조합이어야합니다.");
			return;
		}
		
		form.submit();
		
		
	}
	
	
	</script>
  </head>

  <body>

    <div class="container">

      <form id="form1" name="form1" class="form-signin" method="post" action="signup_control.jsp">
        <h2 class="form-signin-heading">Please sign up</h2>
        <input type="text" id="id_email_id" name="id_email" class="form-control" placeholder="Email address" autofocus="">
        <input type="text" id="nickname_id" name="nickname" class="form-control" placeholder="Nickname" autofocus="">
		<br>
		<span style="color:blue">비밀번호는 8자리 이상, 16자리 이하로 입력하세요. 비밀번호는 문자, 숫자, 특수문자 조합이어야합니다.</span>
        <input type="password" id="password1_id" name="password1" class="form-control" placeholder="Choose a password" autofocus="">
        <input type="password" id="password2_id" name="password2" class="form-control" placeholder="Re-type password">
        <!--button class="btn btn-lg btn-primary btn-block" type="submit">Sign up</button-->
		<button class="btn btn-lg btn-primary btn-block" type="button" onclick="check_submit();">Sign up</button>
      </form>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  

</body></html>