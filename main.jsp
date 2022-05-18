<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
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

    String sql3 = "SELECT * FROM account";
    PreparedStatement query3 = conn.prepareStatement(sql3);
    ResultSet result3 = query3.executeQuery();
    String[][] data3 = new String[100][2];
    int accountNum = 0;
    String str3 = "3";
    String str2 = "2";
    if(positionNum.equals(str3)) {

        int index = 0;
        while(result3.next()) {
            data3[index][0] = result3.getString("name");
            data3[index][1] = result3.getString("position");
            index++;
        }
        accountNum = data3.length;
    }
    else if(positionNum.equals)

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

%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Page</title>
    <link rel="stylesheet" type="text/css" href="main.css">
</head>
<body>
    <div>
        <div id="nav">
            <input type="button" value="닫기" onclick="closeNav()">
        </div>
        <input type="button" value="메뉴" id="menuButton"onclick="showNav()">
        <p>아이디 <%=data[0]%> </p>
        <p>직책 <span id="position"></span> </p>
    </div>
    <div>
        <input type="button" value="<" onclick="minusMonth()">
        <span id="yearMonth"></span>
        <input type="button" value=">" onclick="plusMonth()">
    </div>
    <table border="1">
        <% while (result2.next()) { %>
        <tr>
            <td><%=result2.getString("date")%></td>
            <td><%=result2.getString("startTime")%></td>
            <td><%=result2.getString("endTime")%></td>
            <td><%=result2.getString("dailySchedule")%></td>
        </tr>
        <% } %>
    </table>
    <div>
        <input type="button" value="일정 추가" id = "addSchedule" onclick="addSchedule()">
        <form id="scheduleForm" action="addScheduleModule.jsp" method="post">
            <input type="date" name="date" id="date">
            <input type="time" name="startTime" id="startTime">
            <input type="time" name="endTime" id="endTime">
            <input type="text" name="schedule" placeholder="일정을 입력하세요">
            <input type="hidden" name="userId" value="<%=id%>">
            <input type="hidden" name="currentYM" value="<%=YM%>">
            <input type="submit" value="적용">
            <input type="button" value="취소" onclick="cancelAddSchedule()">
        </form>
    </div>
</body>
<script>
    <%for(int i=0; i < accountNum; i++) {%>
        var workerDiv = document.createElement("div");
        workerDiv.innerHTML = "<%=data3[i][0]%>";
        document.getElementById("nav").appendChild(workerDiv);
    <%}%>
    
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
        document.getElementById("menuButton").style.display = none;
    }
    else if("<%=data[3]%>" == 2) {
        userPosition.innerHTML = "팀장";
    }
    else if("<%=data[3]%>" == 3) {
        userPosition.innerHTML = "관리자";
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
            document.body.appendChild(form);
            form.submit();
    }
    document.getElementById("scheduleForm").style.display = "none";
    document.getElementById('date').value = new Date().toISOString().substring(0, 10);
    document.getElementById("startTime").value = "00:00";
    document.getElementById("endTime").value = "00:00";
    function addSchedule() {
        document.getElementById("addSchedule").style.display = "none";
        document.getElementById("scheduleForm").style.display = "block";
    }
    function cancelAddSchedule() {
        document.getElementById("addSchedule").style.display = "block";
        document.getElementById("scheduleForm").style.display = "none";

    }
</script>