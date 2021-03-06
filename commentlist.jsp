<%@ page language="java" contentType="text/xml; charset=UTF8" pageEncoding="UTF8" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "util.DB" %>
<%@ page import = "util.Util" %>
<%
			
Connection conn = null;                                        // null로 초기화 한다.
PreparedStatement pstmt = null;
ResultSet rs=null;

try{
	String db_url = "jdbc:mysql://210.118.74.213:3306/akmu";        // 사용하려는 데이터베이스명을 포함한 URL 기술
	String db_id = "akmu";                                                    // 사용자 계정
	String db_pw = "akmu0369";                                                // 사용자 계정의 패스워드

	Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(db_url,db_id,db_pw); 
	
	String sql="select * from users, project_comment where project_comment.project_id=? and project_comment.user_id=users.uid order by date asc";

	int project_id=Integer.parseInt((String)request.getParameter("project_id"));
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,project_id);
	rs=pstmt.executeQuery();
	
%>
	<result>
		<code>success</code>
		<data><![CDATA[
		[
<%
	if(rs.next()){
		do{
			if(rs.getRow()>1){
%>
		,
<%
		}
%>
	{
		id: <%=rs.getInt("id")%>,
		email: '<%=Util.toJS(rs.getString("email"))%>',
		nickname: '<%=Util.toJS(rs.getString("nickname"))%>',
		image: '<%=Util.toJS(rs.getString("image"))%>',
		date: '<%=Util.toJS(rs.getTimestamp("date").toString())%>',
		comment: '<%=Util.toJS(rs.getString("comment"))%>'
	}
<%
	}while(rs.next());
}
%>
]
]]></data>
</result>
<%
}catch(Throwable e){
	out.clearBuffer();
%>
<result>
	<code>error</code>
	<message><![CDATA[<%=e.getMessage()%>]]></message>
</result>
<%
	}finally{
	
	if(rs!=null) try{rs.close();}catch(SQLException ex){}
	if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
	if(conn!=null) try{conn.close();}catch(SQLException ex){}
}
%>