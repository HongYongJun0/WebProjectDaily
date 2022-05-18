<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%

    request.setCharacterEncoding("utf-8");
    String title = request.getParameter("post_title");
    String detail = request.getParameter("post_detail");
    String id = request.getParameter("user_id");
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/assignment",
        "yj",
        "0908"
    );

        String sql = "INSERT INTO post(post_title, post_detail, user_id) VALUES (?,?,?)";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setString(1, title);
        query.setString(2, detail);
        query.setString(3, id);

        query.executeUpdate();
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Uploadconfirm Page</title>
</head>
<body>
    <h1>글 업로드 확인</h1>
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
    document.body.appendChild(form);
    form.submit();
</script>