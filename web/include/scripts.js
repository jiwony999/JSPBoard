function isCorrectEmail(fname, ename) {

    var i;

    var position_at = 0; // 0 or 1 가짐 0은 아이디 1은 서버 값(@뒤에 오는 도메인)
    var dot = 0;
    var id = "";
    var server = "";

    var email = eval("document." + fname + "." + ename); //js 객체로 만듬

    for (i = 0; i < email.value.length; i++) {

        if (email.value.charAt(i) == '@') {
            position_at += 1;
        }

        else if (position_at == 0) {
            id += email.value.charAt(i);
        }

        else {
            server += email.value.charAt(i);
        }

    }


    if (position_at >= 2 || position_at == 0) {
        alert("postion error");
        return false;
    }

    for (i = 0; i < id.length; i++) {
        if (!((id.charAt(i) >= 'A' && id.charAt(i) <= 'z') || (id.charAt(i) >= '0' && id.charAt(i) <= '9') || (id.charAt(i) == '_') || id.charAt(i) == '-')) {

            alert("id error");
            return false
        }
    }

    for (i = 0; i < server.length; i++) {
        if (server.charAt(i) == '.') {
            dot += 1;
        }
    }

    if (dot < 1) {
        alert("dot error");
        return false;
    }

    if (server.charAt(server.length - 1) == '.') {
        alert("server dot error");
        return false;
    }

    for (i = 0; i < server.length; i++) {
        if (!((server.charAt(i) >= 'A' && server.charAt(i) <= 'z') || (server.charAt(i) >= '0' && server.charAt(i) <= '9') || (server.charAt(i) == '.') || server.charAt(i) == '-')) {
            alert("server error");
            return false;
        }
    }

    return true;
}

// 한국어 입력만 받아들이는 함수
function Korean() {

    // ctrl, shift, alt 입력X
    if (event.ctrlKey || event.shiftKey || event.shiftLeft || event.altKey) {
        event.returnValue = false;
        return false;
    }


    if (event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 35 || event.keyCode == 36 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46) {
        event.returnValue = true;
        return;
    }

    if (event.keyCode < 12592 || event.keyCode > 12687) {
        event.returnValue = false;
        return false;
    }
}

// 주민등록번호 형식 조사 함수
function JuminNoCheck(front, back) {

    var birthday = front.value;
    var num = back.value;

    if (birthday.length != 6) {
        return false;
    }
    if (num.length != 7) {
        return false;
    }

    var hap = 0;

    for (var i = 0; i < 6; i++) {
        var temp = birthday.charAt(i) * (i + 2);
        hap += temp;
    }

    var n1 = num.charAt(0);
    var n2 = num.charAt(1);
    var n3 = num.charAt(2);
    var n4 = num.charAt(3);
    var n5 = num.charAt(4);
    var n6 = num.charAt(5);
    var n7 = num.charAt(6);


    hap += n1 * 8 + n2 * 9 + n3 * 2 + n4 * 3 + n5 * 4 + n6 * 5;
    hap = hap % 11;
    hap = 11 - hap;

    if (hap >= 10) {
        hap = hap % 10;
    }
    if (hap != n7) {
        return false;
    }

    return true;

}

function NumKey() {
    if (event.ctrlKey || event.shiftKey || event.altKey) {
        event.returnValue = false;
        return false;
    }

    if ((event.keyCode == 8 ||
        event.keyCode == 9 ||
        event.keyCode == 35 ||
        event.keyCode == 36 ||
        event.keyCode == 37 ||
        event.keyCode == 39 ||
        event.keyCode == 45 ||
        event.keyCode == 46 ||
        (event.keyCode >= 48 && event.keyCode <= 57) ||
        (event.keyCode >= 96 && event.keyCode <= 105))) {
        event.returnValue = true;
        return true;
    } else {
        event.returnValue = false;
        return false;
    }
}

function IdCheck(ref, fname, ename, myname, w, h, scroll) {
    var userid = eval('document.'+fname+'.'+ename);

    if (!userid.value) {
        alert('아이디를 입력한 후 버튼을 눌러주세요.');
        userid.focus();
        return;
    } else {
        ref = ref + "?" + ename + "=" + userid.value;
        var winl = (screen.width - w) / 2;
        var wint = (screen.height - h)/2;
        winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll;
        window.open(ref, myname, winprops);
    }

}