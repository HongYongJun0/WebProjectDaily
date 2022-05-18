function formCheck() {
    var userForm = document.getElementById("userForm");
    var user_id = document.getElementById("user_id");
    var user_pw = document.getElementById("user_pw");
    var user_name = document.getElementById("user_name");
    var user_phonenumber = document.getElementById("user_phonenumber");
    var user_address = document.getElementById("user_address");

    if(user_id && user_pw && user_name && user_phonenumber && user_address != "") {
        userForm.action = "signupconfirm.jsp"
        userForm.submit();
    }
    else {
        alert("전부 입력하세요");
    }
}