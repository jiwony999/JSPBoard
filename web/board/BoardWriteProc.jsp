<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
    // 객체 선언
    Connection conn = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // jdbc 설정
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";

        conn = DriverManager.getConnection(jdbcUrl,jdbcId,jdbcPw);

        // 전송된 데이터 추출
        String mail = request.getParameter("mail");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
        String pass = request.getParameter("pass");

        // 새로운 레코드의 RcdNo와 GrpNo 생성
        String Query1 = "select max(RcdNo), max(GrpNo) from board";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(Query1);

        rs.next();

        int uid = (rs.getInt(1))+1;
        int gid = (rs.getInt(2))+1;

        // 기타 입력 데이터 생성
        String filename = null;
        int filesize = 0;
        int refer = 0;
        int level = 0;
        int order = 1;
        long now = System.currentTimeMillis();

        // 입력 질의 수행
        String Query2 = "insert into board values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        pstmt = conn.prepareStatement(Query2);
        pstmt.setInt(1, uid);
        pstmt.setInt(2, gid);
        pstmt.setString(3, name);
        pstmt.setString(4, mail);
        pstmt.setString(5, subject);
        pstmt.setString(6, content);
        pstmt.setString(7, pass);
        pstmt.setString(8, filename);
        pstmt.setInt(9, filesize);
        pstmt.setLong(10, now);
        pstmt.setInt(11, refer);
        pstmt.setInt(12, level);
        pstmt.setInt(13, order);

        pstmt.executeUpdate();
    } catch(SQLException e) {
        out.print(e);
    } finally {
        // 생성된 객체의 제거와 페이지 이동
        rs.close();
        pstmt.close();
        conn.close();
        response.sendRedirect("BoardList.jsp");
    }
%>