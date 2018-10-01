<%--
  Created by IntelliJ IDEA.
  User: jiwon
  Date: 2018-09-10
  Time: 오전 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%request.setCharacterEncoding("utf-8");%>

<%
    String saveFolder = "upload_files";
    MultipartRequest multi = null;


    ServletContext context = getServletContext();
    String realFolder = context.getRealPath(saveFolder);
    out.println(saveFolder);
    int limitSize = 10 * 1024 * 1024;
    String encType = "utf-8";
    DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
    multi = new MultipartRequest(request, realFolder, limitSize, encType, policy);
    String name = multi.getParameter("username");
    int number = Integer.parseInt(multi.getParameter("usernumber"));
    String filename = multi.getFilesystemName("userfile");
    out.println("저장된 파일명" + filename + "<br>");
    String originfilename = multi.getOriginalFileName("userfile");
    out.println("업로드 파일명" + originfilename + "<br>");
    if (filename != null) {
        Enumeration files = multi.getFileNames();
        String fname = (String) files.nextElement();
        out.println("fname : " + fname + "<BR>");
        File file = multi.getFile(fname);
        int filesize = (int) file.length();
        out.println("파일의 크기 >> " + filesize + "<br>");
        String filetype = multi.getContentType(fname);
        out.println("파일 타입 >> " + filetype + "<br>");
    }
%>

<a href="\filedownload.jsp?filename=<%=filename%>"><%=filename%></a>