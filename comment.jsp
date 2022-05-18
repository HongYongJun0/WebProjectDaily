<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%

    request.setCharacterEncoding("utf-8");
    String commentuser_id = request.getParameter("user_id");
    String post_id = request.getParameter("post_id");

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/assignment",
        "yj",
        "0908"
    );

    String sql = "SELECT * FROM post WHERE post_id=?";
    PreparedStatement query = conn.prepareStatement(sql);
    query.setString(1, post_id);

    ResultSet result = query.executeQuery();

    String[] data = new String[4];
    while(result.next()) {
        data[0] = result.getString("post_id");
        data[1] = result.getString("post_title");
        data[2] = result.getString("post_detail");
        data[3] = result.getString("user_id");
    }

    String sql2 = "SELECT * FROM comment WHERE post_id=?";
    PreparedStatement query2 = conn.prepareStatement(sql2);
    query2.setString(1, post_id);
    ResultSet result2 = query2.executeQuery();
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comment Page</title>
</head>
<body>
    <div>게시글 아이디</div>
    <p><%=data[0]%></p>
    <div>제목</div>
    <p><%=data[1]%></p>
    <div>내용</div>
    <p><%=data[2]%></p>
    <div>작성자</div>
    <p><%=data[3]%></p>
    <div>
        <form action="commentconfirm.jsp" method="post">
            <input type="hidden" value= "<%=post_id%>" name="post_id">
            <input type="text" name="comment_detail">
            <input type="hidden" value= "<%=commentuser_id%>" name="commentuser_id">
            <input type="submit" value="댓글 작성">
        </form>
    </div>
    <table border="1">
        <tr>
            <th>댓글 내용</th>
            <th>유저 아이디</th>
        </tr>
        <% while (result2.next()) { %>
        <tr>
            <td><%=result2.getString("comment_detail")%></td>
            <td><%=result2.getString("user_id")%></td>
        </tr>
        <% } %>
    </table>
</body>