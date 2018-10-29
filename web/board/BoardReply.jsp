<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
    int rno = Integer.parseInt(request.getParameter("rno"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String encoded_key = "";

    String column = request.getParameter("column");
    if (column == null) {
        column = "";
    }

    String key = request.getParameter("key");
    if (key != null) {
        encoded_key = URLEncoder.encode(key, "utf-8");
    } else {
        key = "";
    }

    int CurrentPage = Integer.parseInt(request.getParameter("CurrentPage"));

    // JDBC 설정

    try {

        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";
        conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

        String Query1 = "select UsrSubject, UsrContent from board where RcdNo=?";
        pstmt = conn.prepareStatement(Query1);
        pstmt.setInt(1, rno);
        rs = pstmt.executeQuery();
        rs.next();

        String subject = rs.getString(1).trim();
        String content = rs.getString(2).trim();
        content = content.replaceAll("\r\n", "<br>");
%>
<HTML>
<HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=utf-8"/>
    <LINK REL="stylesheet" type="text/css" href="../include/style.css"/>
    <script language="javascript" src="../include/scripts.js"></script>

    <script>
        // 필수 입력 데이터 검사
        function CheckForm(form) {
            if (!form.name.value) {
                alert("성명을 입력하세요");
                form.name.focus();
                return true;
            }

            if (form.mail.value) {
                if (!isCorrectEmail('BoardReply', 'mail')) {
                    alert("이메일 형식이 올바르지 않습니다.");
                    form.mail.focus();
                    form.mail.select();
                    return true;
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
    </script>

    <TITLE>답변글 입력</TITLE>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1
       ALIGN=CENTER>
    <TR BGCOLOR=#A0A0A0>
        <TD ALIGN=CENTER><FONT SIZE=4><B>게시판 ( 답변글 입력 )</B></FONT></TD>
    </TR>
</TABLE>

<%
    //------------------------------- JSP CODE START ( 세션 변수에 따른 문서 선택 )
    String member_id = (String) session.getAttribute("member_id");
    if (member_id == null) {
%>

<jsp:include page="../member/LoginForm.jsp">
    <jsp:param name="CurrentPage" value="<%=CurrentPage%>" />
    <jsp:param name="column" value="<%=column%>" />
    <jsp:param name="key" value="<%=key%>" />
</jsp:include>
<%
} else {
%>
<jsp:include page="../member/LoginState.jsp"/>
<%
    }
    //------------------------------- JSP CODE END
%>

<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=2 ALIGN=CENTER>

    <TR>
        <TD WIDTH=120 ALIGN=CENTER><B>원글제목</B></TD>
        <TD WIDTH=500><%=subject%>
        </TD>
    </TR>

    <TR>
        <TD WIDTH=120 ALIGN=CENTER><B>원글내용</B></TD>
        <TD WIDTH=500><%=content%>
        </TD>
    </TR>

</TABLE>
<BR>

<FORM NAME="BoardReply" METHOD=POST
      ACTION="BoardReplyProc.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>" enctype="multipart/form-data">

    <TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=2 ALIGN=CENTER>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>이름</B></TD>
            <TD WIDTH=500><INPUT TYPE=TEXT NAME="name" SIZE=20
                                 style="ime-mode: active" onKeyDown="javascript:Korean()"></TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>전자우편</B></TD>
            <TD WIDTH=500><INPUT TYPE=TEXT NAME="mail" SIZE=60
                                 style="ime-mode: inactive"></TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>제목</B></TD>
            <TD WIDTH=500><INPUT TYPE=TEXT NAME="subject" SIZE=70>
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>내용</B></TD>
            <TD WIDTH=500><TEXTAREA NAME="content" COLS=70 ROWS=5></TEXTAREA>
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>파일첨부</B></TD>
            <TD WIDTH=500><INPUT TYPE=FILE NAME="filename" SIZE=60>
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>패스워드</B></TD>
            <TD WIDTH=500><INPUT TYPE=PASSWORD NAME="pass" SIZE=20>
            </TD>
        </TR>

    </TABLE>

</FORM>

<%
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        rs.close();
        pstmt.close();
        conn.close();
    }
%>

<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1
       ALIGN=CENTER>

    <TR ALIGN=CENTER>
        <TD><IMG SRC="../images/btn_save.gif" STYLE="CURSOR: HAND"
                 onClick="javascript:CheckForm(BoardReply)">&nbsp;&nbsp; <IMG
                SRC="../images/btn_cancel.gif" STYLE="CURSOR: HAND"
                onClick="javascript:location.replace('BoardContent.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>')">
        </TD>
    </TR>

</TABLE>

</BODY>
</HTML>