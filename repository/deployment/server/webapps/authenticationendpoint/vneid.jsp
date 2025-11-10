<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.util.IdentityManagementEndpointUtil" %>
<%@ page import="java.io.File" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="layout" uri="org.wso2.identity.apps.taglibs.layout.controller" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ include file="includes/localize.jsp" %>
<jsp:directive.include file="includes/init-url.jsp"/>
<jsp:directive.include file="includes/branding-preferences.jsp"/>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.model.AuthenticatedIdPData" %>
<%@ page import="org.wso2.carbon.identity.application.common.model.ClaimMapping" %>
<%@ page import="org.wso2.carbon.user.core.UserStoreManager" %>
<%@ include file="wservice.jsp" %>

<%
    String cccd = null;
    AuthenticationContext vneidAuthenticationContext = FrameworkUtils.getContextData(request);
    HashMap<String, String> local_vneid = new HashMap<>();
    local_vneid.put("http://wso2.org/claims/fullname", "HoVaTen");
    local_vneid.put("http://wso2.org/claims/id_vneid", "sub");
    local_vneid.put("http://wso2.org/claims/emailaddress", "Email");
    local_vneid.put("http://wso2.org/claims/mobile", "Mobile");
    Map<String, String> vneid_claims = new HashMap<>();
    AuthenticatedIdPData authenticatedIdPData = vneidAuthenticationContext.getCurrentAuthenticatedIdPs().entrySet().iterator().next().getValue();

    for (Map.Entry<ClaimMapping, String> claimMappingStringEntry : authenticatedIdPData.getUser().getUserAttributes().entrySet()) {
        String key = claimMappingStringEntry.getKey().getRemoteClaim().getClaimUri();
        String value = claimMappingStringEntry.getValue();
        vneid_claims.put(key, value);
        if ("citizenId".equals(key)) cccd = value;
    }
    String local_username = getUsernameFromMappingClaim(cccd, "http://wso2.org/claims/citizenId", vneidAuthenticationContext.getTenantDomain(), null);
    String id_vneid = getClaimValue(vneidAuthenticationContext.getTenantDomain(), local_username, "http://wso2.org/claims/id_vneid");
    vneidAuthenticationContext.setProperty("vneid_claims", vneid_claims);
    vneidAuthenticationContext.setProperty("local_vneid", local_vneid);
    vneidAuthenticationContext.setProperty("local_username", local_username);
%>
<%
    layoutData.put("containerSize", "medium");
%>
<html lang="en-US">
<head>
    <%
        File headerFile = new File(getServletContext().getRealPath("extensions/header.jsp"));
        if (headerFile.exists()) {
    %>
    <jsp:include page="extensions/header.jsp"/>
    <% } else { %>
    <jsp:include page="includes/header.jsp"/>
    <% } %>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
