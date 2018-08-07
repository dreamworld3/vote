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
			 Class.forName("com.mysql.jdbc.Driver");//动态加载mysql驱动
		   
		    conn = DriverManager.getConnection(url);
		    
		    Statement stmt = conn.createStatement();    
		    int login_flag=0;//login_flag:用户密码都正确就置为1，否则置为0
			ResultSet rs;
			JSONObject user;
		        
		    String uName = request.getParameter("user_name");
			String uPasswd = request.getParameter("user_passwd");
			
			if(uName!=null && !uName.equals("")){
				
				sql="select user_passwd from user_info where user_name = '"+uName+"'";				
				rs = stmt.executeQuery(sql);	
				
				if(rs.next()){
					if(uPasswd.equals( rs.getString(1) ) )
					{
						/*sql="update user_info set login_flag = '1' where user_name = '"+uName+"'";
						stmt.executeUpdate(sql);
						*/
						login_flag=1;
						//out.println("{\"login_flag\":" + login_flag + "}");
						
						sql="select user_name from user_info where user_name = '"+uName+"'";						
						rs = stmt.executeQuery(sql);	
						rs.next();
						
						user = new JSONObject();
						user.put("user_name", rs.getString(1));
						
						user.put("login_flag", login_flag);
						out.print(user);
						out.flush();
						
						
					}
				
				else
				{
						login_flag=0;
						out.println("{\"login_flag\":" + login_flag + "}");
				
				}
				
			}
			else
			{
					login_flag=0;
					out.println("{\"login_flag\":" + login_flag + "}");
			
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
