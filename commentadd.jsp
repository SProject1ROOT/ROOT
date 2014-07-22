<?xml version="1.0" encoding="euc-kr" ?>
<%@ page contentType="text/xml; charset=euc-kr" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "util.Util" %>
<%@ page import = "util.DB" %>

<%
	request.setCharacterEncoding("utf-8");
	int id=0;
	String comment = request.getParameter("comment");
	int project_id = Integer.parseInt((String)request.getParameter("project_id"));
	int user_id=Integer.parseInt((String)session.getAttribute("uid"));
	
	java.util.Date now=new java.util.Date();
	Date now_date=new Date(now.getTime());
	
	System.out.println("comment : "+comment);
	System.out.println("project_id : "+project_id);
	System.out.println("user_id : "+user_id);
	System.out.println("now : "+now.toString());
	System.out.println("now_date : "+now_date.toString());
		
	Connection conn = null;                                        // null로 초기화 한다.
	PreparedStatement pstmt = null;
	ResultSet rs=null;
		
	try {
	
		String db_url = "jdbc:mysql://210.118.74.213:3306/akmu";        // 사용하려는 데이터베이스명을 포함한 URL 기술
		String db_id = "akmu";                                                    // 사용자 계정
		String db_pw = "akmu0369";
	
		Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		conn=DriverManager.getConnection(db_url,db_id,db_pw); 
		conn.setAutoCommit(false);
		
		String sql="insert into project_comment(project_id,date,comment,user_id) values(?,?,?,?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1,project_id);
		pstmt.setDate(2,now_date);
		pstmt.setString(3,comment);
		pstmt.setInt(4,user_id);
	
		pstmt.executeUpdate();
		
		sql="select last_insert_id()";
		pstmt=conn.prepareStatement(sql);

		rs=pstmt.executeQuery();
		if(rs.next()){
			id=rs.getInt(1);
		}
		
		System.out.println("comment id : "+id);
		conn.commit();
%>
<result>
	<code>success</code>
	<data><![CDATA[
	{
		id: <%= id %>,
		image: '<%= Util.toJS((String)session.getAttribute("image"))%>',
		email: '<%= Util.toJS((String)session.getAttribute("email"))%>',
		nickname: '<%= Util.toJS((String)session.getAttribute("nickname"))%>',
		date: '<%= Util.toJS(now_date.toString()) %>',
		comment: '<%= Util.toJS(comment) %>'
	}
	]]></data>
</result>
<%
	} catch(Throwable e) {
		e.printStackTrace();
		try { if( conn != null ) conn.rollback(); } catch(SQLException ex) {}
%>
<result>
	<code>error</code>
	<message><![CDATA[<%= e.getMessage() %>]]></message>
</result>
<%
	} finally {
		if (rs != null) 
			try { rs.close(); } catch(SQLException ex) {}
		if (pstmt != null) 
			try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try {
			conn.setAutoCommit(true);
			conn.close();
		} catch(SQLException ex) {}
	}
%>
