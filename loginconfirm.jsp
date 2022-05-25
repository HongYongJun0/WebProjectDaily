<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%

    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("id_value");
    String pw = request.getParameter("pw_value");

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/worker_account",
        "yj",
        "0908"
    );

    String sql = "SELECT * FROM account WHERE userId=? and userPassword=?";
    PreparedStatement query = conn.prepareStatement(sql);
    query.setString(1, id);
    query.setString(2, pw);

    ResultSet result = query.executeQuery();

    String[] data = new String[3];

    while(result.next()) {
        data[0] = result.getString(3);
        data[1] = result.getString(4);
        data[2] = result.getString(2);    
    }

%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Page</title>
</head>
<body>
</body>
<script>
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var YM;
    if(month<10) {
        YM = year + '0' + month;
    }
    else {
        YM = year + '' + month;
    }
    if("<%=data[0]%>" != "null" && "<%=data[1]%>" != "null") { 
        alert("로그인 성공");
        var form = document.createElement("form");
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");
        form.setAttribute("action", "main.jsp");

        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden")
        hiddenField.setAttribute("name", "id_value");
        hiddenField.setAttribute("value", "<%=data[0]%>");
        form.appendChild(hiddenField);
        var today = document.createElement("input");
        today.setAttribute("type", "hidden")
        today.setAttribute("name", "YearMonth");
        today.setAttribute("value", YM);
        form.appendChild(today);
        var position = document.createElement("input");
        position.setAttribute("type", "hidden")
        position.setAttribute("name", "position");
        position.setAttribute("value", "<%=data[2]%>");
        form.appendChild(position);
        document.body.appendChild(form);
        form.submit();
    }
    else {
        alert("로그인 실패");
        var form = document.createElement("form");
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "Post");
        form.setAttribute("action", "index.jsp");
        document.body.appendChild(form);
        form.submit();
    }
</script>