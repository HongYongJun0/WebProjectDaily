<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%

    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("user_id");
    String pw = request.getParameter("user_pw");
    String name = request.getParameter("user_name");
    String position = request.getParameter("position");
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/worker_account",
        "yj",
        "0908"
    );

        String sql = "INSERT INTO account VALUES (?,?,?,?)";
        PreparedStatement query = conn.prepareStatement(sql);
        query.setString(1, name);
        query.setString(2, position);
        query.setString(3, id);
        query.setString(4, pw);

        query.executeUpdate();
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signupconfirm Page</title>
</head>
<body>
    <h1>회원가입 확인</h1>
    <form action="index.jsp" method="post">
        <input type="submit" value="로그인 페이지">
    </form>
</body>