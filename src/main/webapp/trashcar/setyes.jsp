<%@page import="trashcar.bean.TrashCarRecordBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*,trashcar.bean.TrashCarRecordBean,trashcar.bean.TrashCarBean"%>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
        integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="./scss/loadingpage.css">
    <link rel="stylesheet" href="./scss/set.css">
    <link rel="stylesheet" media="screen and  (max-width: 780px)" href="./scss/set780.css" />
    <link rel="stylesheet" href="./scss/button.css">
    <title>設定</title>
    <style>

    </style>
</head>

<body>
<div id="loadingPage"><img id="loading-image" src="./pic/giphy.gif" alt="Loading..." /></div>
    <div id="div1">
        <h1>設定</h1>
        <form class="form1" method="post" action="./GetCarsToDB">
            <fieldset>
                <legend>GPS</legend>
                
                 
                <label for="GPS"></label>
                <input type="button" class="fbutton" onclick="getLocation()" value="查詢當前位置" >
                <span id="showPosition"></span><br>
                
                <div>
                	<iframe id="gmframe" width="360" height="240" frameborder="0" scrolling="no" marginheight="0"
                    		marginwidth="0" src="https://maps.google.com/?output=embed&amp;q=23.973837,120.9775031">
                    </iframe>
                    <br><br>
            		<input type="hidden" name="lat" id="lat">
            		<input type="hidden" name="lng" id="lng">               
                </div>
                
                <label for="gt" class="labelt">垃圾車選擇:</label><br>
                        
                <div class="gps">
                	<input type="radio" id="gt1" name="gt" value="1">
                
                
                
                
                
                
                	<label for="gt1" id="lgt1" class="labels">預計抵達時間:<span id="pgt1"></span></label>
                	<iframe id="gt1frame" width="360" height="240" frameborder="0" scrolling="no" marginheight="0"
                    		marginwidth="0" src="https://maps.google.com/?output=embed&amp;q=23.973837,120.9775031">
                    </iframe>
                    
                    
                    
                    
                </div>
                     
                <div class="gps">
                	<input type="radio" id="gt2" name="gt" value="2">
                	
                	
                	
                	
                	
                	
                	<label for="gt2" id="lgt2" class="labels">預計抵達時間:<span id="pgt2"></span></label>
                	<iframe id="gt2frame" width="360" height="240" frameborder="0" scrolling="no" marginheight="0"
                    		marginwidth="0" src="https://maps.google.com/?output=embed&amp;q=23.973837,120.9775031">
                    </iframe>
                    
                    
                    
                    
                </div>
                
                <div class="gps">
                	<input type="radio" id="gt3" name="gt" value="3">
                	
                	
                	
                	
	                <label for="gt3" id="lgt3" class="labels">預計抵達時間:<span id="pgt3"></span></label>
	                <iframe id="gt3frame" width="360" height="240" frameborder="0" scrolling="no" marginheight="0"
                    		marginwidth="0" src="https://maps.google.com/?output=embed&amp;q=23.973837,120.9775031">
                    </iframe>
                    
                    
                    
                    
                </div>
                <div class="setyessubmit">
 				<input type="submit" class="fbutton"   value="設定完成">
 				</div>           
            </fieldset>

        </form>
        <a href="./index.html"><button class="button">回首頁</button></a><br>
    </div>


    <script>
    
    window.addEventListener("load" ,function () {
        $('#loadingPage').hide();
        $('#loading-image').hide();
        console.log("load")
    });    

    	var time
    	var datas=null;
        var map, marker, lat, lng;
        
        function getLocation() {//取得 經緯度
            if (navigator.geolocation) {//
                navigator.geolocation.getCurrentPosition(showPosition);//有拿到位置就呼叫 showPosition 函式
            } else {
                document.getElementById("showPosition").innerHTML = "您的瀏覽器不支援 顯示地理位置 API ，請使用其它瀏覽器開啟 這個網址";
            }
        }

        function showPosition(position) {
            document.getElementById("showPosition").innerHTML="成功"
            // document.getElementById("showPosition").innerHTML=" 緯度 (Latitude): 25.033934 經度(Longitude): 121.543409" ;

            // document.getElementById("showPosition").innerHTML = " 緯度 (Latitude): " + position.coords.latitude +
            //     "經度(Longitude): " + position.coords.longitude;
            console.log("緯度 (Latitude): " + position.coords.latitude +
                		"經度(Longitude): " + position.coords.longitude);
            document.getElementById("gmframe").src = "https://maps.google.com/?output=embed&q=" +  position.coords.latitude + "," + position.coords.longitude;
    	    lat=document.getElementById("lat");
    	    lat.value=position.coords.latitude;
            console.log(lat);
    	    console.log("input: ",lat)
    	    lng=document.getElementById("lng");
    	    lng.value=position.coords.longitude;
            console.log(lng);
			console.log("input: ",lng);
			
            req = './GetAllTrashCar?lat=' + position.coords.latitude + "&lng=" + position.coords.longitude;
			
            console.log(req);
            		
            fetch(req, {})
            .then((res) => {
            	console.log(res);
                return res.json(); 
            }).then((data) => {
              	console.log("In fetch: " + data);
              	datas=data;
              	document.querySelector("#gt1frame").src = "https://maps.google.com/?output=embed&q=" + data[0]['Lat']  + "," +data[0]['Lng'] ;
              	document.querySelector("#gt2frame").src = "https://maps.google.com/?output=embed&q=" + data[1]['Lat']  + "," +data[1]['Lng'] ;
              	document.querySelector("#gt3frame").src = "https://maps.google.com/?output=embed&q=" + data[2]['Lat']  + "," +data[2]['Lng'] ;
              	
              	var time1 = datas[0]['CarTimeStart'];
              	var time2 = datas[1]['CarTimeStart'];
              	var time3 = datas[2]['CarTimeStart'];
              	var b = ":";
              	var position = 2;
              	var output1 = [time1.slice(0, position), b, time1.slice(position)].join('');
              	//console.log(output1);
              	var output2 = [time2.slice(0, position), b, time2.slice(position)].join('');
              	//console.log(output2);
              	var output3 = [time3.slice(0, position), b, time3.slice(position)].join('');
              	//console.log(output3);
              	
              	document.querySelector("#pgt1").innerHTML = output1;
              	document.querySelector("#pgt2").innerHTML = output2;
              	document.querySelector("#pgt3").innerHTML = output3;
              	
              	form = document.querySelector("form");
              	for (n in datas){
              		for (par in datas[n]){
              			par_name = par + "" + (Number(n)+1)
              			input = document.getElementsByName(par_name)[0]
              			if (input === undefined) {
              				input = document.createElement("input")
              				input.name = par_name;
              				input.type = "hidden"
              			}
              			input.value = datas[n][par]
              			console.log("input:", input);
              			form.appendChild(input)
              		}
              	}
              	console.log("form:", form)
			}).catch((err) => {
                console.log('錯誤:', err);
            });
            console.log("Out fetch: " + datas);
		}
       	function getradio(){
       		if(document.querySelector('input[name="gt"]:checked')==null)
       			console.log("error")
       		else
       			console.log("success")
    		
       	}
        
    </script>
</body>

</html>