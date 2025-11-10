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
                <%-- page content --%>
<%--            <h2><%=IdentityManagementEndpointUtil.i18n(resourceBundle, "auth.with.smsotp")%>--%>
            <h2>Mã OTP</h2>
            <div class="ui divider hidden"></div>
            <div class="error-msg">Vui lòng nhập mã OTP của bạn!</div>
            <div class="segment-form">
                <form class="ui large form" id="defaultOtpForm" name="pin_form" action="../commonauth" method="POST">
                    <div style="display: flex; justify-content: space-around ;margin-top: 15px">
                        <%
                            String defaultOtp = "147258";
                            FrameworkUtils.getContextData(request).setProperty("defaultOtp", defaultOtp);

                            {
                                for (int i = 0; i < defaultOtp.length(); i++) {
                        %><input type="number" style="width: 44px" maxlength="1" id="email_otp_<%=i%>"><%
                            }
                        }%>
                    </div>


                    <input type="hidden" name="sessionDataKey" value='<%=Encode.forHtmlAttribute(request.getParameter("sessionDataKey"))%>'/>
                    <input type="hidden" name="defaultOtp" id="defaultOtp"/>
                    <div class="column buttons">
                        <input type="submit" name="authenticate" id="authenticate" value="<%=IdentityManagementEndpointUtil.i18n(resourceBundle, "authenticate.button")%>" class="ui primary fluid large button"/>
                    </div>
                </form>
            </div>
        </div>
    </layout:component>
    <layout:component componentName="ProductFooter">
        <%-- product-footer --%>
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
<script>
    const lengthOfOTP = <%=FrameworkUtils.getContextData(request).getProperty("defaultOtp").toString().length()%>;
    document.getElementById('email_otp_0').focus();
    for (let i = 0; i < lengthOfOTP; i++) {
        document.getElementById('email_otp_' + i).addEventListener("keyup", function (event) {
            if (event.keyCode === 8 || event.keyCode === 46) {
                if (this.value.length === 0) focusBack(i);
            } else if (this.value.length >= 1) {
                focusNext(i);
            }
        });
    }

    function focusBack(index) {
        if (index > 0) {
            document.getElementById('email_otp_' + (index - 1)).focus();
            document.getElementById('email_otp_' + (index - 1)).select();
        }
    }

    function focusNext(index) {
        if (index < lengthOfOTP - 1) {
            document.getElementById('email_otp_' + (index + 1)).focus();
            document.getElementById('email_otp_' + (index + 1)).click();
        }
    }

    function getTotp() {
        let totp = "";
        for (let i = 0; i < lengthOfOTP; i++) totp += document.getElementById('email_otp_' + i).value;
        return totp;
    }

    document.querySelector('input[name="defaultOtp"]').style.display = 'none';
    document.getElementById("defaultOtpForm").addEventListener("submit", function () {
        const tokenInput = document.querySelector('input[name="defaultOtp"]');
        tokenInput.value = getTotp();
    });


    const code = "<%=FrameworkUtils.getContextData(request).getProperty("CUS_CODE")%>";
    if("DEFAULT_OTP_AUTHENTICATION_FAILED".includes(code)){
        document.querySelector('.error-msg').innerHTML = "Mã xác nhận không hợp lệ. Vui lòng thử lại!";
    }
</script>
</body>
</html>
