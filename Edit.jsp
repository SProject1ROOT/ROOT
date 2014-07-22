<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "web.bean.Musics" %>

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
	
	<script type="text/javascript" src="/js/buffer_loader.js"></script>
	<script type="text/javascript" src="/js/make_element.js"></script>
<script type="text/javascript">
window.onload = function() {
	document.body.onkeyup = function(event){
		event = event || window.event;
		var keycode = event.charCode || event.keyCode;
		if(keycode == 32)
		{
			Player.Play();
		}
	}
}

 

var context;
var isPlaying = false;
//var pos = 0;
var startOffset = 0;
var startTime = 0;
var timer;
var playStartTime;

var AudioDataList = new Array();
function AudioData(filename, ab, w, s, v)
{
	this.filename = filename.substring(filename.lastIndexOf("/")+1, filename.length);
	this.audioBuffer = ab;
	this.startPos = s;
	this.volume = v;
	this.duration = ab.duration;
	this.width = w;
	
	this.playingBS = null;
	this.gainNode = null;
	this.playing = false;
}

var Player = new AudioPlayer();
function AudioPlayer()
{
	this.pos = 0;	// current position
	this.dragdrop_pos = -1;
	this.new_pos = 0;	// temp position
	this.currentId = "";
	this.total_width = 1000;
	
	this.total_length = 1000;
	this.total_seconds = 240;
}
AudioPlayer.prototype.Play = function() {
	if(isPlaying == false)
	{
		startTime = context.currentTime;
		playStartTime = new Date().getMilliseconds();
		isPlaying = true;
		
		// Setting
		for (var i = 0; i < AudioDataList.length; i++)
		{
			AudioDataList[i].gainNode = context.createGain();
			
			AudioDataList[i].playingBS = context.createBufferSource();
			AudioDataList[i].playingBS.buffer = AudioDataList[i].audioBuffer;					
			AudioDataList[i].playingBS.connect(AudioDataList[i].gainNode);
			
			AudioDataList[i].gainNode.connect(context.destination);
		}
		
		// Play
		
		for (var i = 0; i < AudioDataList.length; i++)
		{
			if( Player.pos == AudioDataList[i].startPos ) {
				AudioDataList[i].playingBS.start(0);
				
			} else if(Player.pos - AudioDataList[i].startPos < 0) {
				
				var whenStart = context.currentTime + (AudioDataList[i].startPos - Player.pos) / Player.total_length * Player.total_seconds;
				
				console.log("whenStart : " + whenStart);
				AudioDataList[i].playingBS.start(whenStart);
			
			} else
			if(Player.pos - AudioDataList[i].startPos > 0 && AudioDataList[i].startPos + AudioDataList[i].width > Player.pos ) {
				var offSet = (Player.pos - AudioDataList[i].startPos) / Player.total_length * Player.total_seconds;
				AudioDataList[i].playingBS.start(0, offSet);
				
				console.log("offSet : " + offSet);
			} else {
				AudioDataList[i].playingBS = null;
			}
		}
		
		document.getElementById('wavedisplay_play').style.zIndex = 100;
		timer = window.setInterval("drawCanvasPlayBar()", 50);
	}
	else
	{
		// Stop
		for (var i = 0; i < AudioDataList.length; i++)
		{
			if( AudioDataList[i].playingBS != null)
			{
				AudioDataList[i].playingBS.stop(0);
				AudioDataList[i].playingBS.disconnect();
				AudioDataList[i].playingBS = null;
				
				AudioDataList[i].gainNode.disconnect();
			}
		}
		
		startOffset += context.currentTime - startTime;
		
		isPlaying = false;
		
		window.clearInterval(timer);
		drawCanvasPlayBar();
		
		document.getElementById('wavedisplay_play').style.zIndex = 0;
	}
}

var arr_audio;
function init() {

	// Fix up prefixing
	window.AudioContext = window.AudioContext || window.webkitAudioContext;
	context = new AudioContext();

	//var arr_audio = ['/audio/home.mp3', '/audio/cannonball.mp3'];
	var bufferLoader = new BufferLoader(
		context,
		arr_audio,
		function(bufferList){
			for (var i = 0; i < bufferList.length; i++) {
				
				var width = bufferList[i].duration / Player.total_seconds * Player.total_width;
				if( width > Player.total_width )
				{
					Player.total_width = width;
					document.getElementById('wavedisplay_play').width = width;
				}
				
				AudioDataList[i] = new AudioData(arr_audio[i], bufferList[i], width, 0, 0);
				makeMusicCanvas(i, 100, width);
			}
			drawCanvasWave();
		}
	);

	bufferLoader.load(); 
}

