<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%

    request.setCharacterEncoding("utf-8");

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/worker_account",
        "yj",
        "0908"
    );

    String sql = "SELECT userId FROM account";
    PreparedStatement query = conn.prepareStatement(sql);
    ResultSet result = query.executeQuery();
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 중복확인</title>
</head>
<body>
    <input type="button" onclick="idCheck()" value="아이디 중복확인">
</body>
<script>
    var isIdChecked = 0;
    function idCheck() {
        var user_id = window.opener.document.getElementById("user_id").value;
        <% while(result.next()) { %>
            if("<%=result.getString("userId")%>" == user_id) {
                alert("중복되는 아이디가 존재합니다");
                opener.window.document.signupform.mid.value = 0;
                window.close();
                return;
            }
        <% } %>
        alert("사용 가능한 아이디 입니다");
        opener.window.document.signupform.mid.value=1;
        window.close();

    }
</script>