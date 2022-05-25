<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import = "java.util.Vector"%>
<%

    request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("userId");
    String YM = request.getParameter("YearMonth");
    String userPosition = request.getParameter("position");
    String otherId = request.getParameter("otherId");
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/worker_account",
        "yj",
        "0908"
    );

    String sql2 = "SELECT * FROM account WHERE userId=?";
    PreparedStatement query2 = conn.prepareStatement(sql2);
    query2.setString(1, otherId);

    ResultSet result2 = query2.executeQuery();

    String[] data = new String[4];
    while(result2.next()) {
        data[0] = result2.getString("userId");
        data[1] = result2.getString("userPassword");
        data[2] = result2.getString("name");
        data[3] = result2.getString("position");
    }

    String sql = "SELECT * FROM schedule WHERE userId=? and YearMonth=?";
    PreparedStatement query = conn.prepareStatement(sql);
    query.setString(1, otherId);
    query.setString(2, YM);

    ResultSet result = query.executeQuery();
    char quotes = '"';
    Vector<Vector<String>> vecdate = new Vector<Vector<String>>();
    while (result.next()) {
        Vector<String> list = new Vector<String>();
        String string1 = result.getString(4);
        String string2 = result.getString(5);
        String string3 = result.getString(6);
        String string4 = result.getString(7);
        String string5 = result.getString(2);
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
    <title>otherWorkerSchedule Page</title>
    <link rel="stylesheet" type="text/css" href="main.css?after">
</head>
<body>
    <header>
        <div id="menuButton">
            <div class="hideMenuButtonComponent"></div>
            <div class="hideMenuButtonComponent"></div>
            <div class="hideMenuButtonComponent"></div>
        </div>
        <p id="logo">Daily</p>
        <div>
            <p class="userInfo">아이디 <%=userId%> </p>
            <p class="userInfo">직책 <span id="position"></span></p>
        </div>
    </header>
    <div id="changeYM">
        <input type="button" value="<" onclick="minusMonth()" class="changeMonth">
        <span id="yearMonth"></span>
        <input type="button" value=">" onclick="plusMonth()" class="changeMonth">
    </div>
    <div id="scheduleList">
        <div id="otherInfo" class="scheduleListComponent"><%=data[2]%>님의 일정</div>
    </div>
    <form action="main.jsp" method="post">      
        <input type="hidden" name="id_value" value="<%=userId%>">
        <input type="hidden" name="YearMonth" value="<%=YM%>">
        <input type="hidden" name="position" value="<%=userPosition%>">
        <input type="submit" value="내 일정으로 돌아가기" id="addSchedule">
    </form>
</body>
<script>

    var otherScheduleList = <%=vecdate%>;

    if("<%=userPosition%>" == "1") {
        document.getElementById("position").innerHTML = "사원"
    }
    else if("<%=userPosition%>" == "2") {
        document.getElementById("position").innerHTML = "팀장"
    }
    else {
        document.getElementById("position").innerHTML = "관리자"
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
        form.setAttribute("action", "otherScheduleListModule.jsp");

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden")
        hiddenField.setAttribute("name", "userId");
        hiddenField.setAttribute("value", "<%=userId%>");
        form.appendChild(hiddenField);
        var hiddenYM = document.createElement("input");
        hiddenYM.setAttribute("type", "hidden")
        hiddenYM.setAttribute("name", "YearMonth");
        hiddenYM.setAttribute("value", temp);
        form.appendChild(hiddenYM);
        var hiddenPos = document.createElement("input");
        hiddenPos.setAttribute("type", "hidden")
        hiddenPos.setAttribute("name", "position");
        hiddenPos.setAttribute("value", "<%=userPosition%>");
        form.appendChild(hiddenPos);
        var hiddenOtherId = document.createElement("input");
        hiddenOtherId.setAttribute("type", "hidden")
        hiddenOtherId.setAttribute("name", "otherId");
        hiddenOtherId.setAttribute("value", "<%=otherId%>");
        form.appendChild(hiddenOtherId);
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
        form.setAttribute("action", "otherScheduleListModule.jsp");

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden")
        hiddenField.setAttribute("name", "userId");
        hiddenField.setAttribute("value", "<%=userId%>");
        form.appendChild(hiddenField);
        var hiddenYM = document.createElement("input");
        hiddenYM.setAttribute("type", "hidden")
        hiddenYM.setAttribute("name", "YearMonth");
        hiddenYM.setAttribute("value", temp);
        form.appendChild(hiddenYM);
        var hiddenPos = document.createElement("input");
        hiddenPos.setAttribute("type", "hidden")
        hiddenPos.setAttribute("name", "position");
        hiddenPos.setAttribute("value", "<%=userPosition%>");
        form.appendChild(hiddenPos);
        var hiddenOtherId = document.createElement("input");
        hiddenOtherId.setAttribute("type", "hidden")
        hiddenOtherId.setAttribute("name", "otherId");
        hiddenOtherId.setAttribute("value", "<%=otherId%>");
        form.appendChild(hiddenOtherId);
        document.body.appendChild(form);
        form.submit();
    }

    var list = document.getElementById("scheduleList");
    for(var index=0; index<otherScheduleList.length; index++) {
        var newDiv = document.createElement("div");
        newDiv.setAttribute("class", "scheduleListComponent");
        var showenForm = document.createElement("span");
        showenForm.setAttribute("class", "showenScheduleList");
        for(var ind=0; ind<4; ind++) {
            var newSpan = document.createElement("span");
            newSpan.setAttribute("id", "span[" + otherScheduleList[index][4] + "][" + ind + "]");
            newSpan.innerHTML= otherScheduleList[index][ind];
            showenForm.appendChild(newSpan);
            if(ind==0) {
                var gap = document.createElement("span");
                gap.innerHTML = "일 ";
                showenForm.appendChild(gap);
            }
            else if(ind==1) {
                var cutTime = otherScheduleList[index][ind].split(":");
                newSpan.innerHTML = cutTime[0] + ":" + cutTime[1];
                var gap = document.createElement("span");
                gap.setAttribute("id", "span[" + otherScheduleList[index][4] + "][" + ind + "]-");
                gap.innerHTML = "-";
                showenForm.appendChild(gap);
            }
            else if(ind==2) {
                var cutTime = otherScheduleList[index][ind].split(":");
                newSpan.innerHTML = cutTime[0] + ":" + cutTime[1];
                var newLine = document.createElement("br");
                newLine.setAttribute("id", "span[" + otherScheduleList[index][4] + "][" + ind + "]br");
                showenForm.appendChild(newLine);
                var gap = document.createElement("span");
                gap.setAttribute("id", "span[" + otherScheduleList[index][4] + "][" + ind + "]일정:");
                gap.innerHTML = "일정:";
                showenForm.appendChild(gap);
            }
        }
        newDiv.appendChild(showenForm);
        list.appendChild(newDiv);
    }
</script>