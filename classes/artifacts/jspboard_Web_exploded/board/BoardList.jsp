<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import ="java.sql.*"%>

<%request.setCharacterEncoding("utf-8");%>

<%
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs1 = null;
   ResultSet rs2 = null;

   int TotalRecords = 0;

   String Query1 = "";
   String Query2 = "";
   String encoded_key="";

   String column = request.getParameter("column");
   if(column == null) column = "";

   String key = request.getParameter("key");
   if(key!=null){
       encoded_key = URLEncoder.encode(key,"utf-8");
   } else{
       key="";
   }

   try{
	   String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=UTC";
       String jdbcId = "jspuser";
       String jdbcPw = "jsppass";

       Class.forName("com.mysql.jdbc.Driver");
       conn = DriverManager.getConnection(jdbcUrl,jdbcId,jdbcPw);

       if (column.equals("") || key.equals("")) { //column 과 key가 공백이라면 그대로 목록 출력
         Query1 = "SELECT count(RcdNo) FROM board";
         Query2 = "SELECT RcdNo, UsrSubject, UsrName, UsrDate, UsrRefer,RcdLevel FROM board ORDER BY grpno DESC, rcdorder asc";
      }else{ //공백이 아니라면 검색한 거 그대로 출력!
         Query1 = "SELECT count(RcdNo) FROM board WHERE "+column+" LIKE '%"+key+"%'";
         Query2 = "SELECT RcdNo, UsrSubject, UsrName, UsrDate, UsrRefer,RcdLevel FROM board WHERE "+column+" LIKE '%"+key+"%' ORDER BY grpno DESC rcdorder asc";
      }

       pstmt = conn.prepareStatement(Query1);
       rs1 = pstmt.executeQuery();
       pstmt = conn.prepareStatement(Query2);
       rs2 = pstmt.executeQuery();

       rs1.next();
       TotalRecords = rs1.getInt(1);

%>

<HTML>
<HEAD>
   <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=euc-kr"/>
   <LINK REL="stylesheet" type="text/css" href="../include/style.css"/>   
   <TITLE>게시글 리스트</TITLE>
</HEAD>

<BODY>

<TABLE WIDTH=620 HEIGHT=40 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>
   <TR BGCOLOR=#A0A0A0>
      <TD ALIGN=CENTER><FONT SIZE=4><B>게시판 ( 리스트 )</B></FONT></TD>
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
 
<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>

   <TR ALIGN=CENTER>
      <TD WIDTH=45><B>번호</B></TD>
      <TD WIDTH=395><B>제목</B></TD>
      <TD WIDTH=65><B>작성자</B></TD>
      <TD WIDTH=70><B>작성일</B></TD>
      <TD WIDTH=45><B>참조</B></TD>
   </TR>
<%
   while(rs2.next()){
       int rno = rs2.getInt("RcdNo");
       String subject = rs2.getString("UsrSubject");
       String name = rs2.getString("UsrName");

       long date = rs2.getLong("UsrDate");
       SimpleDateFormat Current = new SimpleDateFormat("yyyy/MM/dd");

       String today = Current.format(date);

       int refer = rs2.getInt("UsrRefer");
       int level = rs2.getInt("RcdLevel");


%>
   <TR>
      <TD WIDTH=45 ALIGN=CENTER><%=TotalRecords%></TD>
      <TD WIDTH=395 ALIGN=LEFT>
         <%
            for(int i=0; i<level; i++) out.println("&nbsp;&nbsp");
            if(level>0){
                String IMGURL ="../images/re.gif";
                out.println("<IMG ALIGN=ABSMIDDLE SRC="+IMGURL+">");
            }
            
            int max_length = 34;
            int cut_length = max_length-(level);
            
            if (subject.length() > cut_length) {
            	subject = subject.substring(0, cut_length);
            	subject = subject + "..";
            }
         %>
         <A HREF="BoardContent.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>"><%=subject%></A>
         <%
         	long now = System.currentTimeMillis();
         long dist = (now-date) / 1000;
         long during = 60*60*24;
         
         if (dist < during) {
        	 String imgurl="../images/new.gif";
        	 out.println("<img align=absmiddle width=15 height=12 src="+imgurl+">");
         }
         %>
         </TD>
      <TD WIDTH=65 ALIGN=CENTER><%=name%></TD>
      <TD ALIGN=CENTER><%=today%></TD>
      <TD ALIGN=CENTER><%=refer%></TD>
   </TR>

<%
   TotalRecords --;
   }
%>
</TABLE>

<FORM NAME="BoardSearch" METHOD=POST action="BoardList.jsp">

<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

   <TR>
      <TD ALIGN=LEFT WIDTH=100>
         <IMG SRC="../images/btn_new.gif" onClick="javascript:location.replace('BoardWrite.jsp?column=<%=column%>&key=<%=encoded_key%>')"; STYLE=CURSOR:HAND>
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
            <OPTION VALUE="" SELECTED>선택</OPTION>
            <OPTION VALUE="UsrSubject">제목</OPTION>
            <OPTION VALUE="UsrContent">내용</OPTION>
         </SELECT> 
         <INPUT TYPE=TEXT NAME="key" SIZE=10 MAXLENGTH=20> 
         <IMG SRC="../images/btn_search.gif" ALIGN=absmiddle STYLE=CURSOR:HAND
         onclick="javascript:submit()">
      </TD>    
   </TR>
   
</TABLE>

</FORM>
<%
   }
   catch (SQLException e){
       e.printStackTrace();
   }finally {
       rs2.close();
       rs1.close();
       pstmt.close();
       conn.close();
   }
%>
</BODY>
</HTML>
