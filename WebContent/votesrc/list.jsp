<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="org.json.JSONObject"%>

<% request.setCharacterEncoding("UTF-8"); %>

<%response.setHeader("Access-Control-Allow-Methods", "OPTIONS,POST,GET");%>
<%response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");%>
<%response.setHeader("Access-Control-Allow-Origin", "*");%>

<%
		Connection conn = null;
		String sql;

		String url = "jdbc:mysql://localhost:3306/votesql?"
		           + "user=root&password=123456&useUnicode=true&characterEncoding=UTF8&useSSL=true";
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
		    
		    conn = DriverManager.getConnection(url);		    
		    Statement stmt = conn.createStatement();  
			
		    sql = "select * from vote_info ";
		    ResultSet rs = stmt.executeQuery(sql);
		    
		    JSONObject voteListJson = new JSONObject();
		    List voteList = new ArrayList();
		    
		    while(rs.next()){
		    	
		    	JSONObject vote = new JSONObject();
		    	vote.put("id",rs.getString(1));
		    	vote.put("vote_name",rs.getString(2));
		    	vote.put("vote_sum",rs.getString(4));
		    	voteList.add(vote);
		    }
		    voteListJson.put("votes", voteList);
		    out.print(voteListJson);
		    out.flush();
			
	 		stmt.close();	        
	        conn.close();
	         
	     } catch (SQLException e) {
	         out.println("MySQL操作错误");
	         e.printStackTrace();
	         
	     } catch (Exception e) {
	         e.printStackTrace();
	         
	     }
%>
