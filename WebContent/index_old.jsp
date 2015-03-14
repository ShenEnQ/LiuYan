<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
	<meta charset="utf-8">
   	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>留言板</title>
	<link href="bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery.js"></script>
	<script src="bootstrap/dist/js/bootstrap.min.js"></script>
	<script src="bootstrap/dist/js/modal.js"></script>
<style type="text/css">
	#login_div 
	{
	height:230px;
	width:500px;
	display:none;
	border:solid 1px #c3c3c3;
	positon:relative;
	margin-left:325px;
	margin-top:40px
	}
	ul{
		list-style-type:none
	}
	span{
		font-size:20px;
	}
	
	.whichfloor{
		position: absolute;
		left:500px;
	}
	.textarea {
		width:500px;
		height:150px;
		resize:none;
		
		margin: 5px;
		font-size: 30px;
	}
	.submit{
		position:relative;
		left:180px;
	}
	.talk{
		position:relative;
		left:340px;
	}
	#recorder{
		position:relative;
		left:270px;
		width:600px;
		 border: 1px solid #CCC;		
	}
	#container{
		
				
	}
	#container_ul li{
		border-bottom: 1px solid #CCC;
		list-style-type:none
	}
	.container_ul{
		border-bottom: 1px solid #CCC;
		list-style-type:none
	}
	.rerep{
		position:relative;
		left:40px;
		width:520px;
		
		border-top: 1px solid #CCC  ;
	}
	.re_context{
		width:520px;
		word-break:break-all;
	}
	.new_recorder{
		border-bottom: 1px solid #CCC;
		list-style-type:none;
		display:none;
		
	}
	.a_link{
		position: relative;
		left:460px;
		font-size: 20px;	
	}
	.nochang_line{
		display:inline-block;
	}
	.right_up{
		float: right;
		padding: 10px;
	}
</style>
</head>
<body>
	<div class="container">
		<div id="daohang">
			
			<div class="btn-group nochang_line right_up">
				 <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown">
				    选项 <span class="caret"></span>
				 </button>
				 <ul class="dropdown-menu" role="menu">
				    <li><a href="#">待添加</a></li>
				    <li><a href="#">备用1</a></li>
				    <li><a href="#">备用2</a></li>
				    <li class="divider"></li>
				    <li><a href="#">退出</a></li>
				 </ul>
			</div>
			
			<span id="name_lb" style="font-size: 25px;"  class="right_up ">欢迎使用,游客</span>
		</div>
		<div class="" style="margin:20px 50px;" align="center">
			<h1 >淮工留言板</h1>
			<textarea id="getwords" class="form-control textarea" rows="3" ></textarea>
		</div>
		<div class="talk" >
			<h3 class="nochang_line"><span id="login_pic" class="label label-info" >验证码：</span></h3><img  id="pic"  class="img-rounded" src="number.jsp"  title="点击刷新" alt="点击刷新">
			<input id="verify_text" class="form-control nochang_line" type="text" style="width:60px;height:20px">
			<button  class="btn btn-primary  submit" onclick="submit_ly()" >提交留言</button>
				
		</div>
		
		<div class="form-group bg-success " align="center" id="login_div">
			<h3 class="nochang_line">请先登录</h3><span class="glyphicon glyphicon-remove right_up" onclick="up_back()"></span>
			
			<form role="form" action="javascript:void(0)">
		  		<div class="form-group">
				    <label for="exampleInputEmail1">输入昵称</label>
				    <input type="text" class="form-control" id="" name="username" placeholder="Enter name">
				    <label for="exampleInputPassword1">e-mail</label>
				   	<input type="email" class="form-control" name="mail" placeholder="Enter e-mail">
				    <button type="submit" class="btn btn-default" onclick="login()" >submit</button>
			   </div>
			</form>	
		</div>
		
		<div id="recorder" class="panel panel-success"">
			<div class="panel-heading"><h3>最近评论</h3></div>
			<div id="container" class="panel-body">
				<ul id="container_ul" class="list-group">
					
				</ul>
			</div>
		</div>
		<div id="tail" align="center">
			<nav>
			  <ul class="pagination">
			    <li class="disabled"><a href="#">&laquo;</a></li>
    			<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
			    <li><a href="#">2</a></li>
			    <li><a href="#">3</a></li>
			    <li><a href="#">4</a></li>
			    <li><a href="#">5</a></li>
			    <li><a href="#">&raquo;</a></li>
			  </ul>
			</nav>
		</div>
