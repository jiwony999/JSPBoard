<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<% request.setCharacterEncoding("utf-8");%>

<%
    // 레코드 식별자 추출
    int rno = Integer.parseInt(request.getParameter("rno"));

    // 변수 및 객체 선언
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String encoded_key = "";

    // 키워드 데이터 추출
    String column = request.getParameter("column");
    if (column == null)
        column = "";
    String key = request.getParameter("key");
    if (key != null) {
        encoded_key = URLEncoder.encode(key,"utf-8");
    } else {
        key ="";
    }

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=UTC";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";
        conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

        // 질의의 생성 및 수행
        String Query1 = "select UsrName, UsrMail,UsrSubject, UsrContent from board where RcdNo=?";
        pstmt = conn.prepareStatement(Query1);
        pstmt.setInt(1, rno);
        rs = pstmt.executeQuery();

        // 필드 값 추출
        rs.next();

        String name = rs.getString(1);
        String mail = rs.getString(2);
        String subject = rs.getString(3).trim();
        String content = rs.getString(4);
        content.replaceAll("\r\n","<br>");
%>
<HTML>
<HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=utf-8"/>
    <LINK REL="stylesheet" type="text/css" href="../include/style.css"/>
    <TITLE>게시글 삭제</TITLE>

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
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
    <TR BGCOLOR=#A0A0A0>
        <TD ALIGN=CENTER><FONT SIZE=4><B>게시판 ( 게시글 삭제 )</B></FONT></TD>
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

<FORM NAME="BoardDelete" METHOD=POST ACTION="BoardDeleteProc.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>">

    <TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>이름</B></TD>
            <TD WIDTH=500><%=name%></TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>전자우편</B></TD>
            <TD WIDTH=500><%=mail%></TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>제목</B></TD>
            <TD WIDTH=500><%=subject%></TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>내용</B></TD>
            <TD WIDTH=500><%=content%></TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>파일첨부</B></TD>
            <TD WIDTH=500>첨부된 파일이 없습니다.</TD>
        </TR>

        <TR>
            <TD WIDTH=120 ALIGN=CENTER><B>패스워드</B></TD>
            <TD WIDTH=500>
                <INPUT TYPE=PASSWORD NAME="pass" SIZE=20>
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

<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

    <TR ALIGN=CENTER>
        <TD>
            <IMG SRC="../images/btn_del.gif" STYLE=CURSOR:HAND onClick="javascript:CheckForm(BoardDelete)">&nbsp;&nbsp;
            <IMG SRC="../images/btn_cancel.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardContent.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>')">
        </TD>
    </TR>

</TABLE>

</BODY>
</HTML>