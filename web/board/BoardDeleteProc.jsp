<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
    String passwd = request.getParameter("pass");
    int rno = Integer.parseInt(request.getParameter("rno"));

    // 변수 및 객체 선언
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String encoded_key = "";

    // 키워드 데이터 추출
    String colunmn = request.getParameter("column");
    if(colunmn == null) colunmn = null;
    String key = request.getParameter("key");
    if(key != null)
        encoded_key = URLEncoder.encode(key,"utf-8");
    else
        key = "";


    try {
        // jdbc설정
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";
        conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

        // 레코드 패스워드 추출
        String Query1 = "Select UsrPass, UsrFileName from board where RcdNo=?";
        pstmt = conn.prepareStatement(Query1);
        pstmt.setInt(1,rno);
        rs=pstmt.executeQuery();

        rs.next();
        String dbPass = rs.getString(1);
        String filename = rs.getString(2);

        if(passwd.equals(dbPass)){
            String Query2 = "delete from board where RcdNo="+rno;
            pstmt = conn.prepareStatement(Query2);
            pstmt.executeUpdate();

            if(filename != null) {
                String realFolder="";
                String saveFolder = "upload_files";

                ServletContext context = getServletContext();
                realFolder = context.getRealPath(saveFolder);

                String PathAndName = realFolder + "\\" + filename;
                File file = new File(PathAndName);

                if(!file.delete()) {
                    out.println("파일 삭제에 실패했습니다.");
                }
            }

            rs.close();
            pstmt.close();
            conn.close();

            String url = "BoardList.jsp?rno=" + rno +"&column=" + colunmn +"&key="+ encoded_key;
            response.sendRedirect(url);
        } else {
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