<%--
  Created by IntelliJ IDEA.
  User: jiwon
  Date: 2018-09-10
  Time: 오후 1:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%request.setCharacterEncoding("utf-8");%>


<html>
<head>
    <title>Title</title>
</head>
<body>


<form name="FileUp"  method=post enctype="multipart/form-data" action="FileUpTestProc.jsp">
    <table border=1>
        <tr>
            <td width=100 align=center>name</td>
            <td width=400 ><input type="text" name="username" size="15"></td>
        </tr>

        <tr>
            <td width=100 align=center>학번</td>
            <td width=400 ><input type="text" name="usernumber" size="15"></td>
        </tr>

        <tr>
            <td width=100 align=center>file</td>
            <td width=400 ><input type="file" name="userfile" size="30"></td>
        </tr>
    </table>

    <input type="submit" value="전송">
</form>

</body>
</html>