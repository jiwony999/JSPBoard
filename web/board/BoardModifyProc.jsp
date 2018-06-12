<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<% request.setCharacterEncoding("euc-kr");%>

<%
    // 레코드 식별자 추출
    int rno = Integer.parseInt(request.getParameter("rno"));

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
        encoded_key = URLEncoder.encode(key, "utf-8");
    } else {
        key = "";
    }

    try {
        // jdbc 설정
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";

        conn = DriverManager.getConnection(jdbcUrl,jdbcId,jdbcPw);

        // 전달된 데이터 추출
        String mail = request.getParameter("mail");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
        String pass = request.getParameter("pass");

        // 레코드 패스워드 추출
        String Query1 = "select UsrPass from board where RcdNo=?";
        pstmt = conn.prepareStatement(Query1);
        pstmt.setInt(1, rno);
        rs = pstmt.executeQuery();

        rs.next();
        String dbPass = rs.getString(1);

        // 패스워드의 비교와 레코드의 삭제

        if (pass.equals(dbPass)) {
            String Query2 = "update board set UsrMail=?, UsrSubject=?, UsrContent=? where RcdNo=?";
            pstmt = conn.prepareStatement(Query2);
            pstmt.setString(1, mail);
            pstmt.setString(2, subject);
            pstmt.setString(3, content);
            pstmt.setInt(4, rno);

            pstmt.executeUpdate();

            rs.close();
            pstmt.close();
            conn.close();
            String retUrl = "BoardContent.jsp?rno="+rno+"&column="+column+"&key="+encoded_key;
            response.sendRedirect(retUrl);

        } else {
            rs.close();
            pstmt.close();
            conn.close();
            out.println("<script>");
            out.println("alert('패스워드가 틀렸습니다.')");
            out.println("history.back()");
            out.println("</script>");
            out.flush();
        }

    } catch(SQLException e) {
        out.print(e);
    }
%>