</head>
<body class="login-portal layout sms-otp-portal-layout">
<layout:main layoutName="<%= layout %>" layoutFileRelativePath="<%= layoutFileRelativePath %>" data="<%= layoutData %>">
    <layout:component componentName="ProductHeader">
        <%
            String productTitleFilePath = "extensions/product-title.jsp";
            if (StringUtils.isNotBlank(customLayoutFileRelativeBasePath)) {
                productTitleFilePath = customLayoutFileRelativeBasePath + "/product-title.jsp";
            }
            if (!new File(getServletContext().getRealPath(productTitleFilePath)).exists()) {
                productTitleFilePath = "includes/product-title.jsp";
            }
        %>
        <jsp:include page="<%= productTitleFilePath %>"/>
    </layout:component>
    <layout:component componentName="MainSection">
        <%--        <%id_vneid = null;%>--%>
        <div class="ui segment">
            <%if (cccd == null) { %>
            <h5>Không tìm thấy Căn cước công dân</h5>
            <%} else if (local_username == null) {%>
            <h5>Không tồn tại tài khoản với CCCD <%=cccd%>
            </h5>
            <%} else if (id_vneid == null) {%>
            <h4>Xác nhận thông tin lần đầu đăng nhập bằng VNEID</h4>
            <div class="ui divider hidden"></div>
            <div class="error-msg"></div>
            <div class="ui divider hidden"></div>
            <div class="segment-form">
                <form class="ui large form" action="/commonauth" method="POST">
                    <input id="sessionDataKey" value="<%=request.getParameter("sessionDataKey")%>" name="sessionDataKey" hidden>
                    <input type="hidden" name="is_vneid" value="true"/>
                    <label>
                        Căn cước công dân
                        <input type="text" value="<%=cccd%>" disabled readonly>
                    </label>
                    <label hidden>
                        ID VNeID
                        <input name="http://wso2.org/claims/id_vneid" type="text" value="<%=StringUtils.trimToEmpty(vneid_claims.get(local_vneid.get("http://wso2.org/claims/id_vneid")))%>" readonly>
                    </label>
                    <label>
                        Họ và tên
                        <input name="http://wso2.org/claims/fullname" type="text"
                               value="<%=getValue(vneid_claims.get(local_vneid.get("http://wso2.org/claims/fullname")),getClaimValue(vneidAuthenticationContext.getTenantDomain(),local_username,"http://wso2.org/claims/fullname"))%>"
                               required>
                    </label>
                    <label>
                        Số điện thoại
                        <input name="http://wso2.org/claims/mobile" type="text"
                               value="<%=getValue(vneid_claims.get(local_vneid.get("http://wso2.org/claims/mobile")),getClaimValue(vneidAuthenticationContext.getTenantDomain(),local_username,"http://wso2.org/claims/mobile"))%>"
                               pattern="^\d{10,11}$" required>
                    </label>
                    <label>
                        Email
                        <input name="http://wso2.org/claims/emailaddress" type="email"
                               value="<%=getValue(vneid_claims.get(local_vneid.get("http://wso2.org/claims/emailaddress")),getClaimValue(vneidAuthenticationContext.getTenantDomain(),local_username,"http://wso2.org/claims/emailaddress"))%>"
                               required>
                    </label>
                    <div class="align-center buttons">
                        <input type="submit" style="width: 100%" name="authenticate" id="usb_login_button" value="Xác nhận" class="ui primary button"/>
                    </div>
                </form>
            </div>
            <%} else {%>
            <h5>Đang đăng nhập bằng VNEID ...</h5>
            <form class="ui large form" action="/commonauth" method="POST" id="skip_form">
                <input id="sessionDataKey" value="<%=request.getParameter("sessionDataKey")%>" name="sessionDataKey" hidden>
                <input type="hidden" name="is_vneid" value="true"/>
            </form>
            <%} %>
            <div style="display: flex; justify-content: center" id="register-block">
                <div style="margin-top: 20px">
                    Bạn chưa có tài khoản?
                    <a class="register" href="<%=getCustomValueProperty(request,"register-url")%>">Đăng ký</a>
                </div>
            </div>
        </div>
    </layout:component>
    <layout:component componentName="ProductFooter">
        <%
            String productFooterFilePath = "extensions/product-footer.jsp";
            if (StringUtils.isNotBlank(customLayoutFileRelativeBasePath)) {
                productFooterFilePath = customLayoutFileRelativeBasePath + "/product-footer.jsp";
            }
            if (!new File(getServletContext().getRealPath(productFooterFilePath)).exists()) {
                productFooterFilePath = "includes/product-footer.jsp";
            }
        %>
        <jsp:include page="<%= productFooterFilePath %>"/>
    </layout:component>
</layout:main>
<%
    File footerFile = new File(getServletContext().getRealPath("extensions/footer.jsp"));
    if (footerFile.exists()) {
%>
<jsp:include page="extensions/footer.jsp"/>
<% } else { %>
<jsp:include page="includes/footer.jsp"/>
<% } %>
</body>
</html>


<script>
    document.getElementById("skip_form").submit();
</script>
