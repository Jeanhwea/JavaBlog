<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
	<div>
    <form id="login_form" name="login_form" method="post" action="checkin.jsp">
	<table>	
    	<tr>
    		<td>用户名: </td>
    		<td>
            <input id="login_name" type = "text" name="login_name">
            </td>
    	</tr>
    	<tr>
    		<td>密  码: </td>
    		<td><input id="login_password" type = "password" name="login_password"></td>
    	</tr>
    	<tr>     <td></td>  
    	<td align="left">
    	<input id="usertype" name="usertype" type="radio" value="user" checked="checked" />
            <span class="STYLE7">普通用户&nbsp;&nbsp;
          <input id="usertype" name="usertype" type="radio" value="admin" />管理员</span></td>
    	</tr>
    	<tr>
            <td><input type = "submit" name="submit" value= "登陆"></td>
            <td></td>
            <td><p><a href="signup.jsp">注册新用户</a></p></td>
    	</tr>
    </table>
    </form>
    </div>
</body>
</html>