<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%

    request.setCharacterEncoding("utf-8");
    String post_id = request.getParameter("post_id");
    String detail = request.getParameter("comment_detail");
    String user_id = request.getParameter("commentuser_id");
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/assignment",
        "yj",
        "0908"
    );

        String sql = "INSERT INTO comment(post_id, comment_detail, user_id) VALUES (?,?,?)";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setString(1, post_id);
        query.setString(2, detail);
        query.setString(3, user_id);

        query.executeUpdate();
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Commentconfirm Page</title>
</head>
<body>
</body>
<script>
    var form = document.createElement("form");
    form.setAttribute("charset", "UTF-8");
    form.setAttribute("method", "Post");
    form.setAttribute("action", "comment.jsp");
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden")
    hiddenField.setAttribute("name", "post_id");
    hiddenField.setAttribute("value", "<%=post_id%>");
    form.appendChild(hiddenField);
    var hiddenField2 = document.createElement("input");
    hiddenField2.setAttribute("type", "hidden")
    hiddenField2.setAttribute("name", "user_id");
    hiddenField2.setAttribute("value", "<%=user_id%>");
    form.appendChild(hiddenField2);
    document.body.appendChild(form);
    form.submit();
</script>