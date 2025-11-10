<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>
<%@ page import="org.wso2.carbon.identity.captcha.util.CaptchaUtil" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.context.AuthenticationContext" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.config.model.AuthenticatorConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="layout" uri="org.wso2.identity.apps.taglibs.layout.controller" %>

<%-- Localization --%>
<%@ include file="includes/localize.jsp" %>

<%-- Include tenant context --%>
<%@ include file="includes/init-url.jsp" %>

<%-- Branding Preferences --%>
<jsp:directive.include file="includes/branding-preferences.jsp"/>



<%!
    private String encodeEmail(String email) {
        if (email == null || email.isEmpty()) return "****";
        int atIndex = email.indexOf('@');
        if (atIndex == -1) return "****";
        String localPart = email.substring(0, atIndex);
        String domainPart = email.substring(atIndex);
        if (localPart.length() <= 4) return "****" + domainPart;
        else return localPart.substring(0, localPart.length() - 4) + "****" + domainPart;
    }
%>




<%
    FrameworkUtils.getContextData(request).setProperty("MY_CUSTOM_AUTHENTICATOR", "CUSTOM_EMAIL_AUTHENTICATOR");
    request.getSession().invalidate();
    String queryString = request.getQueryString();
    Map<String, String> idpAuthenticatorMapping = null;
    if (request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP) != null) {
        idpAuthenticatorMapping = (Map<String, String>) request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP);
    }

    String errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.retry");
    String authenticationFailed = "false";

    if (Boolean.parseBoolean(request.getParameter(Constants.AUTH_FAILURE))) {
        authenticationFailed = "true";

        if (request.getParameter(Constants.AUTH_FAILURE_MSG) != null) {
            errorMessage = request.getParameter(Constants.AUTH_FAILURE_MSG);

            if (errorMessage.equalsIgnoreCase("authentication.fail.message")) {
                errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.retry.code.invalid");
            }
            if (errorMessage.equalsIgnoreCase("token.expired")) {
                errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.code.expired.resend");
            }
            if (errorMessage.equalsIgnoreCase("token.expired.email.sent")) {
                errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.token.expired.email.sent");
            }
        }
    }
%>

<%-- Data for the layout from the page --%>
<%
    layoutData.put("containerSize", "medium");
%>

<%
    boolean reCaptchaEnabled = false;
    if (request.getParameter("reCaptcha") != null && Boolean.parseBoolean(request.getParameter("reCaptcha"))) {
        reCaptchaEnabled = true;
    }
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

    <%
        if (reCaptchaEnabled) {
    %>
    <script src="https://recaptcha.net/recaptcha/api.js" async defer></script>
    <%
        }
    %>
</head>

<body class="login-portal layout email-otp-portal-layout">

<% if (new File(getServletContext().getRealPath("extensions/timeout.jsp")).exists()) { %>
<jsp:include page="extensions/timeout.jsp"/>
<% } else { %>
<jsp:include page="util/timeout.jsp"/>
<% } %>

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
            <p style="font-size: 200%">Xác thực EMAIL OTP</p>
                    <p style="font-size: 110%" id="CUSTOM_EMAIL_AUTHENTICATOR_RESPONSE">Mã xác nhận đã được gửi qua Email của bạn
                        <b style="margin-top: 10px"><%=encodeEmail((String) FrameworkUtils.getContextData(request).getProperty("CUSTOM_EMAIL_AUTHENTICATOR_RESPONSE"))%></b>
                    </p>
            <div class="ui negative message" id="failed-msg">Mã OTP không đúng hoặc quá thời hạn</div>
            <div class="ui divider hidden"></div>
            <div id="alertDiv"></div>
            <div class="segment-form">
                <form class="ui large form" id="custom_email_otp_form" action="<%=commonauthURL%>" method="POST">
                    <input type="text" name="custom_email_otp" id="custom_email_otp" hidden>
                    <input type='hidden' name='custom_resend_email_otp' value='false' id="custom_resend_email_otp"/>
                    <input value="<%=request.getParameter("sessionDataKey")%>" name="sessionDataKey" hidden>
                    <div style="display: flex; justify-content: space-around ;margin-top: 15px">
                        <%
                            {
                                for (int i = 0; i < 6; i++) {
                        %><input type="number" style="width: 44px" maxlength="1" id="otp_<%=i%>"><%
                            }
                        }%>
                    </div>
                    <div style="display: flex; flex-direction: column; margin-top: 15px; justify-items: center">
                        <input type="button" name="authenticate" id="authenticate"
                               value="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "authenticate")%>"
                               class="ui primary button" onclick="submitForm()" style="width: 100%"/>
                        <p id="resendOtp" style="margin: auto; padding: 15px; display: none">Bạn chưa nhận được mã?<a style="cursor: pointer" onclick="resendCode()"> Gửi lại OTP</a></p>
                    </div>
                    <div id="timer" style="margin: 15px 0; display: flex; justify-content: center"></div>
                </form>

                <div style="display: flex; justify-content: center"  id="register-block">
                    <div style="margin-top: 20px">
                        Bạn chưa có tài khoản?
                        <a class="register" href="<%=getCustomValueProperty(request,"register-url")%>">Đăng ký</a>
                    </div>
                </div>

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
<%
    File footerFile = new File(getServletContext().getRealPath("extensions/footer.jsp"));
    if (footerFile.exists()) {
%>
<jsp:include page="extensions/footer.jsp"/>
<% } else { %>
<jsp:include page="includes/footer.jsp"/>
<% } %>

