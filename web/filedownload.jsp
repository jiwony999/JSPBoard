<%@ page import="java.nio.file.Path" %>
<%@ page import="java.io.File" %><%--
  Created by IntelliJ IDEA.
  User: jiwon
  Date: 2018-09-10
  Time: 오후 2:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>

<%--<%--%>
<%--try{--%>
<%--String filename = request.getParameter("filename");--%>
<%--String realFolder = "";--%>
<%--String saveFolder = "upload_files";--%>
<%--ServletContext context = getServletContext();--%>
<%--realFolder = context.getRealPath(saveFolder);--%>

<%--String PathAndName = realFolder+"/"+filename;--%>
<%--File file = new File(PathAndName);--%>

<%--String fileName = new String(request.getParameter("filename").getBytes("euc-kr"),"ISO-8859-1");--%>

<%--response.setContentType("application/octer-stream");--%>
<%--response.setHeader("Content-Disposition", "attachment:filename="+fileName+"");--%>
<%--response.setHeader("Content=Transfer=Encoding", "binary");--%>
<%--response.setContentLength((int)file.length());--%>
<%--response.setHeader("Cache-control", "no-cache");--%>

<%--byte[] data = new byte[1024*1024];--%>

<%--BufferedInputStream fis = new BufferedInputStream(new FileInputStream(file));--%>
<%--BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());--%>

<%--int count = 0;--%>
<%--while ((count = fis.read()) != -1){--%>
<%--fos.write(data);--%>

<%--}--%>
<%--if (fis != null) fis.close();--%>
<%--if(fos != null) fos.close();--%>
<%--}catch (IOException e){--%>
<%--System.out.println("downlaod Error : " + e);--%>
<%--}--%>
<%--%>--%>
<%
    try{
        String filename = request.getParameter("filename");
        String realFolder="";
        String saveFolder = "upload_files";
        ServletContext context = getServletContext();
        realFolder = context.getRealPath(saveFolder);

        String PathAndName = realFolder+"/"+filename;
        File file = new File(PathAndName);

//        out.clear();
//        pageContext.pushBody();

        String fileName = new String(request.getParameter("filename").getBytes("euc-kr"), "ISO-8859-1");

        response.setContentType("application/octer-stream");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName+"");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setContentLength((int)file.length());
        response.setHeader("Cache-control", "no-cache");

        byte[] data = new byte[1024*1024];

        BufferedInputStream fis = new BufferedInputStream(new FileInputStream(file));
        BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());

        int count = 0;
        while((count = fis.read(data)) != -1){
            fos.write(data);
        }
        if(fis!=null) fis.close();
        if(fos!=null) fos.close();

    }catch(IOException e){
        System.out.println("download error : "+e);
    }

%>

<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>