<script src="libs/themes/default/semantic.min.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../custom-property.jsp" %>


<%
    if (getCustomValueProperty(request, "footer-enable").equals("true")) {
%>
<div style=" position: fixed; bottom: 0; width: 100%">
    <div style="
            display: flex;
            justify-content: space-around;
            background-color: <%=getCustomValueProperty(request,"footer-background-color")%>;
            color: <%=getCustomValueProperty(request,"footer-color")%>;
            padding: 14px;
            ">

        <%if (getCustomValueProperty(request,"information-address") != null&&!getCustomValueProperty(request,"information-address").trim().isEmpty()){%>
        <div><%=getCustomValueProperty(request, "information-address")%></div>
        <%}%>

        <%if (getCustomValueProperty(request,"information-website") != null&&!getCustomValueProperty(request,"information-website").trim().isEmpty()){%>
        <div><%=getCustomValueProperty(request, "information-website")%></div>
        <%}%>

        <%if (getCustomValueProperty(request,"information-phone") != null&&!getCustomValueProperty(request,"information-phone").trim().isEmpty()){%>
        <div><%=getCustomValueProperty(request, "information-phone")%></div>
        <%}%>

        <%if (getCustomValueProperty(request,"information-email") != null&&!getCustomValueProperty(request,"information-email").trim().isEmpty()){%>
        <div><%=getCustomValueProperty(request, "information-email")%></div>
        <%}%>
    </div>
</div>
<%
    }
%>
