<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.net.URLEncoder" %>
<%
    int m_cp = Integer.parseInt(request.getParameter("CurrentPage"));
    String m_column = request.getParameter("column");
    if (m_column == null) m_column = "";

    String m_encoded_key = null;

    String m_key = request.getParameter("key");
    if (m_key != null) {
        m_encoded_key = URLEncoder.encode(m_key, "utf-8");

    } else {
        m_key = "";
    }
%>
<HTML>
<HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=utf-8"/>
    <LINK REL="stylesheet" type="text/css" href="../include/style.css">
    <SCRIPT language="javascript" SRC="../include/scripts.js"></SCRIPT>
    <TITLE>회원가입</TITLE>
    <script language="JavaScript">
        function CheckMemberForm(form) {
            if (!form.UserName.value) {
                alert('이름을 입력하세요.');
                form.UserName.focus();
                return true;
            }

            if (!form.UserJumin1.value) {
                alert('주민등록번호 앞 6자리를 입력하세요.');
                form.UserJumin1.focus();
                return true;
            }

            if (!form.UserJumin2.value) {
                alert('주민등록번호 뒤 7자리를 입력하세요.');
                form.UserJumin2.focus();
                return true;
            }

            /*
            if (!JuminNoCheck(form.UserJumin1, form.UserJumin2)) {
                alert('주민등록번호가 적절치 않습니다.');
                form.UserJumin1.focus();
                return true;
            }

            */

            if (!form.UserId.value) {
                alert('사용자 아이디를 입력하세요.');
                form.UserId.focus();
                return true;
            }

            if (!form.UserPass.value) {
                alert('패스워드를 입력하세요.');
                form.UserPass.focus();
                return true;
            }

            if (!form.ReUserPass.value) {
                alert('패스워드 재입력 란에 패스워드를 입력하세요.');
                form.ReUserPass.focus();
                return true;
            }

            if (!(form.UserPass.value == form.ReUserPass.value)) {
                alert('입력된 패스워드가 서로 다릅니다.');
                form.UserPass.focus();
                return true;
            }

            if (!form.UserName.value) {
                alert('전자우편주소를 입력하세요.');
                form.UserMail.focus();
                return true;
            } else if (!isCorrectEmail('BeMember', 'UserMail')) {
                alert('전자우편형식이 올바르지 않습니다.');
                form.UserMail.focus();
                return true;
            }

            if (!form.ZipCode1.value) {
                alert('우편번호나 주소가 입력되지 않았습니다.');
                form.ZipCode1.focus();
                return true;
            }

            if (!form.UserTel1.value) {
                alert('전화번호(지역번호)를 입력하세요.');
                form.UserTel1.focus();
                return true;
            }

            if (!form.UserTel2.value) {
                alert('전화번호(국)를 입력하세요.');
                form.UserTel1.focus();
                return true;
            }

            if (!form.UserTel3.value) {
                alert('전화번호(번호)를 입력하세요.');
                form.UserTel3.focus();
                return true;
            }


            if (form.UserHp1.selectedIndex == 0) {
                alert('휴대폰의 통신사를 선택하세요.');
                return true;
            }

            if (!form.UserHp2.value) {
                alert('휴대폰 번호 앞자리를 입력하세요.');
                form.UserHp2.focus();
                return true;
            }

            if (!form.UserHp3.value) {
                alert('휴대폰 번호 뒷자리를 입력하세요.');
                form.UserHp2.focus();
                return true;
            }

            form.submit();
        }


    </script>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
    <TR BGCOLOR=#A0A0A0>
        <TD ALIGN=CENTER><FONT SIZE=4><B>회 원 가 입</B></FONT></TD>
    </TR>
</TABLE>

