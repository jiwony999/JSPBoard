<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String realFolder ="";
	String saveFolder = "upload_files";
	
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);
	out.print("저장경로 : "+realFolder+"<br>");
%>