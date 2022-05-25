<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import = "java.util.Vector"%>
<%@ page import = "java.util.*"%>
<%

    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id_value");
    String YM = request.getParameter("YearMonth");
    String positionNum = request.getParameter("position");

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/worker_account",
        "yj",
        "0908"
    );

    char quotes = '"';

    String sql3 = "SELECT * FROM account";
    PreparedStatement query3 = conn.prepareStatement(sql3);
    ResultSet result3 = query3.executeQuery();
    Vector<Vector<String>> workerList = new Vector<Vector<String>>();
    while(result3.next()) {
        Vector<String> list = new Vector<String>();
        String string1 = result3.getString(1);
        String string2 = result3.getString(2);
        String string3 = result3.getString(3);
        list.add(quotes + string1 + quotes);
        list.add(quotes + string2 + quotes);
        list.add(quotes + string3 + quotes);
        workerList.add(list);
    }


    String sql = "SELECT * FROM account WHERE userId=?";
    PreparedStatement query = conn.prepareStatement(sql);
    query.setString(1, id);

    ResultSet result = query.executeQuery();

    String[] data = new String[4];
    while(result.next()) {
        data[0] = result.getString("userId");
        data[1] = result.getString("userPassword");
        data[2] = result.getString("name");
        data[3] = result.getString("position");
    }

    String sql2 = "SELECT * FROM schedule WHERE userId=? and YearMonth=?";
    PreparedStatement query2 = conn.prepareStatement(sql2);
    query2.setString(1, id);
    query2.setString(2, YM);
    ResultSet result2 = query2.executeQuery();
    Vector<Vector<String>> vecdate = new Vector<Vector<String>>();
    int t = 0;
    while (result2.next()) {
        Vector<String> list = new Vector<String>();
        String string1 = result2.getString(4);
        String string2 = result2.getString(5);
        String string3 = result2.getString(6);
        String string4 = result2.getString(7);
        String string5 = result2.getString(2);
        list.add(quotes + string1 + quotes);
        list.add(quotes + string2 + quotes);
        list.add(quotes + string3 + quotes);
        list.add(quotes + string4 + quotes);
        list.add(quotes + string5 + quotes);
        vecdate.add(list);
    }

%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Page</title>
    <link rel="stylesheet" type="text/css" href="main.css?after">
</head>
<body>
    <div id="nav">
        <input type="button" value="<" onclick="closeNav()" id="closeNavButton">
        <p>직원목록</p>
        <hr>
    </div>
    
    <header>
        <div id="menuButton" onclick="showNav()">
            <div class="menuButtonComponent"></div>
            <div class="menuButtonComponent"></div>
            <div class="menuButtonComponent"></div>
        </div>
        <p id="logo">Daily</p>
        <div>
            <p class="userInfo">아이디: <%=data[0]%> </p>
            <p class="userInfo">직책: <span id="position"></span></p>
        </div>
    </header>
    <div id="changeYM">
        <input type="button" value="<" onclick="minusMonth()" class="changeMonth">
        <span id="yearMonth"></span>
        <input type="button" value=">" onclick="plusMonth()" class="changeMonth">
    </div>
    <div id="scheduleList"></div>
    <div>
        <input type="button" value="일정 추가" id = "addSchedule" onclick="addSchedule()">
        <form id="scheduleForm" action="addScheduleModule.jsp" onsubmit="return checkForm(this)" method="post">
            <span>날짜:</span>
            <input type="date" name="date" id="date" class="dateOrTime">
            <input type="time" name="startTime" id="startTime" class="dateOrTime">
            <span>-</span>
            <input type="time" name="endTime" id="endTime" class="dateOrTime">
            <input type="text" name="schedule" placeholder="일정을 입력하세요" id="newPlan">
            <input type="hidden" name="userId" value="<%=id%>">
            <input type="hidden" name="currentYM" value="<%=YM%>">
            <input type="hidden" name="position" value="<%=positionNum%>">
            <input type="submit" value="적용" class="applyOrCancelButton">
            <input type="button" value="취소" onclick="cancelAddSchedule()" class="applyOrCancelButton">
        </form>
    </div>
