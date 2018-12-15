<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sign Up fails</title>
</head>
<body>
<p>用户名(<%=session.getAttribute("signup_name").toString()%>)
已经被注册过，请更换用户名！！！<a href="signup.jsp">重新注册</a></p>
</body>
</html>