</div>
</body>
<script type="text/javascript">
	var username="游客";
	//提交留言
	function submit_ly(){
		var isLogin=false;
		
		//后台获取用户名
		$.ajax
	       ({
	           cache: false,
	           async: false,
	           type: 'get',
	           url: "VerifyLoginServlet",
	           success: function (data) {
	        	  // alert(data);
	        	   if(data!="未登陆")
			    		isLogin=true;
	           }
	       });
		
		if(isLogin==false)//如果未登陆
		{
			$("#login_div").slideDown("slow");
		}
		else{
			//alert("ok");
			var date=new Date().toLocaleString();
			var data=$("#getwords").val();//文本域的内容
			var right_verify=getVerifyNum();//session 中的验证码
			var strTextNum=$("#verify_text").val();//前台用户填写的验证码
			
			if(data=="")
			{
				alert("留言内容不能为空");
				return ;
			}
			if(strTextNum!=right_verify){
				
				alert("验证码错误");
				return;
			}
			var new_li=$("<li class='new_recorder list-group-item' ></li>");	
			var li_p1=$("<p  class='re_name'></p>");
			var li_p1_a1=$('<a>'+<%="'"+session.getAttribute("username")+"  '"%>+'</a>');
			var li_p1_span=$('<span>'+date+'</span>');
			var li_p1_span2=$('<span class="whichfloor">w几楼</span>');
			var li_p2=$('<p class="re_context">'+data+'</p>');
			var li_a=$('<a class="a_link" href="javascript:void(0)">发表回复</a>');
			var li_div1=$('<div class="reply_util"></div>');

			var li_div2=$('<div class="rerep"></div>');
			var div2_p1=$('<p class="re_name"></p>');
			var div2_p1_a1=$('<a>xxx回复 xxx</a>');
			var div2_p1_span=$('<span>日期</span>');
			var div2_p2=$('<p class="re_context">回复的内容</p>');
			var div2_a1=$('<a class="a_link" href="javascript:void(0)">发表回复</a>');
			var div2_div1=$('<div class="reply_util"></div>');
			
			li_p1.append(li_p1_a1);
			li_p1.append(li_p1_span);
			li_p1.append(li_p1_span2);
			new_li.append(li_p1);
			
			
			new_li.append(li_p2);
			new_li.append(li_a);
			new_li.append(li_div1);

			
			div2_p1.append(div2_p1_a1);
			div2_p1.append(div2_p1_span);
			li_div2.append(div2_p1);

			li_div2.append(div2_p2);
			li_div2.append(div2_a1);
			li_div2.append(div2_div1);

			//new_li.append(li_div2);//回复者 	
			
			$("#container_ul").prepend(new_li);
			new_li.slideDown("slow");
			//发言成功后清空textarea,验证码输入框
			$("#getwords").val("");
			
			$("#verify_text").val("");
		}		
	}
	//从后台得到 验证码
	function getVerifyNum(){
		var str;
		$.ajax
	       ({
	           cache: false,
	           async: false,
	           type: 'get',
	           url: "GetVerifyNumServlet",
	           success: function (data) {
	        	   str=data;
	           }
	       });
		return str;
	}
	//用户登录
	function login(){
		$("#login_div").slideUp("slow");
		var username=document.getElementsByName("username")[0].value;//从文本框得到用户名
		var mail=document.getElementsByName("mail")[0].value;
		$("#name_lb").text("欢迎使用，"+username);
		
		$.post("LoginServlet",
				  {
				    username:username,
				    mail:mail
				  },
				  function(data,status){//回掉函数
				    //alert("Data: " + data + "\nStatus: " + status);
				  });
		//location.reload();
	}
	//窗体加载完执行的函数
	$(document).ready(function() {
		onLoadGetName();
		
		
		
		
	});
	//加载用户名，并更新右上角的名字
	function  onLoadGetName(){
		$.ajax
	       ({
	           cache: false,
	           async: false,
	           type: 'get',
	           url: "VerifyLoginServlet",
	           success: function (data) {
	        	  // alert(data);
	        	   if(data!="未登陆")
			    		username=data;
	           }
	       });
		//$("#pic").attr("src","number.jsp");
		$("#name_lb").text("欢迎使用，"+username);
	}
	function up_back(){
		$("#login_div").slideUp("slow");
	}
	
</script>
</html>