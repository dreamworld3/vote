<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.net.*"%>

<%request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
<meta charset="UTF-8">
<title>JDBCEx02</title>
</head>
<body>
<%
//通过http get方式接收一个参数，根据这个参数，模糊查询城市名，如果有，先把城市的信息通过html的table方式显示出来
//request.setCharacterEncoding("UTF-8"); 设置接收的参数的格式 ，用浏览器打开才可以传中文参数


Connection conn = null;
String sql;
String url = "jdbc:mysql://localhost:3306/ex17?"
           + "user=root&password=123456&useUnicode=true&characterEncoding=UTF8&useSSL=true";

try {
Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
%>

<%out.println("成功加载MySQL驱动程序<br/>");%>

<%     
    // 一个Connection代表一个数据库连接
    conn = DriverManager.getConnection(url);
    
    Statement stmt = conn.createStatement();    
     
        String name = request.getParameter("name"); 
        
        
	    sql = "select * from city where name Like '%"+ name +"%'";
        ResultSet rs = stmt.executeQuery(sql);// executeQuery会返回结果的集合，否则返回空值
if(name!=null && !name.equals("")){
       	       
	        
        	out.println("查询结果：<br/>");
	        if (rs.next()) {
	        	
	        	 rs.previous();
	        	 while (rs.next()) {
	        	  
	        	 
	        	 out.println("<table class='tab' border='1'>");
	             out.println("<tr>"
	             		+"<th align='left'>"+"id"+"</th>"+"<th align='left'>"+"city"+"</th>"+"<th align='left'>"+"describe"+"</th>"
	         			+"<th align='left'>"+"status"+"</th>"+"<th align='left'>"+"createdBy"+"</th>"
	         			+"<th align='left'>"+"createdTs"+"</th>"+"<th align='left'>"+"updateBy"+"</th>"
	         			+"<th align='left'>"+"updateTs"+"</th>"
	         			+"</tr>");
	         
	        	out.println("<tr>"
	        			+"<td align='left'>"+rs.getInt(1) + "</td>"+"<td align='left'>"+rs.getString(2)+"</td>"
	        			+"<td align='lr'>"+rs.getString(3)+"</td>"+"<td align='left'>"+rs.getString(4)+"</td>"    			
	        			+"<td align='left'>"+rs.getString(5)+"</td>"+"<td align='left'>"+rs.getString(6)+"</td>"    			
	        			+"<td align='left'>"+rs.getString(7)+"</td>"+"<td align='left'>"+rs.getString(8)+"</td>"    			   	    					    			   	    			
	        			);
	        	out.println("</tr>");
	        	out.println("</table>");
        	}
	        }else
		out.println("此城市不存在<br>");
	}
    out.println("</table>");
   stmt.close();
   
   conn.close();
    
} catch (SQLException e) {
    out.println("MySQL操作错误");
    e.printStackTrace();
    
} catch (Exception e) {
	out.println("MySQL操作错误");
    e.printStackTrace();
    
} finally {

 }

%>
</body>
</html>