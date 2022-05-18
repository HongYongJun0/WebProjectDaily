<%@ page language= "java" contentType="text/html" pageEncoding="utf-8" %>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup Page</title>
</head>
<body>
    <form name = "signupform"action ="signupconfirm.jsp" onsubmit="return formCheck();" method="post">
        <p>아이디 입력</p>
        <input type="text" name = "user_id" id="user_id">
        <input type="button" value="아이디 중복확인" id="user_id_check" onclick="idCheck();">
        <input type="hidden" name = "mid"id="mid">
        <p>비밀번호 입력</p>
        <input type="password" name = "user_pw" id="user_pw">
        <p>비밀번호 확인</p>
        <input type="password" id="user_pw_check">
        <p>이름 입력</p>
        <input type="text" name = "user_name" id="user_name">
        <p>직책 선택</p>
        <select name="position">
            <option value="1">사원</option>
            <option value="2">팀장</option>
            <option value="3">관리자</option>
        </select>
        <p><button>회원가입</button></p>
    </form>
</body>
<script>
    function formCheck() {
        var user_id = document.getElementById("user_id");
        var user_pw = document.getElementById("user_pw");
        var user_pw_check = document.getElementById("user_pw_check");
        var user_name = document.getElementById("user_name");
        var isIdChecked = document.getElementById("mid");
        if(isIdChecked.value == 0) {
            alert("아이디 중복확인을 해주세요");
            return false;
        }
        if(user_id.value.length == 0 || user_pw.value.length == 0 || user_name.value.length == 0) {
            alert("전부 기입해 주세요");
            return false;
        }
        if(user_pw.value != user_pw_check.value) {
            alert("비밀번호가 일치하지 않습니다");
            return false;
        }
        return true;
    }

    function idCheck() {
        window.open('idCheck.jsp', '중복체크', 'width=500, height=500');
    }

</script>
