
// 이메일 형식 검사
function isCorrectEmail(fname, ename) {
    var i;
    var position_at = 0; // 0일 때는 아이디를 가리킴. 1일 때는 서버를 가리킴.
    var dot = 0;
    var id ="";
    var server ="";

    // eval -> string을 javascript 코드로 변환
    var email = eval("document."+fname+"."+ename);

    for (i=0; i < email.value.length; i++) {
        if (email.value.charAt(i) == '@') {
            position_at++;
        } else if (position_at == 0) { // ID 저장
            id = id + email.value.charAt(i);
        } else { // server 저장
            server = server + email.value.charAt(i);
        }
    }

    if (position_at >= 2 || position_at == 0) {
        return false;
    }

    for (i=0; i < id.length; i++) {
        if (!(id.charAt(i) >= 'A' && id.charAt(i) <= 'z') || (id.charAt(i) >= '0' && id.charAt(i) <= '9') || (id.charAt(i) == '_') || (id.charAt(i) == '-') ) {
            return false;
        }
    }

    for (i=0; i < server.length; i++) {
        if (server.charAt(i) == '.') {
            dot++;
        }
    }

    if (dot < 1) {
        return false;
    }

    // server의 마지막 문자가 . 이면 false 반환
    if (server.charAt(server.length-1) == '.') {
        return false;
    }

    for (i =0; i < server.length; i++) {
        if (!(server.charAt(i) >= 'A' && server.charAt(i) <= 'z') || (server.charAt(i) >= '0' && server.charAt(i) <= '9') || (server.charAt(i) == '_') || (server.charAt(i) == '-') ) {
            return false;
        }
    }

    return true;
}