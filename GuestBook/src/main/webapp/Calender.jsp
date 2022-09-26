<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calender</title>
</head>
<body>
<style>
		body{
             width: 800px;
             margin: 0 auto;
             text-align: center;
            }
    
        header{
             height: 100px;
             border-bottom: 1px solid black;
             margin: 10px;
            }
    
        .headerbtn{
             text-align: right;
             margin-top: 10px;
            }
    	a { color:#000000;text-decoration:none; }
    	.scriptCalendar { text-align:center; }
    	.scriptCalendar > thead > tr > td { width:50px;height:50px; }
    	.scriptCalendar > thead > tr:first-child > td { font-weight:bold; }
    	.scriptCalendar > thead > tr:last-child > td { background-color:#90EE90; }
    	.scriptCalendar > tbody > tr > td { width:50px;height:50px; }
</style>
<img src="img/rogo.png" onclick="location.href='index.jsp'" style="width: 10vw">
        <div class="headerbtn">
            <header>
            	<button onclick="location.href='index.jsp'">홈 </button>
                <button onclick="location.href='List.jsp'">목록</button>
                <button onclick="location.href='Calender.jsp'">캘린더</button>
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
        document.getElementById("calYear").innerText = today.getFullYear();                                  // @param YYYY월
        document.getElementById("calMonth").innerText = autoLeftPad((today.getMonth() + 1), 2);   // @param MM월

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

                if(dom % 7 == 1) {
                    column.style.color = "#FF4D4D";
                }

                if(dom % 7 == 0) {
                    column.style.color = "#4D4DFF";
                    row = tbCalendar.insertRow(); 
                }
            }
            else {
                let exceptDay = new Date(doMonth.getFullYear(), doMonth.getMonth(), day);
                column.innerText = autoLeftPad(exceptDay.getDate(), 2);
                column.style.color = "#A9A9A9";
            }
            if(today.getFullYear() == date.getFullYear()) {

                if(today.getMonth() == date.getMonth()) {
                    if(date.getDate() > day && Math.sign(day) == 1) {
                        column.style.backgroundColor = "#E5E5E5";
                    }
                    else if(date.getDate() < day && lastDate.getDate() >= day) {
                        column.style.backgroundColor = "#FFFFFF";
                        column.style.cursor = "pointer";
                        column.onclick = function(){ calendarChoiceDay(this); }
                    }
                    else if(date.getDate() == day) {
                        column.style.backgroundColor = "#FFFFE6";
                        column.style.cursor = "pointer";
                        column.onclick = function(){ calendarChoiceDay(this); }
                    }
                } else if(today.getMonth() < date.getMonth()) {
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
        column.style.backgroundColor = "#FF9999";
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
</body>
</html>