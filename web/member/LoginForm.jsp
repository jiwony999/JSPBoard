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

<SCRIPT language="javascript" SRC="../include/scripts.js"></SCRIPT>

<FORM NAME="Login" METHOD=POST ACTION="#">

    <TABLE WIDTH=620 BORDER=0 ALIGN=CENTER CELLSPACING=0 CELLPADDING=0>

        <TR>
            <TD ALIGN=CENTER WIDTH=320>
                아이디 <INPUT TYPE=TEXT NAME="UserId" SIZE=10 MAXLENGTH=20>&nbsp;&nbsp;
                패스워드 <INPUT TYPE=PASSWORD NAME="UserPass" SIZE=10 MAXLENGTH=20>
                <IMG SRC="../images/btn_login.gif" WIDTH=41 HEIGHT=22 ALIGN=ABSBOTTOM STYLE=CURSOR:HAND>
            </TD>
            <TD ALIGN=RIGHT WIDTH=300>
                <IMG SRC="../images/btn_idpw_srch.gif" STYLE=CURSOR:HAND>
                <IMG SRC="../images/btn_be_member.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('../member/BeMember.jsp?CurrentPage=<%=m_cp%>&column=<%=m_column%>&key=<%=m_encoded_key%>')">
            </TD>
        </TR>

    </TABLE>

</FORM>