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
	<link href="css/selfCss.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery.js"></script>
	<script src="bootstrap/dist/js/bootstrap.min.js"></script>
	
<style type="text/css">
	
</style>
</head>
<body  style="background-color: #CCEDC7"><!-- #ECF0F1   #CCEDC7-->
	<div style="width:1000px;margin-left: auto;margin-right: auto;">
		<header id="daohang" class="navbar navbar-inverse daohang " style="color: white;">
			 
			<div class="btn-group nochang_line  right_up" style="padding-right: 90px;">
				 <button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown">
				    选&nbsp;&nbsp;&nbsp;项 <span class="caret"></span>
				 </button>
				 <ul class="dropdown-menu "  role="menu">
				    <li><a href="javascript:void(0)" onclick="login_atHead()">登录</a></li>
				    <!--  <li ><a href="#" >备用1</a></li>
				    <li><a href="#">备用2</a></li>-->
				    <li class="divider"></li>
				    <li><a href="#" onclick="logout()">退出</a></li>
				 </ul>
			</div>
			
			
			<span id="name_lb" style="font-size: 25px;padding:0px;margin-right: 10px;"  class="right_up ">欢迎使用,游客</span>
		</header>
	<div class="head_cont" style="">
		<div align="center" style="">
			<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="400" height="300">
			    <param name="movie" value="flash.swf" />
			    <param name="quality" value="high" />
			    <param name="wmode" value="transparent" />
			    <embed src="pic/3opt.swf" quality="high"  pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="100%" height="298px"></embed>
			</object>
		</div>
		<!--  <div style="color:white;position:relative;left:80px;width:80%;"><h1>Welcome !</h1><span>&nbsp;&nbsp;&nbsp;&nbsp;在这里，无需账号，即可自由灌水...</span></div>-->
	
	</div>
	<div class="mycontainer">
		<div class=" page_head"  align="center">
			<span style="font-family:微软雅黑;font-size: 40px;">考勤留言板</span>
			<textarea id="getwords" onkeyup="checkTextArea()" class="form-control img-rounded textarea" rows="3" placeholder="在此输入你的看法..."></textarea>
		</div>
		<div class="talk"  align="center" >
			<span id="count_words" style="position:relative;left:-350px;font-size: 15px;top:10px;">已输入0字</span>
			<div id="" style="width:800px;">
			<h3 class="nochang_line"><span id="login_pic" class="label label-info" >验证码：</span></h3><img  id="pic"  class="img-rounded" src="" onclick="reLoadImg()" title="点击刷新" alt="点击刷新">
			<input id="verify_text" class="form-control nochang_line" type="text" style="width:60px;height:30px">
			<button  class="btn btn-primary  submit" onclick="submit_ly()" >提交留言</button>
			</div>	
		</div>
		
		<div class="  modal fade bs-example-modal-lg"  id="login_div" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
    		<div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			        <h2 class="modal-title" id="myModalLabel">请先登录</h2>
			      </div>
			      <div class="modal-body" >
								<h3 class="nochang_line">输入昵称</h3>
							    <input type="text" class="form-control" id="username" onkeyup="checkUsername()" name="username" placeholder="请勿多于10字...(无需注册，可以为班级，学院等信息，也可自定义)">
							    <h3 class="nochang_line">输入e-mail</h3>
							   	<input id="mail" type="text" class="form-control" name="mail" placeholder="输入邮箱...(必须)">
							   <!--   <button type="submit" class="btn btn-default" onclick="login()" >submit</button> -->
				  </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			        <button type="button" class="btn btn-primary" onclick="login()"> 提 交 </button>
			      </div>
		    </div>
		  </div>
		</div>
		<!-- 公告 -->
		<div id="announce" class="announce" style="">
			<marquee  scrollamount="4">  >>>欢迎使用考勤留言板，感谢您在此留下宝贵的建议或意见，同时感谢您对本系统的支持。</marquee>
		</div>
		
		<div id="recorder" class="panel panel-success recorder" >
			<div class="panel-heading"><h3>最近评论</h3></div>
			<div id="container" class="panel-body">
				<ul id="container_ul" class="list-group">
					
				</ul>
			</div>
		</div>
		
		<div id="tail" class="tail" >
			<nav >
			  <ul class="pagination" " >
			    <li class="disabled"><a href="javascript:void(0)" onclick="lastGroup()">&laquo;</a></li>
    			<li class="active"><a href="javascript:void(0)">1<span class="sr-only"></span></a></li>
			    <li ><a href="javascript:void(0)">2</a></li>
			    <li><a href="javascript:void(0)">3</a></li>
			    <li><a href="javascript:void(0)">4</a></li>
			    <li><a href="javascript:void(0)">5</a></li>
			    <li><a href="javascript:void(0)" onclick="nextGroup()">&raquo;</a></li>
			    
			  </ul>
			</nav>
		</div>
		
	</div>
</div>

</body>
<script src="js/self.js"></script>
</html>