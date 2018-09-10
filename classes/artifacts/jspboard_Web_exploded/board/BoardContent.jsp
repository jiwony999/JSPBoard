<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%
    request.setCharacterEncoding("utf-8");
%>

<%
    int rno = Integer.parseInt(request.getParameter("rno"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs1 = null;

    String encoded_key="";

    try {

        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=UTC";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";
        conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

        String column = request.getParameter("column");
        if (column == null)
            column = "";

        String key = request.getParameter("key");
        if (key != null) {
            encoded_key = URLEncoder.encode(key,"utf-8");
        } else {
            key ="";
        }

        String Query1 = "update board set UsrRefer=UsrRefer+1 where RcdNo=?";
        pstmt = conn.prepareStatement(Query1);

        pstmt.setInt(1, rno);
        pstmt.executeUpdate();

        String Query2 = "select UsrName, UsrMail, UsrSubject, UsrContent from board where RcdNo=?";
        pstmt = conn.prepareStatement(Query2);
        pstmt.setInt(1, rno);
        rs1 = pstmt.executeQuery();
        rs1.next();

        String name = rs1. getString(1);
        String mail = rs1.getString(2);
        String subject = rs1.getString(3).trim();
        String content = rs1.getString(4).trim();

        content = content.replaceAll("\r\n","<br />");
%>

<HTML>
<HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=euc-kr"/>
    <LINK REL="stylesheet" type="text/css" href="../include/style.css"/>
    <TITLE>게시글 출력</TITLE>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
    <TR BGCOLOR=#A0A0A0>
        <TD ALIGN=CENTER><FONT SIZE=4><B>게시판 ( 게시글 출력 )</B></FONT></TD>
    </TR>
</TABLE>

    <%
    //------------------------------- JSP CODE START ( 세션 변수에 따른 문서 선택 )
	String member_id = (String)session.getAttribute("member_id");
	if(member_id == null) {
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

<BODY>

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
        <TD WIDTH=120 ALIGN=CENTER><B>첨부파일</B></TD>
        <TD WIDTH=500>첨부된 파일이 없습니다.</TD>
    </TR>

</TABLE>


<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

    <TR ALIGN=CENTER>
        <TD WIDTH="310" ALIGN=LEFT>
            <IMG SRC="../images/btn_list.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardList.jsp?column=<%=column%>&key=<%=encoded_key%>')">
        </TD>
        <TD WIDTH="310" ALIGN=RIGHT>
            <IMG SRC="../images/btn_reply.gif" STYLE=CURSOR:HAND
                 onClick="javascript:location.replace('BoardReply.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>')">&nbsp;&nbsp;
            <IMG SRC="../images/btn_mdfy.gif" STYLE=CURSOR:HAND
                 onClick="javascript:location.replace('BoardModify.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>')">&nbsp;&nbsp;
            <IMG SRC="../images/btn_del.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardDelete.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>')">
        </TD>
    </TR>

</TABLE>
<%
    }catch(SQLException e){
        e.printStackTrace();
    }finally {
        rs1.close();
        pstmt.close();
        conn.close();
    }
%>

</BODY>
</HTML>