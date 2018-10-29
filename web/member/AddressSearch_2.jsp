<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
    String frm = request.getParameter("frm");
    String UserAddress = request.getParameter("UserAddress");

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs1 = null;
    ResultSet rs2 = null;

    try {
        String jdbcUrl = "jdbc:mysql://localhost:3306/jspdb";
        String jdbcId = "jspuser";
        String jdbcPw = "jsppass";

        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

        String Query1 = "select count(seq) from zipcode where dong like '%" + UserAddress + "%'";
        stmt = conn.createStatement();
        rs1 = stmt.executeQuery(Query1);
        rs1.next();

        int rows = rs1.getInt(1);
%>
<HTML>
<HEAD>
    <META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=utf-8"/>
    <LINK REL="stylesheet" type="text/css" href="../include/style.css">
    <TITLE>주소찾기 - 2단계</TITLE>
    <script>
        function CheckForm(form) {
            if (!form.UserAddress.focus()) {
                alert('읍면동 이름을 입력하세요.');
                form.UserAddress.focus();
                return;
            }
            form.submit();
        }

        function InputAddress(zipcode, sido, gugun, dong, frm) {
            var parent_form = eval("opener.document." + frm);
            zipcode_1 = zipcode.substring(0, 3);
            zipcode_2 = zipcode.substring(4, 7);
            address = sido + " " + gugun + " " + dong;

            parent_form.ZipCode1.value = zipcode_1;
            parent_form.ZipCode2.value = zipcode_2;
            parent_form.UserAddress1.value = address;
            parent_form.UserAddress2.focus();

            self.close();
        }
    </script>
</HEAD>

<BODY TOPMARGIN=0 LEFTMARGIN=0>

<TABLE WIDTH=500 CELLSPACING=0 CELLPADDING=0 TOPMARGIN=0 LEFTMARGIN=0>

    <TR BGCOLOR=#A0A0A0>
        <TD ALIGN=CENTER HEIGHT=30><FONT COLOR=WHITE SIZE=3><B>주소찾기 - 2단계</B></FONT></TD>
    </TR>

    <%
        if (rows > 0) {
            //------------------------------- 해당 주소가 존재하는 경우 주소 선택
    %>

    <TR>
        <TD ALIGN=CENTER>
            <TABLE WIDTH=450 CELLSPACING=0 CELLPADDING=0 TOPMARGIN=0 LEFTMARGIN=0>
                <TR>
                    <TD ALIGN=CENTER HEIGHT=30><BR>총 <b><%=rows%></b>개의 주소가 검색되었습니다.</TD>
                </TR>
                <TR>
                    <TD HEIGHT=2 BGCOLOR=#AAAAAA></TD>
                </TR>
                <TR>
                    <TD HEIGHT=2 BGCOLOR=#FFFFFF></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>

    <%
        String Query2 = "select zipcode, sido, gugun, dong, bunji from zipcode where dong like '%" + UserAddress + "%'";

        stmt = conn.createStatement();
        rs2 = stmt.executeQuery(Query2);

        while (rs2.next()) {
            String zcode = rs2.getString(1);
            String sido = rs2.getString(2);
            String gugun = rs2.getString(3);
            String dong = rs2.getString(4);
            String bunji = rs2.getString(5);

            String Address = "[" + zcode + "]" + sido + " " + gugun + " " + dong + " " + bunji;

    %>

    <TR>
        <TD ALIGN=CENTER>
            <TABLE WIDTH=400 CELLSPACING=0 CELLPADDING=0 TOPMARGIN=0 LEFTMARGIN=0>
                <TR>
                    <TD WIDTH=400 HEIGHT=2 BGCOLOR=#FFFFFF></TD>
                </TR>
                <TR>
                    <TD>
                        <a href="javascript:InputAddress('<%=zcode%>','<%=sido%>','<%=gugun%>','<%=dong%>','<%=frm%>')"><%=Address%>></a>
                    </TD>
                </TR>
                <TR>
                    <TD HEIGHT=1 BGCOLOR=#FFFFFF></TD>
                </TR>
                <TR>
                    <TD HEIGHT=1 BGCOLOR=#E2E2E2></TD>
                </TR>
                <TR>
                    <TD HEIGHT=1 BGCOLOR=#FFFFFF></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>
    <%
        }
    %>
    <TR>
        <TD ALIGN=CENTER>
            <TABLE WIDTH=450 CELLSPACING=0 CELLPADDING=0 TOPMARGIN=0 LEFTMARGIN=0>
                <TR>
                    <TD HEIGHT=10 BGCOLOR=#FFFFFF></TD>
                </TR>
                <TR>
                    <TD HEIGHT=3 BGCOLOR=#AAAAAA></TD>
                </TR>
                <TR>
                    <TD HEIGHT=3 BGCOLOR=#FFFFFF></TD>
                </TR>
            </TABLE>
        </TD>
    </TR>

    <%
        rs2.close();
    } else {
        //------------------------------- 해당 주소가 존재하지 않는 경우 처리
    %>

    <TR>
        <TD ALIGN=CENTER>

            <FORM NAME="AddressSearch2" METHOD=POST ACTION="AddressSearch_2.jsp?frm=<%=frm%>">

                <TABLE WIDTH=400 CELLSPACING=0 CELLPADDING=0 TOPMARGIN=0 LEFTMARGIN=0>

                    <TR>
                        <TD WIDTH=400 HEIGHT=2 BGCOLOR=#FFFFFF></TD>
                    </TR>

                    <TR>
                        <TD ALIGN=CENTER><BR>해당 주소가 존재하지 않습니다. 다시 입력하세요.</TD>
                    </TR>

                    <TR>
                        <TD HEIGHT=3 BGCOLOR=#FFFFFF></TD>
                    </TR>
                    <TR>
                        <TD HEIGHT=1 BGCOLOR=#E2E2E2></TD>
                    </TR>
                    <TR>
                        <TD HEIGHT=4 BGCOLOR=#FFFFFF></TD>
                    </TR>

                    <TR>
                        <TD ALIGN=CENTER>
                            <INPUT TYPE=TEXT NAME="UserAddress" SIZE=20 MAXLENGTH=20>
                            <IMG SRC="../images/btn_search.gif" BORDER=0 ALIGN=ABSMIDDLE STYLE=CURSOR:HAND
                                 onclick="javascript:CheckcForm(AddressSearch2)"><BR><BR>
                            찾고자 하시는 읍, 명, 동의 이름을 입력하세요.<BR>(예) 신도림동인 경우 '신도림'
                        </TD>
                    </TR>

                </TABLE>

            </FORM>

        </TD>
    </TR>

    <%
            }
        } catch
        (SQLException e) {
            e.printStackTrace();
        } finally {
            rs1.close();
            stmt.close();
            conn.close();

        }

    %>

</TABLE>

</BODY>
</HTML>