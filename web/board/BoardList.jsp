<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<HTML>
<HEAD>
	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=euc-kr"/>
	<LINK REL="stylesheet" type="text/css" href="../include/style.css"/>	
	<TITLE>�Խñ� ����Ʈ</TITLE>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
	<TR BGCOLOR=#A0A0A0>
		<TD ALIGN=CENTER><FONT SIZE=4><B>�Խ��� ( ����Ʈ )</B></FONT></TD>
	</TR>
</TABLE>

<%
//------------------------------- JSP CODE START ( ���� ������ ���� ���� ���� )
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
 
<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>

	<TR ALIGN=CENTER>
		<TD WIDTH=45><B>��ȣ</B></TD>
		<TD WIDTH=395><B>����</B></TD>
		<TD WIDTH=65><B>�ۼ���</B></TD>
		<TD WIDTH=70><B>�ۼ���</B></TD>
		<TD WIDTH=45><B>����</B></TD>
	</TR>
	
	<TR>
		<TD WIDTH=45 ALIGN=CENTER>1</TD>
		<TD WIDTH=395 ALIGN=LEFT><A HREF="BoardContent.jsp">ȫ�浿�Դϴ�.</A></TD>
		<TD WIDTH=65 ALIGN=CENTER>ȫ�浿</TD>
		<TD ALIGN=CENTER>2013-10-10</TD>
		<TD ALIGN=CENTER>1</TD>
	</TR>
</TABLE>

<FORM NAME="BoardSearch" METHOD=POST action="BoardList.jsp">

<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

	<TR>
		<TD ALIGN=LEFT WIDTH=100>
			<IMG SRC="../images/btn_new.gif" onClick="javascript:location.replace('BoardWrite.jsp')"; STYLE=CURSOR:HAND>
		</TD>
		<TD WIDTH=320 ALIGN=CENTER>
			<IMG SRC="../images/btn_bf_block.gif">&nbsp;
			<IMG SRC="../images/btn_bf_page.gif">&nbsp;    	
			1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6&nbsp;&nbsp;7&nbsp;&nbsp;8&nbsp;&nbsp;9&nbsp;&nbsp;10&nbsp;
			<IMG SRC="../images/btn_nxt_page.gif">&nbsp; 
			<IMG SRC="../images/btn_nxt_block.gif">    	    		     
		</TD>
		<TD WIDTH=200 ALIGN=RIGHT>
			<SELECT NAME="column" SIZE=1>
				<OPTION VALUE="" SELECTED>����</OPTION>
				<OPTION VALUE="UsrSubject">����</OPTION>
				<OPTION VALUE="UsrContent">����</OPTION>
			</SELECT> 
			<INPUT TYPE=TEXT NAME="key" SIZE=10 MAXLENGTH=20> 
			<IMG SRC="../images/btn_search.gif" ALIGN=absmiddle STYLE=CURSOR:HAND>
		</TD>    
	</TR>
	
</TABLE>

</FORM>

</BODY>
</HTML>