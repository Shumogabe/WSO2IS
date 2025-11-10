<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.authenticator.smsotp.SMSOTPUtils"%>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.util.IdentityManagementEndpointUtil" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>
<%@ page import="org.wso2.carbon.identity.authenticator.smsotp.SMSOTPConstants" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.context.AuthenticationContext" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="layout" uri="org.wso2.identity.apps.taglibs.layout.controller" %>

<%-- Localization --%>
<%@ include file="includes/localize.jsp" %>

<%-- Include tenant context --%>
<jsp:directive.include file="includes/init-url.jsp"/>

<%-- Branding Preferences --%>
<jsp:directive.include file="includes/branding-preferences.jsp"/>


<%-- Data for the layout from the page --%>
<%
    layoutData.put("containerSize", "medium");
%>


<html lang="en-US">
<head>
    <%-- header --%>
    <%
        File headerFile = new File(getServletContext().getRealPath("extensions/header.jsp"));
        if (headerFile.exists()) {
    %>
    <jsp:include page="extensions/header.jsp"/>
    <% } else { %>
    <jsp:include page="includes/header.jsp"/>
    <% } %>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="login-portal layout sms-otp-portal-layout">
<layout:main layoutName="<%= layout %>" layoutFileRelativePath="<%= layoutFileRelativePath %>" data="<%= layoutData %>">
    <layout:component componentName="ProductHeader">
        <%-- product-title --%>
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
        <div class="ui segment">
            <h4>Sim ký số</h4>
            <div class="error-msg" style="margin: 10px 0"></div>
            <div class="segment-form">
                <form class="ui large form" id="defaultOtpForm" name="pin_form" action="../commonauth" method="POST">
                    <input type="number" placeholder="Nhập số điện thoại" class="form-control" name="phone" maxlength="10" autofocus>
                    <input type="hidden" name="sessionDataKey" value='<%=Encode.forHtmlAttribute(request.getParameter("sessionDataKey"))%>'/>
                    <div class="align-center buttons">
                        <input style="width: 100%" type="submit" name="authenticate" id="authenticate" value="<%=IdentityManagementEndpointUtil.i18n(resourceBundle, "authenticate.button")%>" class="ui primary button"/>
                    </div>
                </form>
            </div>
            <div style="display: flex; justify-content: center"  id="register-block">
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

<%-- footer --%>
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
    let PKI_ERROR_CODE = "<%=FrameworkUtils.getContextData(request).getProperty("CUS_CODE")%>";

    function showHpgPkiMessage(message) {
        document.querySelector('.error-msg').innerHTML=message;
    }

    function showErrorPKI(CODE) {
        if (CODE.startsWith("PKI_FAILURE_ERROR_CODE")) {
            showHpgPkiMessage("Lỗi trong quá trình xác thực sim ký số! Vui lòng thử lại sau!");
            return;
        }
        if (CODE.startsWith("PKI_NETWORK_ERROR_CODE")) {
            showHpgPkiMessage("Lỗi mạng! Vui lòng thử lại sau!");
            return;
        }
        if (CODE.startsWith("PKI_USER_NOT_EXIST_ERROR_CODE")) {
            showHpgPkiMessage("Người dùng không tồn tại trong hệ thống!");
            return;
        }
        if (CODE.startsWith("PKI_USER_NOT_ACTIVE_ERROR_CODE")) {
            showHpgPkiMessage("Tài khoản người dùng bị khóa!");
            return;
        }
        if (CODE.startsWith("PKI_NOT_FOUND_USER_WITH_PHONE_ERROR_CODE")) {
            showHpgPkiMessage("Số điện thoại chưa được đăng ký sim ký số!");
            return;
        }
        if (CODE.startsWith("PKI_NOT_HAVE_RESPONSE_CODE_ERROR_CODE")) {
            showHpgPkiMessage("Lỗi mạng!");
            return;
        }
        if (CODE.startsWith("PKI_EXPIRED_CERT_ERROR_CODE")) {
            showHpgPkiMessage("Chứng chỉ hết hạn!");
            return;
        }
    }

    showErrorPKI(PKI_ERROR_CODE);

</script>
