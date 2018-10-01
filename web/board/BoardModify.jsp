<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.sql.*" %>


<%
    int rno = Integer.parseInt(request.getParameter("rno"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs1 = null;
    String encoded_key = "";
    String column = request.getParameter("column");
    if (column == null)
        column = "";
    String key = request.getParameter("key");
    if (key != null) {
        encoded_key = URLEncoder.encode(key, "utf-8");
    } else {
        key = "";
    }
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";
        conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

        String Query1 = "UPDATE board set UsrRefer = UsrRefer+1 where RcdNo=?";
        pstmt = conn.prepareStatement(Query1);
        pstmt.setInt(1, rno);
        pstmt.executeUpdate();
        String Query2 = "select UsrName, UsrMail,UsrSubject, UsrContent, UsrFileName, UsrFileSize from board  where RcdNo=?";
        pstmt = conn.prepareStatement(Query2);
        pstmt.setInt(1, rno);
        rs1 = pstmt.executeQuery();
        rs1.next();
        String name = rs1.getString(1);
        String mail = rs1.getString(2);
        String subject = rs1.getString(3).trim();
        String content = rs1.getString(4).trim();
        String filename = rs1.getString(5);
        int filesize = rs1.getInt(6);
        filesize = filesize / 1000;
        //content = content.replaceAll("\r\n","<BR>");
%>


<HTML>
<HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=utf-8"/>
    <LINK REL="stylesheet" type="text/css" href="../include/style.css"/>

    <script type="text/javascript">
        function CheckForm(form) {
            if (!form.pass.value) {
                alert("패스워드를 입력하세요");
                form.pass.focus();
                return true;
            }
            form.submit();
        }
    </script>

    <TITLE>게시글 수정</TITLE>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
    <TR BGCOLOR=#A0A0A0>
        <TD ALIGN=CENTER><FONT SIZE=4><B>게시판 ( 게시글 수정 )</B></FONT></TD>
    </TR>
</TABLE>

<%
    //------------------------------- JSP CODE START ( 세션 변수에 따른 문서 선택 )
    String member_id = (String) session.getAttribute("member_id");
    if (member_id == null) {
%>
<jsp:include page="../member/LoginForm.jsp"/>
<%
} else {
%>
<jsp:include page="../member/LoginState.jsp"/>
<%
    }
//------------------------------- JSP CODE END
%>

<FORM NAME="BoardModify" METHOD=POST ACTION="BoardModifyProc.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=key%>"
      enctype="multipart/form-data">

    <TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>이름</B></TD>
            <TD WIDTH=500><%=name%>
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>전자우편</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=TEXT NAME="mail" SIZE=60 style="ime-mode:inactive" value="<%=mail%>">
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>제목</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=TEXT NAME="subject" SIZE=70 value="<%=subject%>">
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>내용</B></TD>
            <TD WIDTH=500>
                <TEXTAREA NAME="content" COLS=70 ROWS=5><%=content%></TEXTAREA>
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>첨부 파일</B></TD>
            <TD WIDTH=500>
                <%
                    if (filename == null) {
                        out.println("첨부된 파일이 없습니다.");
                    } else {
                        String IMGURL = "../images/btn_filedown.gif";
                        out.println("<img align=absmiddle src=" + IMGURL + ">");
                    }
                %>
                <a href="filedownload.jsp?filename=<%=filename%>"><%=filename%> (<%=filesize%> Kbyte</a>
            </TD>
        </TR>
        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>새첨부파일</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=FILE NAME="filename" SIZE=50>&nbsp;
            </TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>패스워드</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=PASSWORD NAME="pass" SIZE=20>
            </TD>
        </TR>

    </TABLE>

</FORM>

<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

    <TR ALIGN=CENTER>
        <TD>
            <IMG SRC="../images/btn_mdfy.gif" STYLE=CURSOR:HAND onclick="javascript:CheckForm(BoardModify)">&nbsp;&nbsp;
            <IMG SRC="../images/btn_cancel.gif" STYLE=CURSOR:HAND
                 onClick="javascript:location.replace('BoardList.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>')">
        </TD>
    </TR>

</TABLE>

</BODY>
</HTML>

<%
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        rs1.close();
        pstmt.close();
        conn.close();
    }
%>