function drawCanvasPlayBar()
{
	var canvas = document.getElementById('wavedisplay_play');
	var ctx = canvas.getContext('2d');
	ctx.clearRect(0, 0, canvas.width, canvas.height);
	
	if( isPlaying ) { 
		new_pos = Player.pos + ((context.currentTime - startTime) / Player.total_seconds * Player.total_length);
		console.log("context.currentTime:" + context.currentTime + ", startTime:" + startTime + ", pos:" + Player.pos + ", new_pos:" + new_pos);
		
		ctx.beginPath();
		ctx.lineWidth = 1;
		ctx.moveTo(new_pos, 0);
		ctx.lineTo(new_pos, 0);
		ctx.lineTo(new_pos, canvas.height);
		
		ctx.strokeStyle = "#ff0000";
		ctx.stroke();
	}
}

function drawCanvasWave() {
	
	for (var a = 0; a < AudioDataList.length; a++)
	{
		var canvas = document.getElementById("wavedisplay" + (a));
		var ctx = canvas.getContext("2d");
	
		var width = canvas.width;
		var height = canvas.height - 20;
		var data = AudioDataList[a].audioBuffer.getChannelData(0);
		var step = Math.ceil( data.length / width );
		var amp = height / 2;
		
		//ctx.fillStyle = "#333366";
		ctx.fillStyle = "silver";
		ctx.clearRect(0,0,width,height);
		for(var i=0; i < width; i++){
			var min = 1.0;
			var max = -1.0;
			for (j=0; j<step; j++) {
				var datum = data[(i*step)+j]; 
				if (datum < min)
					min = datum;
				if (datum > max)
					max = datum;
			}
			ctx.fillRect(i,(1+min)*amp+20,1,Math.max(1,(max-min)*amp));
			//ctx.fillRect(i,(1+min)*amp,1,Math.max(1,(max-min)*amp));
			//console.log(i + ", " + (0+min)*amp + ", " + 1 + ", " + Math.max(1,(max-min)*amp));
		}
		
		ctx.fillStyle = "#333366";
		ctx.fillRect(0, 0, width, 20);
		
		ctx.fillStyle = "white";
		ctx.font = 'bold 12px consolas';
		ctx.textBaseline = 'bottom';
		ctx.fillText(AudioDataList[a].filename, 8, 17);
	}
	
	
	
}

function test()
{
	var canvas = document.getElementById('wavedisplay_play');
	var ctx = canvas.getContext('2d');
	ctx.clearRect(0, 0, canvas.width, canvas.height);
	
	//if( isPlaying ) { 
		new_pos = Player.pos + ((context.currentTime - startTime) / Player.total_seconds * Player.total_length);
		console.log("context.currentTime:" + context.currentTime + ", startTime:" + startTime + ", pos:" + Player.pos + ", new_pos:" + new_pos);
		
		new_pos = 0;
		
		ctx.beginPath();
		ctx.lineWidth = 1;
		ctx.moveTo(new_pos, 0);
		ctx.lineTo(new_pos, 0);
		ctx.lineTo(new_pos, canvas.height);
		
		ctx.strokeStyle = "#ff0000";
		ctx.stroke();
	//}
}

function zoomin()
{
	Player.total_seconds = Player.total_seconds / 2;
	for (var i = 0; i < AudioDataList.length; i++) {
		var width = AudioDataList[i].duration / Player.total_seconds * Player.total_width;
		if( width > Player.total_width )
		{
			Player.total_width = width;
			document.getElementById('wavedisplay_play').width = width;
		}
		
		AudioDataList[i].width = width;
		document.getElementById("wavedisplay" + i).width = width;
	}
	drawCanvasWave();
}

function zoomout()
{
	Player.total_seconds = Player.total_seconds * 2;
	for (var i = 0; i < AudioDataList.length; i++) {
		var width = AudioDataList[i].duration / Player.total_seconds * Player.total_width;
		if( width > Player.total_width )
		{
			Player.total_width = width;
			document.getElementById('wavedisplay_play').width = width;
		}
		
		AudioDataList[i].width = width;
		document.getElementById("wavedisplay" + i).width = width;
	}
	drawCanvasWave();
}

function changeVolume0(element)
{
	var volume = element.value;
	var fraction = parseInt(element.value) / parseInt(element.max);
	AudioDataList[0].gainNode.gain.value = fraction * fraction;
}

