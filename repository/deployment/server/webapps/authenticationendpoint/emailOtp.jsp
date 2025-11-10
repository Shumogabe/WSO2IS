<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>
<%@ page import="org.wso2.carbon.identity.captcha.util.CaptchaUtil" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.context.AuthenticationContext" %>
<%@ page import="org.wso2.carbon.identity.application.common.model.AuthenticationStep" %>
<%@ page import="org.wso2.carbon.identity.application.common.model.IdentityProvider" %>
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

    private String getResetUrl(HttpServletRequest request){
        String reSendOTP = "/commonauth?idp=%s&authenticator=%s&sessionDataKey=%s&multiOptionURI=%s";
        AuthenticationContext authenticationContext = FrameworkUtils.getContextData(request);
        String authenticator = "EmailOTP";
        String idp = "EmailOTP";
        List<AuthenticatorConfig> authenticatorList = authenticationContext.getSequenceConfig().getStepMap().get(authenticationContext.getCurrentStep()).getAuthenticatorList();
        for (AuthenticatorConfig authenticatorConfig : authenticatorList) {
            if (authenticatorConfig.getName().equals(authenticator)){
                idp = authenticatorConfig.getIdpNames().get(0);
            }
        }
        String sessionDataKey=Encode.forUriComponent(request.getParameter("sessionDataKey"));
        try {
            String baseURL = ServiceURLBuilder.create().addPath(request.getRequestURI()).build().getRelativePublicURL();
            String queryParamString = AuthenticationEndpointUtil.resolveQueryString(request.getParameterMap());
            String multiOptionURIParam = "&multiOptionURI=" + Encode.forUriComponent(baseURL + queryParamString);
            return String.format(reSendOTP,idp,authenticator,sessionDataKey,multiOptionURIParam);
        } catch (Exception e) {
            return null;
        }
    }

    private String getEmail(HttpServletRequest request) {
        try {
            return (String) FrameworkUtils.getContextData(request).getProperty("emilFromProfile");
        }
        catch (Exception e) {
            return "";
        }
    }

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
    <script type="text/javascript">
        function submitForm() {
            var code = document.getElementById("OTPCode").value;
            if (code == "") {
                document.getElementById('alertDiv').innerHTML
                    = '<div id="error-msg" class="ui negative message"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "error.enter.code")%></div>'
                    +'<div class="ui divider hidden"></div>';
            } else {
                if ($('#codeForm').data("submitted") === true) {
                    console.warn("Prevented a possible double submit event");
                } else {
                    $('#codeForm').data("submitted", true);
                    $('#codeForm').submit();
                }
            }
        }
    </script>
</head>

