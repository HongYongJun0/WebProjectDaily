<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%

    request.setCharacterEncoding("utf-8");
    String userId = request.getParameter("userId");
    String YM = request.getParameter("curYM");
    String positionNum = request.getParameter("myPos");
    String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
    String plan = request.getParameter("plan");
    String scheduleId = request.getParameter("scheduleId");
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/worker_account",
        "yj",
        "0908"
    );

        String sql = "UPDATE schedule SET startTime=?, endTime=?, dailySchedule=? WHERE scheduleId=?";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setString(1, startTime);
        query.setString(2, endTime);
        query.setString(3, plan);
        query.setString(4, scheduleId);

        query.executeUpdate();
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module Page</title>
</head>
<body></body>
<script>
    var form = document.createElement("form");
    form.setAttribute("charset", "UTF-8");
    form.setAttribute("method", "Post");
    form.setAttribute("action", "main.jsp");
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden")
    hiddenField.setAttribute("name", "id_value");
    hiddenField.setAttribute("value", "<%=userId%>");
    form.appendChild(hiddenField);
    var hiddenField2 = document.createElement("input");
    hiddenField2.setAttribute("type", "hidden")
    hiddenField2.setAttribute("name", "YearMonth");
    hiddenField2.setAttribute("value", "<%=YM%>");
    form.appendChild(hiddenField2);
    var hiddenField3 = document.createElement("input");
    hiddenField3.setAttribute("type", "hidden")
    hiddenField3.setAttribute("name", "position");
    hiddenField3.setAttribute("value", "<%=positionNum%>");
    form.appendChild(hiddenField3);
    document.body.appendChild(form);
    form.submit();
</script>