<FORM NAME="BeMember" METHOD=POST
      ACTION="BeMemberProc.jsp?CurrentPage=<%=m_cp%>&column=<%=m_column%>&key=<%=m_encoded_key%>">

    <TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=2 ALIGN=CENTER>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>이름</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=TEXT NAME="UserName" SIZE=20 MAXLENGTH=20 style="ime-mode:active"
                       onkeydown="javascript:Korean">
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>주민등록번호</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=TEXT NAME="UserJumin1" SIZE=6 MAXLENGTH=6 style="ime-mode: disabled"
                       onkeydown="javascript:NumKey()"> -
                <INPUT TYPE=TEXT NAME="UserJumin2" SIZE=7 MAXLENGTH=7 style="ime-mode: disabled"
                       onkeydown="javascript:NumKey()">
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>아이디</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=TEXT NAME="UserId" SIZE=20 MAXLENGTH=10 style="ime-mode:inactive">
                <IMG SRC="../images/btn_dup_id_3.gif" BORDER=0 ALIGN=ABSMIDDLE STYLE=CURSOR:HAND
                     onclick="javascript:IdCheck('IdCheck.jsp','BeMember','UserId','CheckId',380,200,'no')">
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>패스워드</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=PASSWORD NAME="UserPass" SIZE=20 MAXLENGTH=10>
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>패스워드 재입력</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=PASSWORD NAME="ReUserPass" SIZE=20 MAXLENGTH=10>
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>전자우편</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=TEXT NAME="UserMail" SIZE=60 MAXLENGTH=90 style="ime-mode:inactive">
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>주 소</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=TEXT NAME="ZipCode1" SIZE=3 MAXLENGTH=3> -
                <INPUT TYPE=TEXT NAME="ZipCode2" SIZE=3 MAXLENGTH=3><BR>
                <INPUT TYPE=TEXT NAME="UserAddress1" SIZE=45 MAXLENGTH=110">
                <IMG SRC="../images/btn_post_3.gif" BORDER=0 ALIGN=ABSMIDDLE STYLE=CURSOR:HAND><BR>&nbsp;
                나머지 주소
                <INPUT TYPE=TEXT NAME="UserAddress2" SIZE=45 MAXLENGTH=110>
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>전화번호</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=TEXT NAME="UserTel1" SIZE=3 MAXLENGTH=3 style="ime-mode: disabled"
                       onkeydown="javascript:NumKey()"> -
                <INPUT TYPE=TEXT NAME="UserTel2" SIZE=4 MAXLENGTH=4 style="ime-mode: disabled"
                       onkeydown="javascript:NumKey()"> -
                <INPUT TYPE=TEXT NAME="UserTel3" SIZE=4 MAXLENGTH=4 style="ime-mode: disabled"
                       onkeydown="javascript:NumKey()">
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>휴대전화</B></TD>
            <TD WIDTH=500>
                <SELECT NAME="UserHp1" SIZE=1>
                    <OPTION VALUE="0" SELECTED>통신사
                    <OPTION VALUE="010">010
                    <OPTION VALUE="011">011
                </SELECT> -
                <INPUT TYPE=TEXT NAME="UserHp2" SIZE=4 MAXLENGTH=4 style="ime-mode: disabled"
                       onkeydown="javascript:NumKey()"> -
                <INPUT TYPE=TEXT NAME="UserHp3" SIZE=4 MAXLENGTH=4 style="ime-mode: disabled"
                       onkeydown="javascript:NumKey()">
            </TD>
        </TR>

    </TABLE>

</FORM>

<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

    <TR ALIGN=CENTER>
        <TD>
            <IMG SRC="../images/btn_be_member_3.gif" STYLE=CURSOR:HAND onclick="javascript:CheckMemberForm(BeMember)">&nbsp;&nbsp;
            <IMG SRC="../images/btn_mb_cancel_3.gif" STYLE=CURSOR:HAND
                 onclick="javascript:location.replace('../board/BoardList.jsp?CurrentPage=<%=m_cp%>&column=<%=m_column%>&key=<%=m_encoded_key%>')">
        </TD>
    </TR>

</TABLE>

</BODY>
</HTML>