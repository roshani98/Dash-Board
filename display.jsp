<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.net.InetAddress" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>

a{
	color:#757575;
	margin-left:35%;
	border:1px solid #757575;
	border-radius:50px 20px;
	padding:25px;
}
a:link{
	text-decoration:none;
	font-size:50px;
	text-align:center;
}
a:hover{
	text-decoration:underline;
}

#block1 {
	margin-top:100px;
}

#block2 {
	margin-top:100px;
}

#block3 {
	margin-top:100px;
}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
	String appname = request.getParameter("appname");
	String queueValues[] = request.getParameterValues("select2");
	System.out.println(appname);
	String checkBox[] = request.getParameterValues("names");
	String hostAddr = request.getParameter("hostAddr");
	String portNo = request.getParameter("portNo");
	String hostname = hostAddr +":"+portNo ;

	for(int i=0;i<checkBox.length;i++)
	{
		System.out.println(checkBox[i]);
	}

	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@10.10.9.53:1521:SIR14894","LMS_ODS_CT","LMS_ODS_CT");
		Statement s = con.createStatement();
		int flag = 1,flag1 = 0;

		String queue = "Queue";
		char val = 'Y';
		for(int i = 0;i<queueValues.length;i++)
		{
			int	j = s.executeUpdate("insert into ROSHANI(appname,TYPE_MBEAN,KEY,VALUE,HOSTNAME) VALUES('"+appname+"','"+queue+"','"+queueValues[i]+"','"+val+"','"+hostname+"')");
			if(j>0){
			 	continue;
			}
			else{
				flag = 0;
				break;
			}
		}

		for(int i = 0;i<checkBox.length;i++)
		{
			int	j = s.executeUpdate("insert into ROSHANI(appname,TYPE_MBEAN,Value,HOSTNAME) VALUES('"+appname+"','"+checkBox[i]+"','"+val+"','"+hostname+"')");
			if(j>0){
			 	continue;
			}
			else{
				flag1 = 0;
				break;
			}
		}

		String dataSource = "OLMDataSource";
		String type = "Data Source";
		s.executeUpdate("insert into ROSHANI(appname,TYPE_MBEAN,KEY,Value,HOSTNAME) VALUES('"+appname+"','"+type+"','"+dataSource+"','"+val+"','"+hostname+"')");
		if(flag == 1){
			out.println("Your data has been successfully stored.");
		}
		else{
			out.println("fail");
		}
	}catch(Exception e){
		System.out.println(e);
	}
%>


<div id="block1"><a href="dashboard.html">View Dashboard</a></div>

<div id="block2"><a href="metric1.html">View Host overview</a></div>

<div id="block3"><a href="metric2.html">View System Overview</a></div>

</body>
</html>