</body>
<script>

    var tmp = <%=vecdate%>;
    var workerList = <%=workerList%>;

    for(var a=0; a<workerList.length; a++) {
        for(var b = 0; b<workerList[a].length; b++) {
            console.log(workerList[a][b]);
        }
    }
    workerList.sort((a, b)=>{return b[1]-a[1]});

    for(var a=0; a<tmp.length; a++) {
        for(var b = 0; b<tmp[a].length; b++) {
            console.log(tmp[a][b]);
        }
    }
    tmp.sort((a, b)=> {if(a[0] == b[0]) {
        var T = a[1].split(":");
        var T2 = b[1].split(":");
        return (T[0] + T[1]) - (T2[0] + T2[1]);
        }
        else {
            return a[0]-b[0];
        }
    });

    var list = document.getElementById("scheduleList");
    for(var index=0; index<tmp.length; index++) {
        var newDiv = document.createElement("div");
        newDiv.setAttribute("class", "scheduleListComponent");
        var showenForm = document.createElement("span");
        showenForm.setAttribute("class", "showenScheduleList");
        for(var ind=0; ind<4; ind++) {
            var newSpan = document.createElement("span");
            newSpan.setAttribute("id", "span[" + tmp[index][4] + "][" + ind + "]");
            newSpan.innerHTML= tmp[index][ind];
            showenForm.appendChild(newSpan);
            if(ind==0) {
                var gap = document.createElement("span");
                gap.innerHTML = "일 ";
                showenForm.appendChild(gap);
            }
            else if(ind==1) {
                var cutTime = tmp[index][ind].split(":");
                newSpan.innerHTML = cutTime[0] + ":" + cutTime[1];
                var gap = document.createElement("span");
                gap.setAttribute("id", "span[" + tmp[index][4] + "][" + ind + "]-");
                gap.innerHTML = "-";
                showenForm.appendChild(gap);
            }
            else if(ind==2) {
                var cutTime = tmp[index][ind].split(":");
                newSpan.innerHTML = cutTime[0] + ":" + cutTime[1];
                var newLine = document.createElement("br");
                newLine.setAttribute("id", "span[" + tmp[index][4] + "][" + ind + "]br");
                showenForm.appendChild(newLine);
                var gap = document.createElement("span");
                gap.setAttribute("id", "span[" + tmp[index][4] + "][" + ind + "]일정:");
                gap.innerHTML = "일정:";
                showenForm.appendChild(gap);
            }

        }
        newDiv.appendChild(showenForm);
        var hiddenForm = document.createElement("form");
        hiddenForm.setAttribute("charset", "UTF-8");
        hiddenForm.setAttribute("method", "Post");
        hiddenForm.setAttribute("action", "modifyScheduleModule.jsp");
        hiddenForm.setAttribute("onsubmit", "return checkModify('"+tmp[index][4]+"')");
        hiddenForm.setAttribute("id", tmp[index][4]);
        hiddenForm.setAttribute("class", "hiddenModifySchedule");
        hiddenForm.style.display = "none";
        newDiv.appendChild(hiddenForm);
        var hiddenUserId = document.createElement("input");
        hiddenUserId.setAttribute("type", "hidden");
        hiddenUserId.setAttribute("name", "userId");
        hiddenUserId.setAttribute("value", "<%=id%>");
        hiddenForm.appendChild(hiddenUserId);
        var hiddenYM = document.createElement("input");
        hiddenYM.setAttribute("type", "hidden");
        hiddenYM.setAttribute("name", "curYM");
        hiddenYM.setAttribute("value", "<%=YM%>");
        hiddenForm.appendChild(hiddenYM);
        var hiddenPos = document.createElement("input");
        hiddenPos.setAttribute("type", "hidden");
        hiddenPos.setAttribute("name", "myPos");
        hiddenPos.setAttribute("value", "<%=positionNum%>");
        hiddenForm.appendChild(hiddenPos);

        var hiddenStartTime = document.createElement("input");
        hiddenStartTime.setAttribute("type", "time");
        hiddenStartTime.setAttribute("name", "startTime");
        hiddenStartTime.setAttribute("class", "timeOrPlan");
        hiddenStartTime.setAttribute("id", "startTime" + tmp[index][4]);
        hiddenStartTime.setAttribute("value", tmp[index][1]);
        hiddenForm.appendChild(hiddenStartTime);
        var hiddenHyphen = document.createElement("span");
        hiddenHyphen.innerHTML = "-";
        hiddenForm.appendChild(hiddenHyphen);
        var hiddenEndTime = document.createElement("input");
        hiddenEndTime.setAttribute("type", "time");
        hiddenEndTime.setAttribute("name", "endTime");
        hiddenEndTime.setAttribute("class", "timeOrPlan");
        hiddenEndTime.setAttribute("id", "endTime" + tmp[index][4]);
        hiddenEndTime.setAttribute("value", tmp[index][2]);
        hiddenForm.appendChild(hiddenEndTime);
        var hiddenText = document.createElement("span");
        hiddenText.innerHTML = "일정:";
        hiddenForm.appendChild(hiddenText);
        var hiddenPlan = document.createElement("input");
        hiddenPlan.setAttribute("type", "text");
        hiddenPlan.setAttribute("name", "plan");
        hiddenPlan.setAttribute("class", "timeOrPlan");
        hiddenPlan.setAttribute("id", "plan" + tmp[index][4]);
        hiddenPlan.setAttribute("value", tmp[index][3]);
        hiddenForm.appendChild(hiddenPlan);
        var scheduleId = document.createElement("input");
        scheduleId.setAttribute("type", "hidden");
        scheduleId.setAttribute("name", "scheduleId");
        scheduleId.setAttribute("value", tmp[index][4]);
        hiddenForm.appendChild(scheduleId);
        var applyButton = document.createElement("input");
        applyButton.setAttribute("type", "submit");
        applyButton.setAttribute("value", "적용");
        applyButton.setAttribute("class", "applyOrCancelButton");
        hiddenForm.appendChild(applyButton);
        var cancelButton = document.createElement("input");
        cancelButton.setAttribute("type", "button");
        cancelButton.setAttribute("value", "취소");
        cancelButton.setAttribute("class", "applyOrCancelButton");
        cancelButton.setAttribute("onclick", "cancelModify('"+tmp[index][4]+"')");  
        hiddenForm.appendChild(cancelButton);

        var buttons = document.createElement("span");
        var modifyButton = document.createElement("input");
        modifyButton.setAttribute("type", "button");
        modifyButton.setAttribute("value", "수정");
        modifyButton.setAttribute("class", "modifyButton");
        modifyButton.setAttribute("onclick", "modifySchedule('"+tmp[index][4]+"')");
        buttons.appendChild(modifyButton);
        var deleteButton = document.createElement("input");
        deleteButton.setAttribute("type", "button");
        deleteButton.setAttribute("value", "삭제");
        deleteButton.setAttribute("class", "deleteButton");
        deleteButton.setAttribute("onclick", "deleteSchedule('"+tmp[index][4]+"')");
        buttons.appendChild(deleteButton);
        newDiv.appendChild(buttons);
        list.appendChild(newDiv);
    }
    function checkModify(id) {
        var startTime = document.getElementById("startTime" + id).value;
        var endTime = document.getElementById("endTime" + id).value;
        var sT = startTime.split(":");
        var eT = endTime.split(":");
        if(parseInt(sT[0] + sT[1]) > parseInt(eT[0] + eT[1])) {
            alert("올바른 시간을 입력하세요");
            return false;
        }
        if(confirm("일정을 변경하시겠습니까?") == true) {
            return true;
        }
        else {
            return false;
        }
    }

    function modifySchedule(id) {
        var hidForm1 = document.getElementById("span[" + id + "][1]");
        var hidForm2 = document.getElementById("span[" + id + "][2]");
        var hidForm3 = document.getElementById("span[" + id + "][3]");
        var hidForm4 = document.getElementById("span[" + id + "][1]-");
        var hidForm5 = document.getElementById("span[" + id + "][2]br");
        var hidForm6 = document.getElementById("span[" + id + "][2]일정:");
        var hidModifyButton = document.getElementsByClassName("modifyButton");
        for(var i = 0; i<hidModifyButton.length; i++) {
            var arr = hidModifyButton.item(i);
            arr.style.display = "none";
        }
        var hidDeleteButton = document.getElementsByClassName("deleteButton");
        for(var i = 0; i<hidDeleteButton.length; i++) {
            var arr = hidDeleteButton.item(i);
            arr.style.display = "none";
        }
        var thisForm = document.getElementById(id);
        hidForm1.style.display = "none";
        hidForm2.style.display = "none";
        hidForm3.style.display = "none";
        hidForm4.style.display = "none";
        hidForm5.style.display = "none";
        hidForm6.style.display = "none";
        thisForm.style.display = "inline";
    }

    function deleteSchedule(id) {
        if(confirm("일정을 삭제하시겠습니까?") == true) {
            var form = document.createElement("form");
            form.setAttribute("charset", "UTF-8");
            form.setAttribute("method", "Post");
            form.setAttribute("action", "deleteScheduleModule.jsp");

            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", "userId");
            hiddenField.setAttribute("value", "<%=id%>");
            form.appendChild(hiddenField);
            var hiddenYM = document.createElement("input");
            hiddenYM.setAttribute("type", "hidden");
            hiddenYM.setAttribute("name", "YearMonth");
            hiddenYM.setAttribute("value", "<%=YM%>");
            form.appendChild(hiddenYM);
            var hiddenPos = document.createElement("input");
            hiddenPos.setAttribute("type", "hidden");
            hiddenPos.setAttribute("name", "position");
            hiddenPos.setAttribute("value", "<%=positionNum%>");
            form.appendChild(hiddenPos);
            var targetSchedule = document.createElement("input");
            targetSchedule.setAttribute("type", "hidden");
            targetSchedule.setAttribute("name", "scheduleId");
            targetSchedule.setAttribute("value", id);
            form.appendChild(targetSchedule);
            document.body.appendChild(form);
            console.log(id);
            form.submit();
        }

    }

    function cancelModify(id) {
        var hidForm1 = document.getElementById("span[" + id + "][1]");
        var hidForm2 = document.getElementById("span[" + id + "][2]");
        var hidForm3 = document.getElementById("span[" + id + "][3]");
        var hidForm4 = document.getElementById("span[" + id + "][1]-");
        var hidForm5 = document.getElementById("span[" + id + "][2]br");
        var hidForm6 = document.getElementById("span[" + id + "][2]일정:");
        var hidModifyButton = document.getElementsByClassName("modifyButton");
        for(var i = 0; i<hidModifyButton.length; i++) {
            var arr = hidModifyButton.item(i);
            arr.style.display = "inline";
        }
        var hidDeleteButton = document.getElementsByClassName("deleteButton");
        for(var i = 0; i<hidDeleteButton.length; i++) {
            var arr = hidDeleteButton.item(i);
            arr.style.display = "inline";
        }
        var thisForm = document.getElementById(id);
        document.getElementById("startTime" + id).value = hidForm1.innerHTML;
        document.getElementById("endTime" + id).value = hidForm2.innerHTML;
        document.getElementById("plan" + id).value = hidForm3.innerHTML;
        hidForm1.style.display = "inline";
        hidForm2.style.display = "inline";
        hidForm3.style.display = "inline";
        hidForm4.style.display = "inline";
        hidForm5.style.display = "inline";
        hidForm6.style.display = "inline";
        thisForm.style.display = "none";
    }



    
    function showNav() {
        var navMove = document.getElementById("nav");
        navMove.style.left = 0;

    }
    function closeNav() {
        var navMove = document.getElementById("nav");
        navMove.style.left = navMove.style.width;
    }
    var userPosition = document.getElementById("position");
    if("<%=data[3]%>" == 1) {
        userPosition.innerHTML = "사원";
        document.getElementById("menuButton").style.display = "none";
    }
    else if("<%=data[3]%>" == 2) {
        userPosition.innerHTML = "팀장";
        var nav = document.getElementById("nav");
        for(var a=0; a<workerList.length; a++) {
            if(workerList[a][2] != "<%=id%>" && workerList[a][1] == "1") {
                var workerDiv = document.createElement("div");
                var workerPosition;
                workerDiv.setAttribute("onclick", "showOtherSchedule('"+workerList[a][2]+"')");
                if(workerList[a][1] == "1") {
                    workerPosition = "사원";
                }
                else if(workerList[a][1] == "2") {
                    workerPosition = "팀장";
                }
                else {
                    workerPosition = "관리자";
                }
                workerDiv.innerHTML = workerList[a][0] + "(" + workerPosition + ")";
                nav.appendChild(workerDiv);
            }
        }
    }
    else if("<%=data[3]%>" == 3) {
        userPosition.innerHTML = "관리자";
        var nav = document.getElementById("nav");
        for(var a=0; a<workerList.length; a++) {
            if(workerList[a][2] != "<%=id%>") {
                var workerDiv = document.createElement("div");
                var workerPosition;
                workerDiv.setAttribute("onclick", "showOtherSchedule('"+workerList[a][2]+"')");
                if(workerList[a][1] == "1") {
                    workerPosition = "사원";
                }
                else if(workerList[a][1] == "2") {
                    workerPosition = "팀장";
                }
                else {
                    workerPosition = "관리자";
                }
                workerDiv.innerHTML = workerList[a][0] + "(" + workerPosition + ")";
                nav.appendChild(workerDiv);
            }
        }
    }

    function showOtherSchedule(otherId) {
        var form = document.createElement("form");
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");
        form.setAttribute("action", "otherSchedule.jsp");

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden")
        hiddenField.setAttribute("name", "userId");
        hiddenField.setAttribute("value", "<%=id%>");
        form.appendChild(hiddenField);
        var hiddenYM = document.createElement("input");
        hiddenYM.setAttribute("type", "hidden")
        hiddenYM.setAttribute("name", "YearMonth");
        hiddenYM.setAttribute("value", "<%=YM%>");
        form.appendChild(hiddenYM);
        var hiddenPos = document.createElement("input");
        hiddenPos.setAttribute("type", "hidden")
        hiddenPos.setAttribute("name", "position");
        hiddenPos.setAttribute("value", "<%=positionNum%>");
        form.appendChild(hiddenPos);
        var hiddenOtherId = document.createElement("input");
        hiddenOtherId.setAttribute("type", "hidden")
        hiddenOtherId.setAttribute("name", "otherId");
        hiddenOtherId.setAttribute("value", otherId);
        form.appendChild(hiddenOtherId);
        document.body.appendChild(form);
        form.submit();
    }

    var year = parseInt("<%=YM%>" / 100);
    var month = "<%=YM%>" % 100;
    var yearMonth = document.getElementById("yearMonth");
    yearMonth.innerHTML = year + "년" + month + "월";

    function minusMonth() {
        var temp;
        if(month > 1) {
            month--;
            yearMonth.innerHTML = year + "년" + month + "월";
        }
        else {
            year--;
            month = 12;
            yearMonth.innerHTML = year + "년" + month + "월";
        }
        if(month < 10) {
            temp = year + '0' + month;
        }
        else {
            temp = year + '' + month;
        }

        var form = document.createElement("form");
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");
        form.setAttribute("action", "scheduleListModule.jsp");

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden")
        hiddenField.setAttribute("name", "id_value");
        hiddenField.setAttribute("value", "<%=data[0]%>");
        form.appendChild(hiddenField);
        var hiddenYM = document.createElement("input");
        hiddenYM.setAttribute("type", "hidden")
        hiddenYM.setAttribute("name", "YearMonth");
        hiddenYM.setAttribute("value", temp);
        form.appendChild(hiddenYM);
        var hiddenPos = document.createElement("input");
        hiddenPos.setAttribute("type", "hidden")
        hiddenPos.setAttribute("name", "position");
        hiddenPos.setAttribute("value", "<%=positionNum%>");
        form.appendChild(hiddenPos);
        document.body.appendChild(form);
        form.submit();
        
    }
    function plusMonth() {
        var temp;
        if(month < 12) {
            month++;
            yearMonth.innerHTML = year + "년" + month + "월";  
        }
        else {
            year++;
            month = 1;
            yearMonth.innerHTML = year + "년" + month + "월";
        }
        if(month < 10) {
            temp = year + '0' + month;
        }
        else {
            temp = year + '' + month;
        }
        var form = document.createElement("form");
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");
        form.setAttribute("action", "scheduleListModule.jsp");

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden")
        hiddenField.setAttribute("name", "id_value");
        hiddenField.setAttribute("value", "<%=data[0]%>");
        form.appendChild(hiddenField);
        var hiddenYM = document.createElement("input");
        hiddenYM.setAttribute("type", "hidden")
        hiddenYM.setAttribute("name", "YearMonth");
        hiddenYM.setAttribute("value", temp);
        form.appendChild(hiddenYM);
        var hiddenPos = document.createElement("input");
        hiddenPos.setAttribute("type", "hidden")
        hiddenPos.setAttribute("name", "position");
        hiddenPos.setAttribute("value", "<%=positionNum%>");
        form.appendChild(hiddenPos);
        document.body.appendChild(form);
        form.submit();
    }
    document.getElementById('date').value = new Date().toISOString().substring(0, 10);
    document.getElementById("startTime").value = "00:00";
    document.getElementById("endTime").value = "00:00";
    function addSchedule() {
        document.getElementById("addSchedule").style.display = "none";
        document.getElementById("scheduleForm").style.display = "flex";
    }
    function cancelAddSchedule() {
        document.getElementById("addSchedule").style.display = "block";
        document.getElementById("scheduleForm").style.display = "none";

    }
    function checkForm(form) {
        var date = document.getElementById("date").value;
        var startTime = document.getElementById("startTime").value;
        var endTime = document.getElementById("endTime").value;
        var YYMMDD = date.split("-");
        var sT = startTime.split(":");
        var eT = endTime.split(":");
        var YM = YYMMDD[0] + YYMMDD[1];
        var day = YYMMDD[2];
        if(parseInt(sT[0] + sT[1]) > parseInt(eT[0] + eT[1])) {
            alert("올바른 시간을 입력하세요");
            return false;
        }
        if(confirm("일정을 추가하시겠습니까?") == true) {
            var hiddenPos = document.createElement("input");
            hiddenPos.setAttribute("type", "hidden")
            hiddenPos.setAttribute("name", "YearMonth");
            hiddenPos.setAttribute("value", YM);
            form.appendChild(hiddenPos);
            var hiddenPos2 = document.createElement("input");
            hiddenPos2.setAttribute("type", "hidden")
            hiddenPos2.setAttribute("name", "day");
            hiddenPos2.setAttribute("value", day);
            form.appendChild(hiddenPos2);
        }
        else {
            return false;
        }

    }
</script>