<body class="login-portal layout email-otp-portal-layout">

    <% if (new File(getServletContext().getRealPath("extensions/timeout.jsp")).exists()) { %>
        <jsp:include page="extensions/timeout.jsp"/>
    <% } else { %>
        <jsp:include page="util/timeout.jsp"/>
    <% } %>

    <layout:main layoutName="<%= layout %>" layoutFileRelativePath="<%= layoutFileRelativePath %>" data="<%= layoutData %>" >
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
            <jsp:include page="<%= productTitleFilePath %>" />
        </layout:component>
        <layout:component componentName="MainSection" >
            <div class="ui segment">
                <%-- page content --%>
                <h2><%=AuthenticationEndpointUtil.i18n(resourceBundle, "otp.verification")%>
                </h2>
                <div class="ui divider hidden"></div>
                <%
                    if ("true".equals(authenticationFailed)) {
                %>
                <div class="ui negative message" id="failed-msg"><%=Encode.forHtmlContent(errorMessage)%>
                </div>
                <div class="ui divider hidden"></div>
                <% } %>
                <div id="alertDiv"></div>
                <div class="segment-form">
                    <form class="ui large form" id="codeForm" name="codeForm" action="<%=commonauthURL%>" method="POST">
                        <%
                            String loginFailed = request.getParameter("authFailure");
                            if (loginFailed != null && "true".equals(loginFailed)) {
                                String authFailureMsg = request.getParameter("authFailureMsg");
                                if (authFailureMsg != null && "login.fail.message".equals(authFailureMsg)) {
                        %>
                        <div class="ui negative message"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "error.retry")%>
                        </div>
                        <div class="ui divider hidden"></div>
                        <% }
                        } %>
                        <% if (request.getParameter("screenValue") != null) { %>
                        <div class="field">
                            <label for="OTPCode"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "enter.code")%>
                                (<%=Encode.forHtmlContent(request.getParameter("screenValue"))%>): <%=encodeEmail(getEmail(request))%>
                            </label>
                            <div class="ui fluid icon input addon-wrapper">
                                <input type="password" id='OTPCode' name="OTPCode" c size='30'/>
                                <i id="password-eye" class="eye icon right-align password-toggle link" onclick="showOTPCode()"></i>
                            </div>
                                <% } else { %>
                            <div class="field">
                                <label for="OTPCode"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "enter.code")%>: <%=encodeEmail(getEmail(request))%></label>
                                <div class="ui fluid icon input addon-wrapper">
                                    <input type="password" id='OTPCode' name="OTPCode" size='30'/>
                                    <i id="password-eye" class="eye icon right-align password-toggle link" onclick="showOTPCode()"></i>
                                </div>
                                <% } %>
                            </div>



                            <div style="display: flex; justify-content: space-around ;margin-top: 15px">
                                <%
                                    {
                                    AuthenticationContext authenticationContext = FrameworkUtils.getContextData(request);
                                        for (int i = 0; i < authenticationContext.getProperty("otpToken").toString().length(); i++) {
                                %><input type="text" style="width: 43px" maxlength="1" id="email_otp_<%=i%>"><%
                                    }
                                }%>
                            </div>



                            <input type="hidden" name="sessionDataKey"
                                value='<%=Encode.forHtmlAttribute(request.getParameter("sessionDataKey"))%>'/>
                            <input type='hidden' name='resendCode' id='resendCode' value='false'/>

                            <div class="ui divider hidden"></div>
                            <div class="align-right buttons" style="display: flex; justify-content: end">
                                <%
                                    if ("true".equals(authenticationFailed)) {
                                        String authFailureMsg = request.getParameter("authFailureMsg");
                                        if (!"token.expired.email.sent".equals(authFailureMsg)) {
                                %>
                                <a
                                    class="ui button secondary"
                                    onclick="resendOtp()"
                                    tabindex="0"
                                    onkeypress="javascript: if (window.event.keyCode === 13) resendOtp()"
                                id="resend"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "resend.code")%>
                                </a>
                                <% } }%>
                                <input type="button" name="authenticate" id="authenticate"
                                    value="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "authenticate")%>"
                                    class="ui primary button"/>
                            </div>
                        <%
                            if (reCaptchaEnabled) {
                                String reCaptchaKey = CaptchaUtil.reCaptchaSiteKey();
                        %>
                            <div class="field">
                                <div class="g-recaptcha"
                                    data-sitekey="<%=Encode.forHtmlAttribute(reCaptchaKey)%>"
                                    data-testid="login-page-g-recaptcha"
                                    data-bind="authenticate"
                                    data-callback="submitForm"
                                    data-theme="light"
                                    data-tabindex="-1"
                                >
                                </div>
                            </div>
                        <%
                            }
                        %>
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
            <jsp:include page="<%= productFooterFilePath %>" />
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

    <script type="text/javascript">
        $(document).ready(function () {
            $('#authenticate').click(function () {
                <% if (!reCaptchaEnabled) { %>
                    submitForm();
                <% } %>
            });
        });

        function resendOtp() {
            // document.getElementById("resendCode").value = "true";
            // $("#codeForm").submit();
            window.location.href="<%=getResetUrl(request)%>";
        }

        // Show OTP code function.
        function showOTPCode() {
            var otpField = $('#OTPCode');

            if (otpField.attr("type") === 'text') {
                otpField.attr("type", "password");
                document.getElementById("password-eye").classList.remove("slash");
            } else {
                otpField.attr("type", "text");
                document.getElementById("password-eye").classList.add("slash");
            }
        }

    </script>










    <script>
        const lengthOfOTP = <%=FrameworkUtils.getContextData(request).getProperty("otpToken").toString().length()%>;
        document.getElementById('email_otp_0').focus();
        for (let i = 0; i < lengthOfOTP; i++) {
            document.getElementById('email_otp_' + i).addEventListener("keyup", function (event) {
                if (event.keyCode === 8 || event.keyCode === 46) {
                    if (this.value.length === 0) focusBack(i);
                } else if (this.value.length >= 1) {
                    focusNext(i);
                }
            });
            document.getElementById('email_otp_' + i).addEventListener("input", function (event) {
                const tokenInput = document.querySelector('input[name="OTPCode"]');
                tokenInput.value = getTotp();
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
        document.querySelector('input[name="OTPCode"]').parentElement.style.display = 'none';
    </script>



</body>
</html>
