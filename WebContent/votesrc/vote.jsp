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
		    ResultSet rs ;
		     
		    int vId = Integer.parseInt(request.getParameter("id"));
		    String uName = request.getParameter("user_name");
		    //String uName = new String(request.getParameter("user_name").getBytes("ISO-8859-1"),"UTF-8"); 
		    JSONObject vote = new JSONObject();
		    
		    sql = "select vote_flag from user_info where user_name = '" + uName + "'" ;
			rs = stmt.executeQuery(sql);
			 
			
			if(rs.next())
		    {
				if(!("1".equals(rs.getString(1))))
				{
					vote.put("vote_flag",rs.getString(1));				    	
				    out.print(vote);
				    out.flush();
					sql = "select vote_sum from vote_info where id = " + vId ;
					rs = stmt.executeQuery(sql);
					
					rs.next();
					
					String sum = rs.getString(1);
					long newsum = Integer.parseInt(sum);
					newsum++;
					sum=String.valueOf(newsum);
					
							
					sql = "update vote_info set vote_sum = '"+ sum + "' where id = " + vId;
					stmt.executeUpdate(sql);
					
					sql = "update user_info set vote_flag = '1' where user_name = '"+ uName + "'" ;
					stmt.executeUpdate(sql);
					
					
				}
				else
				{
				    				    	
				    	vote.put("vote_flag",rs.getString(1));				    	
					    out.print(vote);
					    out.flush();
				}
		    }
	 		stmt.close();
	        
	        conn.close();
	         
	     } catch (SQLException e) {
	         out.println("MySQL操作错误");
	         e.printStackTrace();
	         
	     } catch (Exception e) {
	         e.printStackTrace();
	         
	     }
%>
