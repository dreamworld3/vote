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
		out.println("ok");
		try {
			  
			 Class.forName("com.mysql.jdbc.Driver");
		   
		    conn = DriverManager.getConnection(url);	    
		    Statement stmt = conn.createStatement();
		    ResultSet rs;
		    int result=0;//result的值：判断输入的用户名是否已存在于数据表中，存在为1否则为0
		    String uName = request.getParameter("user_name");
			String uPasswd = request.getParameter("user_passwd");
			if(uName!=null && !uName.equals("") && uPasswd!=null && !uPasswd.equals("")){
				
				sql="select user_name from user_info where user_name = '"+uName+"'";				
				rs = stmt.executeQuery(sql);	
				
				if(rs.next()){	
					
					//JSONObject user = new JSONObject();					
					result=1;
					//传result的值
					out.println("{\"result\":" + result + "}");

				}
				else
				{	//JSONObject user = new JSONObject();
					sql="insert into user_info (user_name,user_passwd) values('"+uName+"','"+uPasswd+"')";
					stmt.executeUpdate(sql);
					result=0;
					out.println("{\"result\":" + result + "}");
					
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
