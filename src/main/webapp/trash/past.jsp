<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, trashRecord.RNclass"%>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
<script src="../js/onload.js"></script>
<link rel="stylesheet" href="../scss/past.css">
<link rel="stylesheet" media="screen and (max-width: 780px)" href="../scss/past780.css" />
<link rel="stylesheet" href="../scss/loadingpage.css">
<link rel="stylesheet" href="../scss/button.css">
<title>數值紀錄</title>
<style>
</style>
</head>

<body>
<div id="loadingPage"><img id="loading-image" src="../pic/giphy.gif" alt="Loading..." /></div>
	<h1>過去紀錄</h1>
	<div class="asideMenu">
		<button id="btn1" class="btn">
			<i class="fas fa-chevron-right fa-2x">&diams;</i>
		</button>
		<div class="title">Aside Menu</div>
		<div class="list">
			<dl class="optionTitle">
				<dt>
					<p id="pastbt">過去紀錄</p>
				</dt>
				<dt>
					<p id="chart1bt">圖表1</p>
				</dt>
				<dt>
					<p id="chart2bt">圖表2</p>
				</dt>
				<dt>
					<p id="chart3bt">圖表3</p>
				</dt>
			</dl>
		</div>
	</div>
	<div id="mychart1">
		<table>
			<thead>
    			<tr>
      				<th>類型</th>
     				 <th>時間</th>
    			</tr>
  			</thead>
			<tbody>
				<%
					List<RNclass> RNs = (ArrayList<RNclass>) request.getAttribute("Classes");
					for (RNclass RN : RNs) {
						String type = RN.getRN_class();	
				%>
				<tr>
					<td><%=RN.getRN_class()%></td>
					<td><%=RN.getTime()%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<br>

	</div>
	<div id="mychart2" style="display: none;">
		<canvas id="chart1" width="800" height="600"
			style="border: 1px solid #000000;"></canvas>
	</div>
	<div id="mychart3" style="display: none;">
		<canvas id="chart2" width="800" height="600"
			style="border: 1px solid #000000;"></canvas>
	</div>
	<div id="mychart4" style="display: none;">
		<canvas id="chart3" width="800" height="600"
			style="border: 1px solid #000000;"></canvas>
	</div>
	<div>
		<a href="../index.html"><button class="button">回首頁</button></a>
	</div>
	<span id=”info_jb51_net”></span>

	<script>
	$(function() {
		$(".btn").click(function() {
			$(".asideMenu").toggleClass("active");
			$(".fa-chevron-right").toggleClass("rotate");
		});
	});
	
    //pageing
    $(function(){
	 var $table = $('table');
	 var currentPage = 0;//当前页默认值为0
	 var pageSize = 10;//每一页显示的数目
	 $table.bind('paging',function(){
		 $table.find('tbody tr').hide().slice(currentPage*pageSize,(currentPage+1)*pageSize).show();
	 });	 
	 var sumRows = $table.find('tbody tr').length;
	 var sumPages = Math.ceil(sumRows/pageSize);//总页数
	 
	 var $pager = $('<div class="page"></div>');  //新建div，放入a标签,显示底部分页码
	 for(var pageIndex = 0 ; pageIndex<sumPages ; pageIndex++){
		 $('<a href="#" id="pageStyle" οnclick="changCss(this)"><span>'+(pageIndex+1)+'</span></a>').bind("click",{"newPage":pageIndex},function(event){
			 currentPage = event.data["newPage"];
			 $table.trigger("paging");
			   //触发分页函数
			 }).appendTo($pager);
			 $pager.append(" ");
		 }	 
		 $pager.insertAfter($table);
		 $table.trigger("paging");
});


	$('#pastbt').click(function() {
		$("#mychart1").css("display", "");
		$("#mychart2").css("display", "none");
		$("#mychart3").css("display", "none");
		$("#mychart4").css("display", "none");
		console.log("1");
	});
	$('#chart1bt').click(function() {
		$("#mychart1").css("display", "none");
		$("#mychart2").css("display", "");
		$("#mychart3").css("display", "none");
		$("#mychart4").css("display", "none");
		console.log("2");
	});
	$('#chart2bt').click(function() {
		$("#mychart1").css("display", "none");
		$("#mychart2").css("display", "none");
		$("#mychart3").css("display", "");
		$("#mychart4").css("display", "none");
		console.log("3");
	});
	$('#chart3bt').click(function() {
		$("#mychart1").css("display", "none");
		$("#mychart2").css("display", "none");
		$("#mychart3").css("display", "none");
		$("#mychart4").css("display", "");
		console.log("4");
	});
	
	var ctx1 = document.getElementById('chart1').getContext('2d');
	   

	var chart1 = new Chart(ctx1, {
		type : 'bar',
		data : {
			labels : [ "normal", "recycle" ],
			datasets : [ {
				label : '# of Votes',
				data : [${number_N}, ${number_R}],
				backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
						'rgba(54, 162, 235, 0.2)' ],
				borderColor : [ 'rgba(255,99,132,1)',
						'rgba(54, 162, 235, 1)' ],
				borderWidth : 1
			} ]
		},
		options : {
                responsive: true,
                maintainAspectRatio: false,
			scales : {
				yAxes : [ {
					ticks : {
						beginAtZero : true
					}
				} ]
			}
		}
	});

	var ctx2 = document.getElementById('chart2').getContext('2d');

	var chart2 = new Chart(ctx2,
			{
				type : 'line',
				data : {
					labels : [ 'January', 'February', 'March', 'April',
							'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
					datasets : [ {
						label : 'My First dataset',
						backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
								

						],
						borderColor : [ 'rgba(255,99,132,1)',
								],
						data : [ 10, 30, 39, 20, 25, 34, -10 , 20, 50, 40, 30, 10],
						fill : false,
					} ]
				},
				options: {
	                responsive: true,
	                maintainAspectRatio: false,
	            }

			});

	var ctx3 = document.getElementById('chart3').getContext('2d');
	
	<%--	       var datax = [];
	<%
	List<RNclass> Classes2 = (ArrayList<RNclass>) request.getAttribute("Classes");
	for (RNclass Class : Classes) {
		
		
%>
	       datax.push("<%=Class.getType()%>")

	       <%
	}
