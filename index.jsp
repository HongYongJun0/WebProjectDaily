<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
</head>
<body>
    <form action="loginconfirm.jsp" method="post">      
        <p><input type="text" name="id_value" placeholder="아이디"></p>
        <p><input type="password" name="pw_value" placeholder="비밀번호"></p>
        <input type="submit" value="로그인">
    </form>
    <form action="signup.jsp" method="post">
        <input type="submit" value="회원가입">
    </form>
</body>

<script>

</script>