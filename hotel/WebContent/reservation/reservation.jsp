<%@page import="java.text.DateFormat"%>
<%@page import="hotel.RoomBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<jsp:useBean id="cmgr" class="hotel.CountMgr"/>
<jsp:useBean id="hmgr" class="hotel.RoomMgr"/>
<%
		request.setCharacterEncoding("utf-8");
		String email = (String)session.getAttribute("emailKey");
		boolean off = email == null || email.equals("");
		Vector<RoomBean> vlist = hmgr.getRoomList();

		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
	    Date currentDate = new Date();
	    String today = dateFormat.format(currentDate);
	    Calendar c = Calendar.getInstance();
	    c.setTime(currentDate);
	    c.add(Calendar.DATE, 1);
	    Date tomo = c.getTime();
	    String nextday = dateFormat.format(tomo);
%>
<!DOCTYPE HTML>
<html>
<head>
<title>The Paradise-Hotel Website Template | Reservation :: w3layouts</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<script src="js/jquery.min.js"></script>
<!---strat-date-piker---->
<link rel="stylesheet" href="css/jquery-ui.css" />
<script src="js/jquery-ui.js"></script>
<script>
  $(function() {
    $( "#datepicker,#datepicker1" ).datepicker();
  });
  function cal() {
	  if((document.getElementById("datepicker1").value.split("/")[1]-document.getElementById("datepicker").value.split("/")[1])>0||
	  !isNaN(document.getElementById("datepicker1").value.split("/")[1]-document.getElementById("datepicker").value.split("/")[1])){
		document.getElementById("day").textContent=document.getElementById("datepicker1").value.split("/")[1]-document.getElementById("datepicker").value.split("/")[1];
		document.getElementById("day").value=document.getElementById("datepicker1").value.split("/")[1]-document.getElementById("datepicker").value.split("/")[1];
		document.getElementById("daytotal").textContent=document.getElementById("day").value*document.getElementById("roompay").value;
	  }
      var target = document.getElementById("roompay");
	  document.getElementById("roomname").value=(target.options[target.selectedIndex].text=="Select a type of Room"?"Standard":target.options[target.selectedIndex].text);
	  document.getElementById("perday").textContent=document.getElementById("roompay").value;
		document.getElementById("adult").textContent=document.getElementById("country1").value;
		document.getElementById("ch05").textContent=document.getElementById("country2").value;
		document.getElementById("ch12").textContent=document.getElementById("country3").value;
		document.getElementById("people").value=document.getElementById("country1").value+"/"+document.getElementById("country2").value+"/"+document.getElementById("country3").value;
		document.getElementById("pay").value=document.getElementById("daytotal").textContent;
   }
  function send() {
	if(<%=off%>){
		parent.a();
	}else{
		cal();
		document.cart.submit();
	}
}
</script>
<!---/End-date-piker---->
<link type="text/css" rel="stylesheet" href="css/JFFormStyle-1.css" />
		<script type="text/javascript" src="js/JFCore.js"></script>
		<script type="text/javascript" src="js/JFForms.js"></script>
		<!-- Set here the key for your domain in order to hide the watermark on the web server -->
		<script type="text/javascript">
			(function() {
				JC.init({
					domainKey: ''
				});
				})();
		</script>
<!--nav-->
<script>
		$(function() {
			var pull 		= $('#pull');
				menu 		= $('nav ul');
				menuHeight	= menu.height();

			$(pull).on('click', function(e) {
				e.preventDefault();
				menu.slideToggle();
			});

			$(window).resize(function(){
        		var w = $(window).width();
        		if(w > 320 && menu.is(':hidden')) {
        			menu.removeAttr('style');
        		}
    		});
		});
</script>
</head>
<body onchange="cal()">
<!--start main -->
<div class="main_bg">
<div class="wrap">
	<div class="main">
		<form name="cart" action="../login/cartProc.jsp">
			<div class="span_of_2">
				<div class="span2_of_1">
					<h4>check-in:</h4>
					<div class="book_date btm">
							<input name="checkin" class="date" id="datepicker" type="text" value="<%=today %>" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '<%=today %>';}">
					</div>	
					<div class="sel_room" >
						<h4>number of rooms</h4>
						<select id="roompay" class="frm-field required">
							<option value="0">Select a type of Room</option>
					<%for(int i=0;i<vlist.size();i++) {%>
				            <option value="<%=vlist.get(i).getPrice() %>"><%=vlist.get(i).getRoomname() %></option>         
					<%} %>
		        		</select>
					</div>	
					<div class="sel_room left" >
						<h4>adults per room:</h4>
						<select id="country1" class="frm-field required">
							<option value="1">1</option>
				            <option value="2">2</option>         
				            <option value="3">3</option>
							<option value="4">4</option>
		        		</select>
					</div>	
				</div>
				<div class="span2_of_1"s>
					<h4>check-out:</h4>
					<div class="book_date btm">
							<input name="checkout" class="date" id="datepicker1" type="text" value="<%=nextday %>" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '<%=nextday %>';}">
					</div>	
					<div class="sel_room">
						<h4>childern 0-5:</h4>
						<select id="country2" class="frm-field required">
							<option value="0">0</option>
							<option value="1">1</option>
				            <option value="2">2</option>         
				            <option value="3">3</option>
							<option value="4">4</option>
		        		</select>
					</div>	
					<div class="sel_room left">
						<h4>childern 6-12:</h4>
						<select id="country3" class="frm-field required">
							<option value="0">0</option>
							<option value="1">1</option>
				            <option value="2">2</option>         
				            <option value="3">3</option>
							<option value="4">4</option>
		        		</select>
					</div>	
				</div>
				<div class="row" style="width:100%">
				<div class="row">
				    <ul class="costs">
						<li><span>Day </span><span id="day">0</span>일</li>
						<li><span>Per Day </span><span id="perday">0</span>원</li>
						<li><span>Total Rates </span><span id="daytotal">0</span>원</li>
					</ul>
				</div>
				<div class="row">
				    <ul class="costs">
						<li><span>Adult  </span><span id="adult">0</span>명</li>
						<li><span>Child </span><span id="ch05">0</span>/<span id="ch12">0</span>명</li>
					</ul>
				</div>
  				<div class="row" style="float:right">
						<input name="roomname" type="hidden" id="roomname" value="none">
						<input name="people" type="hidden" id="people" value="0/0/0">
						<input name="pay" type="hidden" id="pay" value="0">
						<input type="button" onclick="send()" value="book now" style="width: 100%;">
				</div>
				</div>
				<div class="clear"></div>
			</div>
		</form>
	</div>
</div>
</div>		
</body>
<script>
self.resizeTo(document.body.scrollWidth , document.body.scrollHeight + 10);
</script>
</html>