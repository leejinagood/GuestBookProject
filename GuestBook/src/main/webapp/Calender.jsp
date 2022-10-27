<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calender</title>
</head>
<a href="https://dept.daelim.ac.kr/com/index.do"><img class="daelim" src="img/daelim.png" ></a><br><br>
<link rel="stylesheet" href="Calender.css">
<body>
<img src="img/rogoimg.png" onclick="location.href='index.jsp'" style="width: 10vw">
        <div class="headerbtn">
            <header>
            <button class="btn1"  onclick="location.href='index.jsp'">홈 </button>
            	<button class="btn1" onclick="location.href='List.jsp'">목록</button>
                <button class="btn1" id="btn_main" onclick="location.href='Calender.jsp'">캘린더</button>
            </header>
         </div> 
    <script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        buildCalendar();
    });
    var today = new Date(); 
    var date = new Date(); 

    function prevCalendar() {
        this.today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
        buildCalendar();    
    }
    function nextCalendar() {
        this.today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
        buildCalendar();    
    }
    function buildCalendar() {

        let doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
        let lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
        let tbCalendar = document.querySelector(".scriptCalendar > tbody");
        document.getElementById("calYear").innerText = today.getFullYear();       // 파라미터 YYYY월
        document.getElementById("calMonth").innerText = autoLeftPad((today.getMonth() + 1), 2);   // 파라미터  MM월

        while(tbCalendar.rows.length > 0) {
            tbCalendar.deleteRow(tbCalendar.rows.length - 1);
        }

        let row = tbCalendar.insertRow();

        let dom = 1;

        let daysLength = (Math.ceil((doMonth.getDay() + lastDate.getDate()) / 7) * 7) - doMonth.getDay();

        for(let day = 1 - doMonth.getDay(); daysLength >= day; day++) {

            let column = row.insertCell();

            if(Math.sign(day) == 1 && lastDate.getDate() >= day) {

                column.innerText = autoLeftPad(day, 2);
 
                if(dom % 7 == 1) { //토요일 
                    column.style.color = "#F08080"; 
                }

                if(dom % 7 == 0) { //일요일 
                    column.style.color = "#2F4F4F";
                    row = tbCalendar.insertRow(); 
                }
            }
            else { //월에 벗어난 다른 일수 
                let exceptDay = new Date(doMonth.getFullYear(), doMonth.getMonth(), day);
                column.innerText = autoLeftPad(exceptDay.getDate(), 2);
                column.style.color = "#DCDCDC";
            }
            if(today.getFullYear() == date.getFullYear()) {

                if(today.getMonth() == date.getMonth()) {
                    if(date.getDate() > day && Math.sign(day) == 1) {
                        column.style.backgroundColor = "#AFEEEE"; //월에 해당하는 요일 배경
                    }
                    else if(date.getDate() < day && lastDate.getDate() >= day) {
                        column.style.backgroundColor = "#FFFFFF";
                        column.style.cursor = "pointer";
                        column.onclick = function(){ calendarChoiceDay(this); }
                    }
                    else if(date.getDate() == day) { //오늘 
                    	
                        column.style.backgroundColor = "#E0FFFF";
                        column.style.cursor = "pointer";
                        column.onclick = function(){ calendarChoiceDay(this); 
                        
                        }
                    }
                } else if(today.getMonth() < date.getMonth()) {
                    if(Math.sign(day) == 1 && day <= lastDate.getDate()) {
                        column.style.backgroundColor = "#E5E5E5"; //날짜가ㅏ 지나버린 요일 배경 색 
                    }
                }
                else {
                    if(Math.sign(day) == 1 && day <= lastDate.getDate()) {
                        column.style.backgroundColor = "#FFFFFF";
                        column.style.cursor = "pointer";
                        column.onclick = function(){ calendarChoiceDay(this); }
                    }
                }
            }
            else if(today.getFullYear() < date.getFullYear()) {
                if(Math.sign(day) == 1 && day <= lastDate.getDate()) {
                    column.style.backgroundColor = "#E5E5E5";
                }
            }
            else {
                if(Math.sign(day) == 1 && day <= lastDate.getDate()) {
                    column.style.backgroundColor = "#FFFFFF";
                    column.style.cursor = "pointer";
                    column.onclick = function(){ calendarChoiceDay(this); }
                }
            }
            dom++;
        }
    }
    function calendarChoiceDay(column) {
        if(document.getElementsByClassName("choiceDay")[0]) {
            document.getElementsByClassName("choiceDay")[0].style.backgroundColor = "#FFFFFF";
            document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");
        }
        column.style.backgroundColor = "#FFB6C1"; //클릭했을 때 배경색 
        column.classList.add("choiceDay");
    }
    function autoLeftPad(num, digit) {
        if(String(num).length < digit) {
            num = new Array(digit - String(num).length + 1).join("0") + num;
        }
        return num;
    }
</script>
</head>
<body>
<div>
<table class="scriptCalendar">
    <thead>
        <tr>
            <td onClick="prevCalendar();" style="cursor:pointer;">&#60;&#60;</td>
            <td colspan="5">
                <span id="calYear">YYYY</span>년
                <span id="calMonth">MM</span>월
            </td>
            <td onClick="nextCalendar();" style="cursor:pointer;">&#62;&#62;</td>
        </tr>
        <tr>
            <td>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td>
        </tr>
    </thead>
    <tbody></tbody>
</table>
</div>   
<br><br><br>
</body>
</html>