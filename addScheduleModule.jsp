<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %> 

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%

    request.setCharacterEncoding("utf-8");
    String id = request.getParameter("userId");
    String curYM = request.getParameter("currentYM");
    String date = request.getParameter("date");
    String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
    String schedule = request.getParameter("schedule");

    var setY = substring(date, 0, 4);
    var setM = substring(date, 5, 7);
    var setYM = concat(setY, setM);
    var setDay = date.subString(8, 10);

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/worker_account",
        "yj",
        "0908"
    );

    String sql = "INSERT INTO schedule VALUES(?,?,?,?,?,?)";
    PreparedStatement query = conn.prepareStatement(sql);
    query.setString(1, id);
    query.setString(2, setYM);
    query.setString(3, setDay);
    query.setString(4, startTime);
    query.setString(5, endTime);
    query.setString(6, schedule);

    ResultSet result = query.executeUpdate();



%>