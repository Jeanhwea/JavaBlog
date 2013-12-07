<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sign up</title>
<script src="js/jquery.js"></script>
<script type="text/javascript">
    var name_flag = false,
        pwd_flag = false,
        comfirm_flag = false,
        age_flag = false;
    function check1 () {
        if ($("#signup_name").val().length <= 20 && 
            $("#signup_name").val().length > 0) {
            name_flag = true;
        } else {
            document.getElementById("signup_name_tips").innerHtml = "用户名长度错误";
        }
    }
    function check2 () {
        if ($("#signup_password").val().length <= 32 && 
            $("#signup_password").val().length > 0) {
            pwd_flag = true;
        } else {
            document.getElementById("signup_name_tips").innerHtml = "密码长度不符合要求";
        }
    }
    function check3 () {
        if ($("#signup_password").val() == $("#signup_comfirm").val()) {
            comfirm_flag = true;
        } else {
            document.getElementById("signup_name_tips").innerHtml = "两次密码不一致";
        }
    }
    function check4 () {
        var age = $("#signup_age").val();
        var integer = /^[0-9]*[1-9][1-9]*$/;
        if (age.match(integer)) {
            age_flag = true;
        };
    }
    function check () {
        if (name_flag == false) {
            alert("用户名长度错误");
            return false;
        };
        if (pwd_flag == false) {
            alert("密码长度不符合要求");
            return false;
        };
        if (comfirm_flag == false) {
            alert("两次密码不一致");
            return false;
        };
        if (age_flag == false) {
            alert("年龄必须是正整数");
            return false;
        };
        return true;
    }
</script>
</head>
<body>	
    <form id="signup_form" name="signup_form" method="post" action="/Blog/userdo?param=signup">
<table>	
	<tr><td>用户名: </td>
    		<td><input id="signup_name" type = "text" name="signup_name" onblur="check1()">
            <span id="signup_name_tips">* 1到20个字符</span>
            </td>
    	</tr>
    	<tr>
    		<td>密  码: </td>
    		<td><input id="signup_password" type = "password" name="signup_password" onblur="check2()">
            <span id="signup_password_tips">* 1到32个字符</span></td>
    	</tr>
    	<tr>
    		<td>密码确认: </td>
    		<td><input id="signup_comfirm" type = "password" name="signup_comfirm" onblur="check3()">
            <span id="signup_comfirm_tips">* 1到32个字符</span></td>
    	</tr>
        <tr>
            <td>电子邮件: </td>
            <td><input id="signup_email" type = "text" name="signup_email"></td>
        </tr>
        <tr>
            <td>电话号码: </td>
            <td><input id="signup_tel" type = "text" name="signup_tel"></td>
        </tr>
        <tr>
            <td>年龄: </td>
            <td><input id="signup_age" type = "text" name="signup_age" onblur="check4()">
            <span id="signup_comfirm_tips">* 年龄必须是正整数</span></td>
        </tr>
    	<tr>
            <td><input id="signup_button" type = "submit" name="submit" value= "确认注册" onclick="return check();"></td>
            <td><p> </p></td>
            <td><p><a href="login.jsp">去登陆</a></p></td>
    	</tr>
    </table>
    </form>
</body>
</html>