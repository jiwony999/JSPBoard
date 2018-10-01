<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
    // 객체 선언
    Connection conn = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 파일 업로드 관련
    String filename = null;
    int filesize = 0;
    String saveFolder = "upload_files";

    // MultipartRequest 클래스 생성자의 파라미터 설정
    ServletContext context = request.getServletContext();
    String realFolder = context.getRealPath(saveFolder);

    int sizeLimit = 10*1024*1024;
    String encType = "utf-8";
    DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

    try {
        // jdbc 설정
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";

        conn = DriverManager.getConnection(jdbcUrl,jdbcId,jdbcPw);

        // MultipartRequest 객체 생성(파일 업로드 발생)
        MultipartRequest multi = new MultipartRequest(request, realFolder, sizeLimit, encType, policy);

        // 업로드 되어 서버에 저장된 파일 이름
        filename = multi.getFilesystemName("filename");

        if (filename != null) {
            Enumeration files = multi.getFileNames();
            String fname = (String) files.nextElement();
            File file = multi.getFile(fname);
            filesize = (int) file.length();
        }

        // 전송된 데이터 추출
        String name = multi.getParameter("name");
        String mail = multi.getParameter("mail");
        String subject = multi.getParameter("subject");
        String content = multi.getParameter("content");
        String pass = multi.getParameter("pass");

        // 새로운 레코드의 RcdNo와 GrpNo 생성
        String Query1 = "select max(RcdNo), max(GrpNo) from board";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(Query1);

        rs.next();

        int uid = (rs.getInt(1))+1;
        int gid = (rs.getInt(2))+1;

        // 기타 입력 데이터 생성
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