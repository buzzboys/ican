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
	<div class="asideMenu">
		<button id="btn1" class="btn">
			<i class="fas fa-chevron-right fa-2x">&diams;</i>
		</button>
		<div class="title">Ican Menu</div>
		<div class="list">
			<dl class="optionTitle">
				<dt>
					<p id="pastbt">過去紀錄</p>
				</dt>
				<dt>
					<p id="chart1bt">垃圾統計</p>
				</dt>
				<dt>
					<p id="chart2bt">當月類別</p>
				</dt>
				<dt>
					<p id="chart3bt">類別餅圖</p>
				</dt>
			</dl>
		</div>
	</div>
	<h1 id="pastt" >過去紀錄</h1>
	<h1 id="chart1t"  style="display: none;">垃圾統計</h1>
	<h1 id="chart2t"  style="display: none;">當月類別</h1>
	<h1 id="chart3t"  style="display: none;">類別餅圖</h1>
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
		
		$("#pastt").css("display", "");
		$("#chart1t").css("display", "none");
		$("#chart2t").css("display", "none");
		$("#chart3t").css("display", "none");
		console.log("1");
	});
	$('#chart1bt').click(function() {
		$("#mychart1").css("display", "none");
		$("#mychart2").css("display", "");
		$("#mychart3").css("display", "none");
		$("#mychart4").css("display", "none");
		
		$("#pastt").css("display", "none");
		$("#chart1t").css("display", "");
		$("#chart2t").css("display", "none");
		$("#chart3t").css("display", "none");
		
		
		console.log("2");
	});
	$('#chart2bt').click(function() {
		$("#mychart1").css("display", "none");
		$("#mychart2").css("display", "none");
		$("#mychart3").css("display", "");
		$("#mychart4").css("display", "none");
		
		$("#pastt").css("display", "none");
		$("#chart1t").css("display", "none");
		$("#chart2t").css("display", "");
		$("#chart3t").css("display", "none");
		console.log("3");
	});
	$('#chart3bt').click(function() {
		$("#mychart1").css("display", "none");
		$("#mychart2").css("display", "none");
		$("#mychart3").css("display", "none");
		$("#mychart4").css("display", "");
		
		$("#pastt").css("display", "none");
		$("#chart1t").css("display", "none");
		$("#chart2t").css("display", "none");
		$("#chart3t").css("display", "");		
		console.log("4");
	});
	
	var ctx1 = document.getElementById('chart1').getContext('2d');
	
	
	   

	var chart1 = new Chart(ctx1, {
		type : 'bar',
		data : {
			labels : [ "數量" ],
			datasets : [ {
				label : '一般垃圾',
				data : [${number_N}],
				backgroundColor : [ 'rgba(255, 99, 132, 0.2)'
						 ],
				borderColor : [ 'rgba(255,99,132,1)'
						 ],
				borderWidth : 1
			},{
				label : '回收垃圾',
				data : [${number_R}],
				backgroundColor : [ 
						'rgba(54, 162, 235, 0.2)' ],
				borderColor : [
						'rgba(54, 162, 235, 1)' ],
				borderWidth : 1
			} ],
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
	
	 var timea = [];
	 var classa = [];
	 
	<%
	List<RNclass> Classes = (ArrayList<RNclass>) request.getAttribute("Classes");
	for (RNclass Class : Classes) {
		
		
%>
			timea.push("<%=Class.getTime()%>")
			classa.push("<%=Class.getType()%>")

	       <%
	}
%>	       
	       console.log(timea);
	       console.log(classa);
	       
	       //bottle
	       bottle = []
	       function checkbottle() {
		          for (i=0;i<classa.length;i++){
		        	  if(classa[i] == "bottle") {
		        		  console.log(timea[i].slice(5,10));
		        		  bottle.push(timea[i].slice(5,10));
		        	  };
		          };
		      }
	       bottle.sort()
	       bottlenum =[]
	       checkbottle();
	       
	       console.log(bottle.sort());

    	   var by1 = 0
    	   var by2 = 0
    	   var by3 = 0
    	   var by4 = 0
    	   var by5 = 0
    	   var by6 = 0
  

    	   function bottlenumber() {   
	       for (i=0;i<bottle.length;i++){
	    	   
	    	   if(bottle[i].slice(3,5) <= 3){
	    		   console.log("by1="+bottle[i])
	    		   by1++
	    	   }else if( 3 < bottle[i].slice(3,5) & bottle[i].slice(3,5) <= 9 ){
	    		   console.log("by2="+bottle[i].slice(3,5))
	    		   by2++
	    	   }else if( 9 < bottle[i].slice(3,5) & bottle[i].slice(3,5) <= 15 ){
	    		   console.log("by3="+bottle[i].slice(3,5))
	    		   by3++
	    	   }else if( 15 < bottle[i].slice(3,5) & bottle[i].slice(3,5) <= 21 ){
	    		   console.log("by4="+bottle[i].slice(3,5))
	    		   by4++
	    	   }else if( 21 < bottle[i].slice(3,5) & bottle[i].slice(3,5) <= 28 ){
	    		   console.log("by5="+bottle[i].slice(3,5))
	    		   by5++
	    	   } else {
	    		   console.log("by6="+bottle[i].slice(3,5))
	    		   by6++
	    	   }
	          }};
	          
	          bottlenumber()      
	    	   bottlenum.push(by1);
	    	   bottlenum.push(by2);
	    	   bottlenum.push(by3);
	    	   bottlenum.push(by4);
	    	   bottlenum.push(by5);
	    	   bottlenum.push(by6);
	    	   console.log(bottlenum)

	    	  
	    	//can
	       can = []
	       function checkcan() {
		          for (i=0;i<classa.length;i++){
		        	  if(classa[i] == "can") {
		        		  console.log(timea[i].slice(5,10));
		        		  can.push(timea[i].slice(5,10));
		        	  };
		          };
		      }
		   can.sort()
	       cannum =[]
	       checkcan();
	       
	       console.log("can"+can.sort());

    	   var cy1 = 0
    	   var cy2 = 0
    	   var cy3 = 0
    	   var cy4 = 0
    	   var cy5 = 0
    	   var cy6 = 0
  

    	   function cannumber() {   
	       for (i=0;i<can.length;i++){
	    	   
	    	   if(can[i].slice(3,5) <= 3){
	    		   console.log("cy1="+can[i])
	    		   cy1++
	    	   }else if( 3 < can[i].slice(3,5) & can[i].slice(3,5) <= 9 ){
	    		   console.log("cy2="+can[i].slice(3,5))
	    		   cy2++
	    	   }else if( 9 < can[i].slice(3,5) & can[i].slice(3,5) <= 15 ){
	    		   console.log("cy3="+can[i].slice(3,5))
	    		   cy3++
	    	   }else if( 15 < can[i].slice(3,5) & can[i].slice(3,5) <= 21 ){
	    		   console.log("cy4="+can[i].slice(3,5))
	    		   cy4++
	    	   }else if( 21 < can[i].slice(3,5) & can[i].slice(3,5) <= 28 ){
	    		   console.log("cy5="+can[i].slice(3,5))
	    		   cy5++
	    	   }else {
	    		   console.log("cy6="+can[i].slice(3,5))
	    		   cy6++
	    	   }
	          }};
	          
	          cannumber()      
	    	  cannum.push(cy1);
	          cannum.push(cy2);
	          cannum.push(cy3);
	          cannum.push(cy4);
	          cannum.push(cy5);
	          cannum.push(cy6);
	    	  console.log(cannum)	


	       //battery
	       battery = []
	       function checkbattery() {
		          for (i=0;i<classa.length;i++){
		        	  if(classa[i] == "battery") {
		        		  console.log(timea[i].slice(5,10));
		        		  battery.push(timea[i].slice(5,10));
		        	  };
		          };
		      }
	       battery.sort()
	       batterynum =[]
	       checkbattery();
	       
	       console.log(battery.sort());

    	   var bay1 = 0
    	   var bay2 = 0
    	   var bay3 = 0
    	   var bay4 = 0
    	   var bay5 = 0
    	   var bay6 = 0
  

    	   function batterynumber() {   
	       for (i=0;i<battery.length;i++){
	    	   
	    	   if(battery[i].slice(3,5) <= 3){
	    		   console.log("bay1="+battery[i])
	    		   bay1++
	    	   }else if( 3 < battery[i].slice(3,5) & battery[i].slice(3,5) <= 9){
	    		   console.log("bay2="+battery[i].slice(3,5))
	    		   bay2++
	    	   }else if( 9 < battery[i].slice(3,5) & battery[i].slice(3,5) <= 15 ){
	    		   console.log("bay3="+battery[i].slice(3,5))
	    		   bay3++
	    	   }else if( 15 < battery[i].slice(3,5) & battery[i].slice(3,5) <= 21 ){
	    		   console.log("bay4="+battery[i].slice(3,5))
	    		   bay4++
	    	   }else if( 24 < battery[i].slice(3,5) & battery[i].slice(3,5) <= 28 ){
	    		   console.log("bay5="+battery[i].slice(3,5))
	    		   bay5++
	    	   }else {
	    		   console.log("bay6="+battery[i].slice(3,5))
	    		   bay6++
	    	   }
	          }};
	          
	          batterynumber()      
	    	  batterynum.push(bay1);
	          batterynum.push(bay2);
	          batterynum.push(bay3);
	          batterynum.push(bay4);
	          batterynum.push(bay5);
	          batterynum.push(bay6);
	    	  console.log(batterynum)
	    	  
	       //paper
	       paper = []
	       function checkpaper() {
		          for (i=0;i<classa.length;i++){
		        	  if(classa[i] == "paper") {
		        		  console.log(timea[i].slice(5,10));
		        		  paper.push(timea[i].slice(5,10));
		        	  };
		          };
		      }
	       paper.sort()
	       papernum =[]
	       checkpaper();
	       
	       console.log(paper.sort());

    	   var py1 = 0
    	   var py2 = 0
    	   var py3 = 0
    	   var py4 = 0
    	   var py5 = 0
    	   var py6 = 0
  

    	   function papernumber() {   
	       for (i=0;i<paper.length;i++){
	    	   
	    	   if(paper[i].slice(3,5) <= 3){
	    		   console.log("py1="+paper[i])
	    		   py1++
	    	   }else if( 3 < paper[i].slice(3,5) & paper[i].slice(3,5) <= 9 ){
	    		   console.log("py2="+paper[i].slice(3,5))
	    		   py2++
	    	   }else if( 9 < paper[i].slice(3,5) & paper[i].slice(3,5) <= 15 ){
	    		   console.log("py3="+paper[i].slice(3,5))
	    		   py3++
	    	   }else if( 15 < paper[i].slice(3,5) & paper[i].slice(3,5) <= 21 ){
	    		   console.log("py4="+paper[i].slice(3,5))
	    		   py4++
	    	   }else if( 21 < paper[i].slice(3,5) & paper[i].slice(3,5) <= 28 ){
	    		   console.log("py4="+paper[i].slice(3,5))
	    		   py5++
	    	   }else {
	    		   console.log("py5="+battery[i].slice(3,5))
	    		   py6++
	    	   }
	          }};
	          
	          papernumber()      
	    	  papernum.push(py1);
	          papernum.push(py2);
	          papernum.push(py3);
	          papernum.push(py4);
	          papernum.push(py5);
	          papernum.push(py6);
	    	  console.log(papernum)
	    	  
	       //trash
	       trash = []
	       function checktrash() {
		          for (i=0;i<classa.length;i++){
		        	  if(classa[i] == "trash") {
		        		  console.log(timea[i].slice(5,10));
		        		  trash.push(timea[i].slice(5,10));
		        	  };
		          };
		      }
	    	  trash.sort()
	       trashnum =[]
	       checktrash();
	       
	       console.log(trash.sort());

    	   var ty1 = 0
    	   var ty2 = 0
    	   var ty3 = 0
    	   var ty4 = 0
    	   var ty5 = 0
    	   var ty6 = 0
  

    	   function trashnumber() {   
	       for (i=0;i<trash.length;i++){
	    	   
	    	   if(trash[i].slice(3,5) <= 3){
	    		   console.log("ty1="+trash[i])
	    		   ty1++
	    	   }else if( 3 < trash[i].slice(3,5) & trash[i].slice(3,5) <= 9 ){
	    		   console.log("ty2="+trash[i].slice(3,5))
	    		   ty2++
	    	   }else if( 9 < trash[i].slice(3,5) & trash[i].slice(3,5) <= 15 ){
	    		   console.log("ty3="+trash[i].slice(3,5))
	    		   ty3++
	    	   }else if( 15 < trash[i].slice(3,5) & trash[i].slice(3,5) <= 21 ){
	    		   console.log("ty4="+trash[i].slice(3,5))
	    		   ty4++
	    	   }else if( 21 < trash[i].slice(3,5) & trash[i].slice(3,5) <= 28 ){
	    		   console.log("ty5="+trash[i].slice(3,5))
	    		   ty5++
	    	   }else {
	    		   console.log("ty6="+trash[i].slice(3,5))
	    		   ty6++
	    	   }
	          }};
	          
	          trashnumber()      
	    	  trashnum.push(ty1);
	          trashnum.push(ty2);
	          trashnum.push(ty3);
	          trashnum.push(ty4);
	          trashnum.push(ty5);
	          trashnum.push(ty6);
	    	  console.log(trashnum)
	    	  
	var chart2 = new Chart(ctx2,
			{
				type : 'line',
				data : {
					labels : ["12/01", "12/6", "12-/12", "12/18", "12/24", "12-31"],
					datasets : [ {
						label : '寶特瓶',
						backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
						],
						borderColor : [ 'rgba(255,99,132,1)',
								],
						data : bottlenum,
						fill : false,
					},{
						label : '鐵鋁罐', 
						backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
						],
						borderColor : [ 'rgba(54, 162, 235, 1)',
								],
						data : cannum,
						fill : false,
					},{
						label : '電池', 
						backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
						],
						borderColor : [ 'rgba(75, 192, 192, 1)',
								],
						data : batterynum,
						fill : false,
					},{
						label : '紙類', 
						backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
						],
						borderColor : [ 'rgba(255, 206, 86, 1)',
								],
						data : papernum,
						fill : false,
					},{
						label : '一般垃圾',
						backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
						],
						borderColor : [ 'rgba(153, 102, 255, 1)',
								],
						data : trashnum,
						fill : false,
					} ]
				},
				options: {
	                responsive: true,
	                maintainAspectRatio: false,
	                scales: {
	                    yAxes: [{
	                        ticks: {
	                            suggestedMin: 0,
	                            suggestedMax: 5,
	                            stepSize: 1
	                        }
	                    }]	                    
	                }
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