<script>
    const lengthOfOTP = 6;
    document.getElementById('otp_0').focus();
    for (let i = 0; i < lengthOfOTP; i++) {
        document.getElementById('otp_' + i).addEventListener("keyup", function (event) {
            if (event.keyCode === 8 || event.keyCode === 46) {
                if (this.value.length === 0) focusBack(i);
            }
            else if (event.key==="ArrowLeft" || event.key==="ArrowDown") {
                focusBack(i);
            }
            else if (event.key==="ArrowRight" || event.key==="ArrowUp") {
                focusNext(i);
            }
            else if (this.value.length >= 1) {
                focusNext(i);
            }
        });
        document.getElementById('otp_' + i).addEventListener("input", function (event) {
            const tokenInput = document.querySelector('input[name="OTPCode"]');
            tokenInput.value = getOtp();
        });
    }

    function focusBack(index) {
        if (index > 0) {
            document.getElementById('otp_' + (index - 1)).focus();
            document.getElementById('otp_' + (index - 1)).select();
        }
    }

    function focusNext(index) {
        if (index < lengthOfOTP - 1) {
            document.getElementById('otp_' + (index + 1)).focus();
            document.getElementById('otp_' + (index + 1)).click();
        }
    }

    function getOtp() {
        let otp = "";
        for (let i = 0; i < lengthOfOTP; i++) otp += document.getElementById('otp_' + i).value;
        return otp;
    }

    function validateForm(){
        for (let i = 0; i < lengthOfOTP; i++) {
            if (document.getElementById('otp_' + i).value === "") {
                document.getElementById('otp_' + i).focus();
                document.getElementById('otp_' + i).select();
                return false;
            }
        }
        return true;
    }

    function resendCode() {
        $("#custom_resend_email_otp").val("true");
        document.getElementById("custom_email_otp_form").submit();
    }

    function submitForm() {
        $("#custom_email_otp").val(getOtp());
        document.getElementById("custom_email_otp_form").submit();
    }

    function showMessage(message){
        document.getElementById("failed-msg").style.display="block";
        document.getElementById("failed-msg").innerText=message;
    }


    document.getElementById("failed-msg").style.display="none";
    const MAIL = '<%=FrameworkUtils.getContextData(request).getProperty("CUSTOM_EMAIL_AUTHENTICATOR_RESPONSE")%>';
    const CODE = '<%=FrameworkUtils.getContextData(request).getProperty("CUS_CODE")%>';
    if("INVALID_OTP".includes(CODE)){
        showMessage("Mã OTP không đúng hoặc quá thời hạn!");
    }
    else if(MAIL==="null" || MAIL.trim()===""){
        showMessage("Bạn cần thêm phương thức bằng Email!");
        document.getElementById("CUSTOM_EMAIL_AUTHENTICATOR_RESPONSE").style.display="none";
        document.getElementById("custom_email_otp_form").style.display="none";

    }
    else if("SEND_OTP_FAILED".includes(CODE)){
        showMessage("Thông báo: Lỗi khi gửi OTP!")
    }

    const creationTime = new Date("<%=FrameworkUtils.getContextData(request).getProperty("CREATION_TIME")%>");
    const durationExpiration = <%=FrameworkUtils.getContextData(request).getProperty("DURATION_TIME")%> ? <%=FrameworkUtils.getContextData(request).getProperty("DURATION_TIME")%> : 0;
    const interval = setInterval(function(){
        const currentTime = new Date();
        const timeDiff = Math.abs(currentTime.getTime() - creationTime.getTime());
        if(timeDiff >= durationExpiration) {
            clearInterval(interval);
            document.getElementById("timer").style.display = "none";
            document.getElementById("resendOtp").style.display = "block";
        }
        else{
            const timeDiffSeconds = (durationExpiration - timeDiff)/1000;
            const minutes = Math.floor(timeDiffSeconds / 60);
            const seconds = Math.floor(timeDiffSeconds % 60);
            const formattedMinutes = minutes.toString().padStart(2, '0');
            const formattedSeconds = seconds.toString().padStart(2, '0');
            const formattedTime = formattedMinutes + ":" + formattedSeconds;
            document.getElementById("timer").innerHTML = "Thời gian hiệu lực của mã<b style='margin: 0 5px'>"+ formattedTime +"</b>";
        }
    },1000);

</script>

</body>
</html>
