	var username="游客";
	var current_length=0;//当前留言列表的长度
	var textNumLimit=140;
	var mail_add="";
	var onePageLen=10;
	var currentPage=1;//当前页数
	//注意：每次刷新页面后，页面则变量都会被还原为上述状态
	
	//窗体加载完执行的函数
	$(document).ready(function() {
		onLoadGetName();
		//每次刷新后初始化全局变量
		pageInit();
		$(".pagination a").click(function(event){getPage(event)});
		reLoadImg();//刷新验证码
		getOnePageInfo(1);
		
	});
	
	//用户登录
	function login(){
		//username 为全局变量
		
		//$("#login_div").slideUp("slow");
		$('#login_div').modal('hide');
		var user=document.getElementsByName("username")[0].value;//从文本框得到用户名
		var mail=document.getElementsByName("mail")[0].value;
		//检测邮箱是否合法
		if(checkMail(mail)==false){
			alert("邮箱地址不合法");
			return;
		}
			
		
		$("#name_lb").text("欢迎使用，"+user);
		
		$.post("ls.do",
				  {
				    username:user,
				    mail:mail
				  },
				  function(data,status){//回掉函数
				    //alert("Data: " + data + "\nStatus: " + status);
				  });
		//location.reload();
		//初始化全局变量
		username=user;
		mail_add=mail;
		
	}
	
	//提交留言
	function submit_ly(){
		var boolRes=isLogin();
		
		if(boolRes==false)//如果未登陆
		{
			$('#login_div').modal('show');
		}
		else{
			//alert("ok");
			var date=new Date();
			
			date=date.getFullYear()+"-"+(checkTime(date.getMonth()+1))+"-"+checkTime(date.getDate())+" "+checkTime(date.getHours())+":"+checkTime(date.getMinutes())+":"+checkTime(date.getSeconds());
			var data=$("#getwords").val();//文本域的内容
			var right_verify=getVerifyNum();//session 中的验证码
			var strTextNum=$("#verify_text").val();//前台用户填写的验证码
			
			if(data=="")
			{
				alert("留言内容不能为空");
				return ;
			}
			//监测文本是否全为空格
			if(checkText(data)==false)
				return ;
			if(strTextNum!=right_verify){
				
				alert("验证码错误");
				return;
			}
			
			current_length++;//楼层数增加1
			//如果用户所在界面不在第一页，则先回到第一页，再增加一条记录
			if(currentPage!=1)
			{
				getOnePageInfo(1);
			}
				
			addOneMessage(username, current_length, date, data)
			/*
			var new_li=$("<li class='new_recorder list-group-item' ></li>");	
			var li_p1=$("<p  class='re_name'></p>");
			var li_p1_a1=$('<a style="font-size:30px;">'+username+'&nbsp;&nbsp;</a>');
			var li_p1_span=$('<span>'+date+'</span>');
			var li_p1_span2=$('<span class="whichfloor">'+(current_length+1)+' 楼</span>');
			var li_p2=$('<p class="re_context">'+data+'</p>');
			var li_a=$('<a class="a_link" href="javascript:void(0)"></a>');//发表回复
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
			
			if(current_length>=5)
			{
				$("#container_ul li:eq(4)").remove();
				current_length--;
			}	
			$("#container_ul").prepend(new_li);
			new_li.slideDown("slow");
			*/
			//存储数据到数据库；
			saveInfo(date);
			//发言成功后清空textarea,验证码输入框
			$("#getwords").val("");
			$("#count_words").text("提交成功");
			//取消原来某个按钮的选择状态.设置分页按钮1为选中状态
			$(".pagination li.active").attr('class','');
			$(".pagination li:eq(1)").attr('class','active');
			reLoadImg();//刷新验证码
			$("#verify_text").val("");
			
			
			
			
		}		
	}
	
	//加载用户名，并更新右上角的名字
	function  onLoadGetName(){
		$.ajax
	       ({
	           cache: false,
	           async: false,
	           type: 'get',
	           url: "vls.do",
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
	
	//导航栏上的登陆按钮
	function login_atHead(){
		
		if(username=='游客')
			$('#login_div').modal('show');
	}
	
	function logout(){
		if(username!='游客')
		{
			$.ajax
		       ({
		           cache: false,
		           async: false,
		           type: 'get',
		           url: 'los.do',
		           success: function (data) {
		        	   
		           }
		       });
			username="游客";
			onLoadGetName();//更新由上角名子
			
			//清空登陆框的信息
			var user=document.getElementsByName("username")[0].value="";//从文本框得到用户名
			var mail=document.getElementsByName("mail")[0].value="";
			
		}
	}
	
	//监听换页按钮；
	function getPage(event){
		var index=event.target.text;//拿到事件源元素的text 如：1，2，3，4，5，,
		
		//document.write(index);//||'&raquo;'
		if(index!="«"&&index!="»")//!(index=='«'||index=='»')
		{
			index=parseInt(index);
			currentPage=index;//更新全局变量
			getOnePageInfo(index);
			//删除原来按钮的选中状态，并且更新新的按钮状态
			$(".pagination li.active").attr('class','');
			event.target.parentNode.setAttribute('class','active');
			//alert(event.target.parentNode.nodeName);
		}
	}
	
	
	//下5 页，>>
	function nextGroup(){
		var start=parseInt( $(".pagination li:eq(1)").children().text());
		
		$(".pagination li:eq(0)").attr('class','');//当组中的值不再是1-5页，改变<<为非disabled状态
		for(var i=1;i<=5;i++){
			$(".pagination li:eq("+i+")").children().text(start+i+4);
		}
		getOnePageInfo(start+5);
	}
	
	//上5页  <<
	function lastGroup(){
		var start=parseInt( $(".pagination li:eq(1)").children().text());//第一个按钮的文本值
		
		if(start==1)
			return;
		//$(".pagination li:eq(0)").attr('class','');
		for(var i=1;i<=5;i++){
			$(".pagination li:eq("+i+")").children().text(start+i-6);
		}
		if(start==6){//如果当前组是6-10，上面for循环将之改为1-5并且把<<改为不可按状态
			$(".pagination li:eq(0)").attr('class','disabled');
		}
		getOnePageInfo(start-5);
		
	}
	
	
	//////////////////////////////////////
	////////////////////////////////////////
	//判断用户是否登陆
	function isLogin(){
		var boolRes=false;
		//后台获取用户名
		$.ajax
	       ({
	           cache: false,
	           async: false,
	           type: 'get',
	           url: "vls.do",
	           success: function (data) {
	        	  
	        	   if(data!="未登陆")
	        		{
	        		   username=data;
	        		   boolRes=true;
	        		}
			    		
	           }
	       });
		return boolRes;
	}
	
	//从后台得到 验证码
	function getVerifyNum(){
		var str;
		$.ajax
	       ({
	           cache: false,
	           async: false,
	           type: 'get',
	           url: "gns.do",
	           success: function (data) {
	        	   str=data;
	           }
	       });
		return str;
	}
	
	//刷新页面验证码
	function reLoadImg(){
		$("#pic").attr('src','number.jsp?id='+Math.random());
		
	}
	
	//正则检测留言内容是否合法
	function checkText(data){
		var pattern=new RegExp("^ {0,} $");
		if(pattern.test(data)){
			alert("留言内容不合法");
			return false;
		}
		return true;
			
	}
	
	//监测文本域字数
	function checkTextArea(){
		var area=$("#getwords").val();
		var area_len=area.length;
		var msg="已输入"+area.length+"字";
	    
	    if(area_len>textNumLimit)
	    {
	    	//alert(area.length+"   "+textNumLimit);
	    	msg="超出字数限制";	
	    	$("#getwords").val(area.substring(0,textNumLimit));
	    }
	    $("#count_words").text(msg);
	}
	
	//上传数据到数据后台
	function saveInfo(date){
		
		var areaText=$("#getwords").val();
		//alert(current_length);
		$.post("sif.do",
				  {
					info_id:parseInt(current_length),//当前记录的楼数，也是数据的编号---id
				    info:areaText,
				    time:date
				  },
				  function(data,status){//回掉函数
				    //alert("Data: " + data + "\nStatus: " + status);
				  });
	}
	
	//页面在加载时，初始化
	function pageInit() {
	// 到数据库获取更新 current_length
	$.ajax({
		cache : false,
		async : false,
		type : 'get',
		url : "grns.do",
		success : function(data, status) {
			if (status == 'success')
				current_length = data;

		}
	});
}
	
	// 在页面中添加一条信息
	function addOneMessage(username,current_length,date,data){
		
		data=stringFilter(data);
		//alert("<script>alert('eeee')</script>");
		var new_li=$("<li class='new_recorder list-group-item' ></li>");	
		var li_p1=$("<p  class='re_name'></p>");
		var li_p1_a1=$('<a style="font-size:20px;">'+username+'&nbsp;&nbsp;</a>');
		var li_p1_span=$('<span>'+date+'</span>');
		var li_p1_span2=$('<span class="whichfloor">'+(parseInt(current_length))+' 楼</span>');
		
		
		var infot='<p class="re_context">'+data+'</p>';
		
		var li_p2=$(infot);//&lt;script&gt;alert(\'eeee\')&lt;/script&gt;
		var li_a=$('<a class="a_link" href="javascript:void(0)"></a>');//发表回复
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
		
		if(current_length>=onePageLen)
		{
			
			$("#container_ul li:eq("+(onePageLen-1)+")").remove();
			
		}
			
		$("#container_ul").prepend(new_li);
		
		new_li.slideDown("slow");
	} 
	
	//分页,根据参数获取某页数据..返回数组对象
	function getOnePageInfo(intPage){
		var info;
		
		$.ajax
	       ({
	           cache: false,
	           async: false,
	           type: 'post',
	           url: "pss.do",
	           data:{
					page:intPage,    //当前页码
					len:onePageLen   //每页显示的条数
				  },
	           success: function (data) {
	        	   info=data;	
	           }
	       });
		var infoObj=jQuery.parseJSON(info);
		//alert(infoObj.info.length);
		var infosArray=infoObj.info;
		//逐条加入页面
		//加入之前先清空页面中的列表
		$("#container_ul").empty();
		for(var i=infosArray.length-1;i>=0;i--){
			addOneMessage(infosArray[i].username,infosArray[i].info_id,infosArray[i].time,infosArray[i].msg)
		}
		
		return infosArray;
	}
	//监测用户名长度
	function checkUsername(){
		var usr=$("#username").val();
		if(usr.length>10){
			$("#username").val(usr.substring(0,10));
		}
	}
	//监测邮箱合法性
	function checkMail(mail){
		//var mail=$("#mail").val();
		var pattern=new RegExp("[a-zA-Z0-9]+@[a-zA-Z0-9]+(\\.[a-zA-Z]+)+");
		var res=true;
		if(pattern.test(mail)==false)
		{
			return false;
		}else {
			return true;
		}
	}
	//检查时间格式是否小于10，1补成两位01
	function checkTime(str){
		if(str<10)
			str='0'+str;
		return str;
	}
	
	function stringFilter(str){
		
		str=str.replace(/</g,"&lt;");
		str=str.replace(/>/g,"&gt;");
		//str=str.replace(/&/g,"&amp;");
		str=str.replace(/"/g,"&quot;");
		
		
		//alert("stringFilter:"+str);
		return str;
	}
	
	
	