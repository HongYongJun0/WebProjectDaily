<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%

    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("userId");
    String YM = request.getParameter("YearMonth");
    String pos = request.getParameter("position");
    String otherId = request.getParameter("otherId");

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/worker_account",
        "yj",
        "0908"
    );

    String sql = "SELECT * FROM schedule WHERE userId=? and YearMonth=?";
    PreparedStatement query = conn.prepareStatement(sql);
    query.setString(1, otherId);
    query.setString(2, YM);

    ResultSet result = query.executeQuery();

    String[] data = new String[3];
    while(result.next()) {
        data[0] = result.getString("userId");
        data[1] = result.getString("YearMonth");
    }


%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loading Page</title>
</head>
<body>
</body>
<script>
    var form = document.createElement("form");
    form.setAttribute("charset", "UTF-8");
    form.setAttribute("method", "Post");
    form.setAttribute("action", "otherSchedule.jsp");

    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden")
    hiddenField.setAttribute("name", "userId");
    hiddenField.setAttribute("value", "<%=id%>");
    form.appendChild(hiddenField);
    var hiddenField2 = document.createElement("input");
    hiddenField2.setAttribute("type", "hidden")
    hiddenField2.setAttribute("name", "YearMonth");
    hiddenField2.setAttribute("value", "<%=YM%>");
    form.appendChild(hiddenField2);
    var hiddenField3 = document.createElement("input");
    hiddenField3.setAttribute("type", "hidden")
    hiddenField3.setAttribute("name", "position");
    hiddenField3.setAttribute("value", "<%=pos%>");
    form.appendChild(hiddenField3);
    var hiddenField4 = document.createElement("input");
    hiddenField4.setAttribute("type", "hidden")
    hiddenField4.setAttribute("name", "otherId");
    hiddenField4.setAttribute("value", "<%=otherId%>");
    form.appendChild(hiddenField4);
    document.body.appendChild(form);
    form.submit();

</script>