// 필수 입력 데이터 검사
function CheckForm(form) {
    if (!form.name.value) {
        alert("성명을 입력하세요");
        form.name.focus();
        return true;
    }

    if (form.mail.value) {
        if (!isCorrectEmail('BoardWrite', 'mail')) {
            alert("이메일 형식이 올바르지 않습니다.");
            form.mail.focus();
            form.mail.select();
            return;
        }

    }
    if (!form.subject.value) {
        alert("게시판의 제목을 입력하세요");
        form.subject.focus();
        return true;
    }

    if (!form.pass.value) {
        alert("패스워드를 입력하세요");
        form.pass.focus();
        return true;
    }

    form.submit();
}
