<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<HTML>
<HEAD>
	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=euc-kr"/>
	<LINK REL="stylesheet" type="text/css" href="../include/style.css"/>		
	<TITLE>�亯�� �Է�</TITLE>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
	<TR BGCOLOR=#A0A0A0>
		<TD ALIGN=CENTER><FONT SIZE=4><B>�Խ��� ( �亯�� �Է� )</B></FONT></TD>
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

<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=2 ALIGN=CENTER>

	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>��������</B></TD>
		<TD WIDTH=500>������ �����Դϴ�</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>���۳���</B></TD>
		<TD WIDTH=500>������ �����Դϴ�.</TD>
	</TR>
	
</TABLE>
<BR>

<FORM NAME="BoardReply" METHOD=POST ACTION="BoardReplyProc.jsp">

<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=2 ALIGN=CENTER>

	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>�̸�</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=TEXT NAME="name" SIZE=20 style="ime-mode:active">
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>���ڿ���</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=TEXT NAME="mail" SIZE=60 style="ime-mode:inactive">
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=TEXT NAME="subject" SIZE=70>
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����</B></TD>
		<TD WIDTH=500>
			<TEXTAREA NAME="content" COLS=70 ROWS=5></TEXTAREA>
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����÷��</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=FILE NAME="filename" SIZE=60>
		</TD>
	</TR> 
	  
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>�н�����</B></TD>
		<TD WIDTH=500>
			<INPUT TYPE=PASSWORD NAME="pass" SIZE=20>
		</TD>
	</TR>
	
</TABLE>

</FORM>

<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

	<TR ALIGN=CENTER>
		<TD>
			<IMG SRC="../images/btn_save.gif" STYLE=CURSOR:HAND>&nbsp;&nbsp;
			<IMG SRC="../images/btn_cancel.gif" STYLE=CURSOR:HAND>
		</TD>
	</TR>
	
</TABLE>

</BODY>
</HTML>