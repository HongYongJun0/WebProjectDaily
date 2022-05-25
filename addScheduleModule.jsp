<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import ="java.util.*"%>s
<%

    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("userId");
    String curYM = request.getParameter("currentYM");
    String YM = request.getParameter("YearMonth");
    String day = request.getParameter("day");
    String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
    String schedule = request.getParameter("schedule");
    String positionNum = request.getParameter("position");

    int YM_int = Integer.parseInt(YM);
    int day_int = Integer.parseInt(day);

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/worker_account",
        "yj",
        "0908"
    );

    String sql = "INSERT INTO schedule(userId, YearMonth, date, startTime, endTime, dailySchedule) VALUES(?,?,?,?,?,?)";
    PreparedStatement query = conn.prepareStatement(sql);
    query.setString(1, id);
    query.setInt(2, YM_int);
    query.setInt(3, day_int);
    query.setString(4, startTime);
    query.setString(5, endTime);
    query.setString(6, schedule);

    query.executeUpdate();



%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
</head>
<body>
</body>
<script>
    var form = document.createElement("form");
    form.setAttribute("charset", "UTF-8");
    form.setAttribute("method", "Post");
    form.setAttribute("action", "main.jsp");
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden")
    hiddenField.setAttribute("name", "id_value");
    hiddenField.setAttribute("value", "<%=id%>");
    form.appendChild(hiddenField);
    var hiddenField2 = document.createElement("input");
    hiddenField2.setAttribute("type", "hidden")
    hiddenField2.setAttribute("name", "YearMonth");
    hiddenField2.setAttribute("value", "<%=curYM%>");
    form.appendChild(hiddenField2);
    var hiddenField3 = document.createElement("input");
    hiddenField3.setAttribute("type", "hidden")
    hiddenField3.setAttribute("name", "position");
    hiddenField3.setAttribute("value", "positionNum");
    form.appendChild(hiddenField3);
    document.body.appendChild(form);
    form.submit();
</script>