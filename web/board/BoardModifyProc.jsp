<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
    int rno = Integer.parseInt(request.getParameter("rno"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String encoded_key = "";
    String colunmn = request.getParameter("column");
    if(colunmn == null) colunmn = null;
    String key = request.getParameter("key");
    if(key != null)
        encoded_key = URLEncoder.encode(key,"utf-8");
    else
        key = "";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";
        conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);
        String mail = request.getParameter("mail");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
        String passwd = request.getParameter("pass");
        String Query1 = "Select UsrPass from board where RcdNo=?";
        pstmt = conn.prepareStatement(Query1);
        pstmt.setInt(1,rno);
        rs=pstmt.executeQuery();
        rs.next();
        String dbPass = rs.getString(1);
        if(passwd.equals(dbPass)){
            String Query2 = "update board set UsrMail=?, UsrSubject=?, UsrContent=? where RcdNo=?";
            pstmt = conn.prepareStatement(Query2);
            pstmt.setString(1,mail);
            pstmt.setString(2,subject);
            pstmt.setString(3,content);
            pstmt.setInt(4,rno);
            pstmt.executeUpdate();
            rs.close();
            pstmt.close();
            conn.close();
            String url = "BoardContent.jsp?rno=" + rno +"&column=" + colunmn +"&key="+ encoded_key;
            response.sendRedirect(url);
        }
        else{
            rs.close();
            pstmt.close();
            conn.close();
            out.println("<script language=\"javascript\">");
            out.println("alert('패스워드가 틀렸습니다')");
            out.println("history.back()");
            out.flush();
        }
    }catch (SQLException e) {
        e.printStackTrace();
    }
%>