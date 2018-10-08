<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<% request.setCharacterEncoding("utf-8"); %>
<%
    int rno = Integer.parseInt(request.getParameter("rno"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs1 = null;
    ResultSet rs2 = null;

    String encoded_key = "";

    String column = request.getParameter("column");
    if (column == null) {
        column = "";
    }

    String key = request.getParameter("key");
    if (key != null) {
        encoded_key = URLEncoder.encode(key, "utf-8");
    } else {
        key = "";
    }
    // 파일의 이름과 크기를 위한 변수 선언
    String filename = null;
    int filesize = 0;
    // 파일 업로드 폴더의 생성
    String saveFolder = "upload_files";

    // MultipartRequest 클래스 생성자의 파라미터 설정
    ServletContext context = getServletContext();
    String realFolder = context.getRealPath(saveFolder);

    int sizeLimit = 10*1024*1024;
    String encType = "utf-8";
    DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

    int CurrentPage = Integer.parseInt(request.getParameter("CurrentPage"));

    // JDBC 설정

    try {

        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";
        conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

        // 최대 RcdNo값 추출과 답변레코드의 RcdNo값 결정
        String Query1 = "select max(RcdNo) from board";
        pstmt = conn.prepareStatement(Query1);
        rs1 = pstmt.executeQuery();
        rs1.next();

        int new_rno = rs1.getInt(1) + 1;

        // 부모 레코드의 필드값 추출
        String Query2 = "select GrpNo, RcdLevel, RcdOrder from board where RcdNo=?";
        pstmt = conn.prepareStatement(Query2);
        pstmt.setInt(1, rno);
        rs2 = pstmt.executeQuery();
        rs2.next();

        int gno = rs2.getInt(1);
        int level = rs2.getInt(2);
        int order = rs2.getInt(3);
        int new_level = level + 1;
        int new_order = order + 1;

        // 기존 레코드의 RcdOrder 필드 값 재설정
        String Query3 = "update board set RcdOrder = RcdOrder+1 where GrpNo=? AND RcdOrder > ?";
        pstmt = conn.prepareStatement(Query3);
        pstmt.setInt(1, gno);
        pstmt.setInt(2, order);
        pstmt.executeUpdate();

        // MultipartRequest 객체 생성(파일 업로드 발생)
        MultipartRequest multi = new MultipartRequest(request, realFolder, sizeLimit, encType, policy);

        // 업로드되어 서버에 저장된 파일 이름 추출
        filename = multi.getFilesystemName("filename");

        // file 객체의 선언과 파일의 크기 추출
        if(filename != null) {
            Enumeration files = multi.getFileNames();
            String fname = (String) files.nextElement();
            File file = multi.getFile(fname);
            filesize = (int) file.length();
        }

        // form 구성 요소 추출과 입력 필드 값 생성
        String name = multi.getParameter("name");
        String mail = multi.getParameter("mail");
        String subject = multi.getParameter("subject");
        String content = multi.getParameter("content");
        String pass = multi.getParameter("pass");
        int refer = 0;
        long now = System.currentTimeMillis();

        // 답변 레코드 저장
        String Query4 = "insert into board values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        pstmt = conn.prepareStatement(Query4);
        pstmt.setInt(1, new_rno);
        pstmt.setInt(2, gno);
        pstmt.setString(3, name);
        pstmt.setString(4, mail);
        pstmt.setString(5, subject);
        pstmt.setString(6, content);
        pstmt.setString(7, pass);
        pstmt.setString(8, filename);
        pstmt.setInt(9, filesize);
        pstmt.setLong(10, now);
        pstmt.setInt(11, refer);
        pstmt.setInt(12, new_level);
        pstmt.setInt(13, new_order);

        pstmt.executeUpdate();
    } catch (SQLException e) {
        out.print(e);
    } finally {
        rs2.close();
        rs1.close();
        pstmt.close();
        conn.close();
        String retUrl = "BoardList.jsp?column=" + column + "&key" + encoded_key + "&CurrentPage=" + CurrentPage;
        response.sendRedirect(retUrl);
    }

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

</body>
</html>