function changeVolume1(element)
{
	var volume = element.value;
	var fraction = parseInt(element.value) / parseInt(element.max);
	AudioDataList[1].gainNode.gain.value = fraction * fraction;
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


<%
// JAVA
Connection conn = null;                                        // null로 초기화 한다.
PreparedStatement pstmt = null;
ResultSet rs=null;
	
String pid = request.getParameter("project_id");
if( pid == null || pid == "" ) return;

// Project Data
String image_path="";
String description="";
String name="";

// Music of Project Data
ArrayList<Musics> music_list = new ArrayList<Musics>();

ArrayList<String> list_string = new ArrayList<String>();



int n_project_id = Integer.parseInt((String)request.getParameter("project_id"));

String db_url = "jdbc:mysql://210.118.74.213:3306/akmu";        // 사용하려는 데이터베이스명을 포함한 URL 기술
String db_id = "akmu";                                                    // 사용자 계정
String db_pw = "akmu0369";     
try {
	Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn = DriverManager.getConnection(db_url,db_id,db_pw);

	String sql="select * from projects where id=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setInt(1, n_project_id);
	
	rs=pstmt.executeQuery();
	while(rs.next()){
		image_path=rs.getString("image_path");
		description=rs.getString("description");
		name=rs.getString("name");
	}
	
	
	sql="select musics.id, musics.name, musics.user_id, musics.date, musics.music_path, musics.description, musics.recording, musics.play_cnt from projects_musics, musics where projects_musics.project_id=? and musics.id=projects_musics.music_id;";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, n_project_id);
	
	rs=pstmt.executeQuery();
	while(rs.next()){
		
		Musics musics = new Musics();
		musics.setId(rs.getInt("id"));
		musics.setName(rs.getString("name"));
		musics.setUser_id(rs.getString("user_id"));
		musics.setDate(rs.getDate("date"));
		musics.setMusic_path(rs.getString("music_path"));
		musics.setDescription(rs.getString("description"));
		musics.setRecording(rs.getInt("recording"));
		musics.setPlay_cnt(rs.getInt("play_cnt"));
		music_list.add(musics);
		
		list_string.add(musics.getName());
		
		System.out.println("musics.id : " + musics.getId());		
	}
	
} catch(Exception e) {
	e.printStackTrace();
} finally {
	if( conn != null ) conn.close();
	if( pstmt != null ) pstmt.close();
}
%>
<script type="text/javascript">
	arr_audio = new Array();
	<% for(Musics music:music_list) { %>
		arr_audio.push('<%=music.getMusic_path()%>');
	<% } %>
	init();
</script>
  </head>

  <body>
	<!-- Main jumbotron for a primary marketing message or call to action -->
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
						<input type="text" id="id_email_id" name="id_email" placeholder="Email">
					</li>
					<li>
						<input type="password" id="password" name="password" placeholder="Password">
					</li>
					<li>
						<button id="button_signin" type="button" class="btn btn-success" onclick="check_submit();">Sign in</button>
					</li>
					<li>
						<button onclick="signup_submit();" class="btn btn-primary" type="button">Sign up</button>
					</li>
			</ul>
				<!--/form-->
			<%
			}else{
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
	
	
	<!-- container -->
	<div class="container" style="width:1200px;">
		<div class="col-xs-12">
			<div class="col-xs-2" height="200px">
				<br>
				<img src="<%=image_path%>" alt="Project_image" class="img-rounded" onload="image_auto_resize(this, 180, 150);"><br>
			</div>
			<div class="col-xs-10">
				<h2><%=name%></h2>
				<h4><%=description%></h4>
			</div>
			<div class="col-xs-10">
				<hr>
				<button type="button" class="btn btn-default btn-lg">
					<span class="glyphicon glyphicon-plus"></span>
				</button>
				<button type="button" class="btn btn-default btn-lg">
					<span class="glyphicon glyphicon-record"></span>
				</button>
				<button type="button" class="btn btn-default btn-lg">
					<span class="glyphicon glyphicon-trash"></span>
				</button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-default btn-lg">
					<span class="glyphicon glyphicon-play"></span>
				</button>
				<button type="button" class="btn btn-default btn-lg">
					<span class="glyphicon glyphicon-stop"></span>
				</button>
				
				<hr>
			</div>
		</div>
		<div class="col-xs-2">
			<c:forEach var="music" items="${list_string}" varStatus="status">
			<div style="height:100px;">
				${music}
				<input type="checkbox" >
				<input type="range" min="0" max="100" value="100" oninput="changeVolume0(this);">
			</div>
			</c:forEach>
		</div>
		
		<div class="col-xs-8">
			<div id="canvas_container" style="position: relative; float: left; width: 1005px; height:350px; overflow-x:scroll; " >		
				<canvas id="wavedisplay_play" height="300" width="1000" style="position: absolute; left: 0; top: 0; z-index: 0; background:transparent; border:1px solid silver;"></canvas>
				<canvas id="playbar" height="80" width="1" style="position: absolute; left: 10; top: 0; z-index: 1000; background-color: #ff0000; visibility: hidden;" ></canvas>
			</div>
		</div>
	</div

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
