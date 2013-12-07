//验证身份证号码
function validate_ID(ID){
	var idCard = document.getElementById(ID).value.trim();   
	if (idCard.length == 18) {   
		var a_idCard = idCard.split("");// 得到身份证数组
	    if(isValidityBrithBy18IdCard(idCard)&&isTrueValidateCodeBy18IdCard(a_idCard)){   
	    	return true;   
	    }
	    else{
	    	alert("请输入正确的身份证号码！");
	    	document.getElementById(ID).focus;
	    	return false;
	    	}   
	    } else {   
	    	alert("请输入正确的身份证号码！");
	        return false;
	}   
}
// 判断最后一位验证位是否正确
function isTrueValidateCodeBy18IdCard(a_idCard) {   
    var sum = 0; // 声明加权求和变量
    var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ];
    var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ];
    if (a_idCard[17].toLowerCase() == 'x') {   
        a_idCard[17] = 10;// 将最后位为x的验证码替换为10方便后续操作
    }   
    for ( var i = 0; i < 17; i++) {   
        sum +=  Wi[i] * a_idCard[i];// 加权求和
    }   
    valCodePosition = sum % 11;// 得到验证码所位置
    if (a_idCard[17] == ValideCode[valCodePosition]) {   
        return true;   
    } else {   
        return false;   
    }   
}
//验证18位数身份证号码中的生日是否是有效生日  
function isValidityBrithBy18IdCard(idCard){   
    var year =  idCard.substring(6,10);   
    var month = idCard.substring(10,12);   
    var day = idCard.substring(12,14);   
    var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
    // 这里用getFullYear()获取年份，避免千年虫问题   
    if(temp_date.getFullYear()!=parseFloat(year)   
          ||temp_date.getMonth()!=parseFloat(month)-1   
          ||temp_date.getDate()!=parseFloat(day)){   
            return false;   
    }else{   
        return true;   
    }   
} 


// 验证邮箱
function validate_email(email,tip){
	var str = document.getElementById(email).value.trim();
	var reg=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	if(str.length!=0){
		if(!reg.test(str)){
				document.getElementById(tip).style.display="";
				document.getElementById(email).focus;
				return false;
		}
		else
			return true;
	}
	else{
		document.getElementById(tip).style.display="";
		document.getElementById(email).focus;
		return false;
}
}

//邮政编码验证
function validate_zip(zipCode,tip){
	var str = document.getElementById(zipCode).value.trim();
	if(str.length!=0){    
       var reg=/^[0-9][0-9]{5}$/;    
        if(!reg.test(str)){    
            //输入正确的邮政编码!");
        	document.getElementById(tip).style.display="";
            document.getElementById(zipCode).focus;
            return false;
        }
        else
        	return true;
    }
	else{
		document.getElementById(tip).style.display="";
        document.getElementById(zipCode).focus;
        return false;
	}
		
}
// 验证密码
function validate_pwd(pwd,tip){
	var str = document.getElementById(pwd).value.trim();
	var reg = /(?!^\\d+$)(?!^[a-zA-Z]+$).{6,}/;// 密码长度不少于6位，不能为纯数字或字符
	if(!reg.test(str)){
		//alert("密码长度不少于6位，不能为纯数字或字符");
		document.getElementById(tip).style.display="";
		document.getElementById(pwd).focus;
		return false;
	}
	else
		return true;
}
// 验证日期格式
function validate_date(date,tip){
	var str = document.getElementById(date).value.trim();
	var reg = /^((\d\d\d\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01]))$/;
	if(str.length!=0){
		if(!reg.test(str)){
				document.getElementById(tip).style.display="";
				document.getElementById(date).focus;
				return false;
		}
		else
			return true;
	}
	else{
		document.getElementById(tip).style.display="";
		document.getElementById(date).focus;
		return false;
}
}
//检查年份
function validate_year(year){
	var str = document.getElementById(year).value.trim();
	var reg = /^19\d\d|20\d\d$/;
	if(!reg.test(str)){
		alert("请输入4位入学年份！");
		document.getElementById(year).focus;
		return false;
	}
	else
		return true;
}
// 验证数字
function validate_integer(integer,tip){
	var str = document.getElementById(integer).value.trim();
	var reg=/^[0-9]*$/;
	if(!reg.test(str)){
		//alert("请输入数字");
		document.getElementById(tip).style.display="";
		document.getElementById(integer).focus;
		return false;
	}
	else
		return true;
}
// 验证手机号
function validate_Rphone(Rphone,tip){
	var str = document.getElementById(Rphone).value.trim();
	var reg = /^1[3|4|5|8][0-9]\d{8}$/;
	if(str.length!=0){
		if(!reg.test(str)){
				document.getElementById(tip).style.display="";
				document.getElementById(Rphone).focus;
				return false;
		}
		else
			return true;
	}
	else{
		document.getElementById(tip).style.display="";
		document.getElementById(Rphone).focus;
		return false;
}
}

//只能输入汉字
function validate_chinese(chinese){
	var str = document.getElementById(chinese).value.trim();
	var str = str.trim();
	var reg = /^[\u4e00-\u9fa5]+$/;
	
	if(!reg.test(str)){
		alert("不允许有除汉字意外的字符！");
		document.getElementById(chinese).focus;
		return false;
	}
	else
		return true;
}


// button切换。改变编辑状态

function tabModify(tabModifyx,inputx){
	if($(tabModifyx).val()=='修改'){
		$(tabModifyx).val("保存");
		$(inputx).removeAttr("readonly");
		$(inputx).css("border","1");
		
	}
	else{
		var isnone=true;
		for(var i=0;i<inputx.length;i++){
			if(inputx[i].value=="")
				isnone=true;
			else{
				isnone=(false||isnone);
				
		}
		}
		if(isnone==false){
			$(tabModifyx).val("修改");
			$(inputx).attr("readonly","true");
			$(inputx).css("border","none");
		}
		else
			return;
	
}
}


function isNone(inputx){
	if(document.getElementsById(inputx).value == "")
		return true;
	else
		return false;
	
}
//删除所选项
function deleteSel(){
	var obj = document.getElementsByName('_selected');
	for (var i=0;i<obj.length;i++){
		if (obj[i].checked){
			var tr=obj[i].parentNode.parentNode;
			var tbody=tr.parentNode;
			tbody.removeChild(tr);
			i--;
		}
	}
}
