<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<HTML>
<HEAD>
	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=euc-kr"/>
	<LINK REL="stylesheet" type="text/css" href="../include/style.css"/>		
	<TITLE>�Խñ� ���</TITLE>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
	<TR BGCOLOR=#A0A0A0>
		<TD ALIGN=CENTER><FONT SIZE=4><B>�Խ��� ( �Խñ� ��� )</B></FONT></TD>
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

<BODY>

<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>

	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>�̸�</B></TD>
		<TD WIDTH=500>ȫ�浿</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>���ڿ���</B></TD>
		<TD WIDTH=500>hong@abc.com</TD>
	</TR>
	
		<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����</B></TD>
		<TD WIDTH=500>ȫ�浿�Դϴ�.</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>����</B></TD>
		<TD WIDTH=500>�ȳ��ϼ���.<BR>ȫ�浿�Դϴ�.</TD>
	</TR>
	
	<TR>
		<TD WIDTH=120 ALIGN=CENTER><B>÷������</B></TD>
		<TD WIDTH=500>÷�ε� ������ �����ϴ�.</TD>
	</TR> 
	 
</TABLE>


<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

	<TR ALIGN=CENTER>
		<TD WIDTH="310" ALIGN=LEFT>
			<IMG SRC="../images/btn_list.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardList.jsp')">
		</TD>
		<TD WIDTH="310" ALIGN=RIGHT>    	
			<IMG SRC="../images/btn_reply.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardReply.jsp')">&nbsp;&nbsp;
			<IMG SRC="../images/btn_mdfy.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardModify.jsp')">&nbsp;&nbsp;
			<IMG SRC="../images/btn_del.gif" STYLE=CURSOR:HAND onClick="javascript:location.replace('BoardDelete.jsp')">
		</TD>
	</TR>
	
</TABLE>

</BODY>
</HTML>