<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
    int rno = Integer.parseInt(request.getParameter("rno"));

    // 변수 및 객체 선언
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

    // MultipartRequest 클래스 생성자의 파라미터 지정
    String realFolder ="";
    String saveFolder ="upload_files";
    String encType = "utf-8";
    int sizeLimit = 10*1024*1024;
    ServletContext context = getServletContext();
    realFolder = context.getRealPath(saveFolder);
    MultipartRequest multi = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";
        conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

        // MultipartRequest 객체와 파일 이름 추출
        multi = new MultipartRequest(request, realFolder, sizeLimit, encType, new DefaultFileRenamePolicy());
        String filename = multi.getFilesystemName("filename");



        String mail = multi.getParameter("mail");
        String subject = multi.getParameter("subject");
        String content = multi.getParameter("content");
        String passwd = multi.getParameter("pass");
        String Query1 = "Select UsrPass, UsrFileName from board where RcdNo=?";
        pstmt = conn.prepareStatement(Query1);
        pstmt.setInt(1,rno);
        rs=pstmt.executeQuery();
        rs.next();
        String dbPass = rs.getString(1);
        String oldFileName = rs.getString(2);
        if(passwd.equals(dbPass)){
            if(filename != null) { // 새로운 업로드 파일이 존재할 경우
                if(oldFileName != null) { // 첨부 파일이 이미 존재하는 경우 제거
                    String PathAndName = realFolder + "\\" + oldFileName;
                    File file1 = new File(PathAndName);
                    if(!file1.delete()) {
                        out.println("파일 삭제에 실패했습니다.");
                    }
                }

                // 새로 업로드되는 파일의 크기 추출
                Enumeration files = multi.getFileNames();
                String fname = (String) files.nextElement();
                File file = multi.getFile(fname);
                int filesize = (int) file.length();

                // 파일정보를 포함한 데이터베이스 갱신
                String Query2 = "update board set UsrMail=?, UsrSubject=?, UsrContent=?, UsrFileName=?,UsrFileSize=? where RcdNo=?";

                pstmt = conn.prepareStatement(Query2);
                pstmt.setString(1, mail);
                pstmt.setString(2, subject);
                pstmt.setString(3, content);
                pstmt.setString(4, filename);
                pstmt.setInt(5, filesize);
                pstmt.setInt(6, rno);

                pstmt.executeUpdate();

            } else {
                String Query2 = "update board set UsrMail=?, UsrSubject=?, UsrContent=? where RcdNo=?";
                pstmt = conn.prepareStatement(Query2);
                pstmt.setString(1,mail);
                pstmt.setString(2,subject);
                pstmt.setString(3,content);
                pstmt.setInt(4,rno);
                pstmt.executeUpdate();
            }

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
            out.println("</script>");
            out.flush();
        }
    }catch (SQLException e) {
        e.printStackTrace();
    }
%>