%>	       
	       console.log(datax);		       

	       function checknormal(datax) {
	          return datax.includes("normal");
	      }
	       function checkbottle(datax) {
		          return datax.includes("bottle");
		      }
	       function checkcan(datax) {
		          return datax.includes("can");
		      }
	       function checkpapper(datax) {
		          return datax.includes("papper");
		      }
	       function checkbattery(datax) {
		          return datax.includes("battery");
		      }
	     normal = datax.filter(checknormal)
	     bottle = datax.filter(checkbottle)
	     can = datax.filter(checkcan)
	     papper = datax.filter(checkpapper)
	     battery = datax.filter(checkbattery)
     
	     console.log("normal"+normal.length)
	     console.log("bottle"+bottle.length)
	     console.log("can"+can.length)
	     console.log("papper"+papper.length)
	     console.log("battery"+battery.length)
	     
	--%>
	
	var randomScalingFactor = function() {
		return Math.round(Math.random() * 100);
	};

	var chart3 = new Chart(ctx3,
			{
				type : 'pie',
				data : {
					datasets : [ {
						data : [ ${number_cb},
							${number_cc},
							${number_cp},
							${number_cba},
							${number_cn}, ],
						backgroundColor : [ 'rgba(255,99,132,1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(75, 192, 192, 1)',
								'rgba(153, 102, 255, 1)' ],
						label : '資源回收分類'
					} ],
					labels : [ '寶特瓶', '鐵鋁罐', '紙類', '電池', '一般垃圾' ]
				},
				options: {
	                responsive: true,
	                maintainAspectRatio: false,
	            }

			});

	</script>
</body>

</html>