<%--<%@ page import="org.owasp.encoder.Encode" %>--%>
<%--<%@ page import="org.wso2.carbon.identity.mgt.endpoint.util.IdentityManagementEndpointUtil" %>--%>
<%--<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>--%>
<%--<%@ page import="org.wso2.carbon.identity.authenticator.smsotp.SMSOTPConstants" %>--%>
<%--<%@ page import="java.io.File" %>--%>
<%--<%@ page import="java.util.Map" %>--%>
<%--<%@ page import="org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils" %>--%>
<%--<%@ page import="org.wso2.carbon.identity.application.authentication.framework.context.AuthenticationContext" %>--%>
<%--<%@ page import="org.wso2.carbon.identity.authenticator.emailotp.config.EmailOTPUtils" %>--%>
<%--<%@ page import="org.wso2.carbon.identity.authenticator.emailotp.internal.EmailOTPServiceDataHolder" %>--%>
<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%--<%@ taglib prefix="layout" uri="org.wso2.identity.apps.taglibs.layout.controller" %>--%>

<%--&lt;%&ndash; Localization &ndash;%&gt;--%>
<%--<%@ include file="includes/localize.jsp" %>--%>

<%--&lt;%&ndash; Include tenant context &ndash;%&gt;--%>
<%--<jsp:directive.include file="includes/init-url.jsp"/>--%>

<%--&lt;%&ndash; Branding Preferences &ndash;%&gt;--%>
<%--<jsp:directive.include file="includes/branding-preferences.jsp"/>--%>

<%--<%--%>
<%--    EmailOTPServiceDataHolder.getInstance().get--%>

<%--    request.getSession().invalidate();--%>
<%--    String queryString = request.getQueryString();--%>
<%--    Map<String, String> idpAuthenticatorMapping = null;--%>
<%--    if (request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP) != null) {--%>
<%--        idpAuthenticatorMapping = (Map<String, String>) request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP);--%>
<%--    }--%>

<%--    String errorMessage = IdentityManagementEndpointUtil.i18n(resourceBundle, "error.retry");--%>
<%--    String authenticationFailed = "false";--%>

<%--    if (Boolean.parseBoolean(request.getParameter(Constants.AUTH_FAILURE))) {--%>
<%--        authenticationFailed = "true";--%>

<%--        if (request.getParameter(Constants.AUTH_FAILURE_MSG) != null) {--%>
<%--            errorMessage = request.getParameter(Constants.AUTH_FAILURE_MSG);--%>

<%--            if (errorMessage.equalsIgnoreCase("authentication.fail.message")) {--%>
<%--                errorMessage = IdentityManagementEndpointUtil.i18n(resourceBundle, "error.retry");--%>
<%--            }--%>
<%--            if (errorMessage.equalsIgnoreCase(SMSOTPConstants.TOKEN_EXPIRED_VALUE)) {--%>
<%--                errorMessage = IdentityManagementEndpointUtil.i18n(resourceBundle, "error.code.expired.resend");--%>
<%--            }--%>
<%--        }--%>
<%--    }--%>
<%--%>--%>

<%--&lt;%&ndash; Data for the layout from the page &ndash;%&gt;--%>
<%--<%--%>
<%--    layoutData.put("containerSize", "medium");--%>
<%--%>--%>

<%--<html lang="en-US">--%>
<%--<head>--%>
<%--    &lt;%&ndash; header &ndash;%&gt;--%>
<%--    <%--%>
<%--        File headerFile = new File(getServletContext().getRealPath("extensions/header.jsp"));--%>
<%--        if (headerFile.exists()) {--%>
<%--    %>--%>
<%--    <jsp:include page="extensions/header.jsp"/>--%>
<%--    <% } else { %>--%>
<%--    <jsp:include page="includes/header.jsp"/>--%>
<%--    <% } %>--%>
<%--    <!--[if lt IE 9]>--%>
<%--    <script src="js/html5shiv.min.js"></script>--%>
<%--    <script src="js/respond.min.js"></script>--%>
<%--    <![endif]-->--%>
<%--</head>--%>

<%--<body class="login-portal layout sms-otp-portal-layout">--%>
<%--<layout:main layoutName="<%= layout %>" layoutFileRelativePath="<%= layoutFileRelativePath %>" data="<%= layoutData %>">--%>
<%--    <layout:component componentName="ProductHeader">--%>
<%--        &lt;%&ndash; product-title &ndash;%&gt;--%>
<%--        <%--%>
<%--            String productTitleFilePath = "extensions/product-title.jsp";--%>
<%--            if (StringUtils.isNotBlank(customLayoutFileRelativeBasePath)) {--%>
<%--                productTitleFilePath = customLayoutFileRelativeBasePath + "/product-title.jsp";--%>
<%--            }--%>
<%--            if (!new File(getServletContext().getRealPath(productTitleFilePath)).exists()) {--%>
<%--                productTitleFilePath = "includes/product-title.jsp";--%>
<%--            }--%>
<%--        %>--%>
<%--        <jsp:include page="<%= productTitleFilePath %>"/>--%>
<%--    </layout:component>--%>
<%--    <layout:component componentName="MainSection">--%>
<%--        <div class="ui segment">--%>
<%--                &lt;%&ndash; page content &ndash;%&gt;--%>
<%--            <h2><%=IdentityManagementEndpointUtil.i18n(resourceBundle, "auth.with.smsotp")%>--%>
<%--            </h2>--%>
<%--            <div class="ui divider hidden"></div>--%>
<%--            <%--%>
<%--                if ("true".equals(authenticationFailed)) {--%>
<%--            %>--%>
<%--            <div class="ui negative message" id="failed-msg">--%>
<%--                <%=Encode.forHtmlContent(errorMessage)%>--%>
<%--            </div>--%>
<%--            <div class="ui divider hidden"></div>--%>
<%--            <% } %>--%>
<%--            <div class="error-msg"></div>--%>
<%--            <div class="segment-form">--%>
<%--                <form class="ui large form" id="pin_form" name="pin_form" action="../commonauth" method="POST">--%>
<%--                    <%--%>
<%--                        String loginFailed = request.getParameter("authFailure");--%>
<%--                        if (loginFailed != null && "true".equals(loginFailed)) {--%>
<%--                            String authFailureMsg = request.getParameter("authFailureMsg");--%>
<%--                            if (authFailureMsg != null && "login.fail.message".equals(authFailureMsg)) {--%>
<%--                    %>--%>
<%--                    <div class="ui visible negative message">--%>
<%--                        <%=IdentityManagementEndpointUtil.i18n(resourceBundle, "error.retry")%>--%>
<%--                    </div>--%>
<%--                    <div class="ui divider hidden"></div>--%>
<%--                    <% }--%>
<%--                    } %>--%>
<%--                        &lt;%&ndash; Token Pin &ndash;%&gt;--%>
<%--                    <% if (request.getParameter("screenvalue") != null) { %>--%>
<%--                    <div class="field">--%>
<%--                        <label for="OTPcode">--%>
<%--                            <%=IdentityManagementEndpointUtil.i18n(resourceBundle, "enter.code.sent.smsotp")%><%=Encode.forHtmlContent(request.getParameter("screenvalue"))%>--%>
<%--                        </label>--%>
<%--                        <input type="password" id='OTPcode' name="OTPcode"--%>
<%--                               size='30'/>--%>
<%--                                <% } else { %>--%>
<%--                        <div class="field">--%>
<%--                            <label for="OTPcode"><%=IdentityManagementEndpointUtil.i18n(resourceBundle, "enter.code.sent.smsotp")%>--%>
<%--                            </label>--%>
<%--                            <input type="password" id='OTPcode' name="OTPcode"--%>
<%--                                   size='30'/>--%>
<%--                            <% } %>--%>
<%--                        </div>--%>


<%--                        <div style="display: flex; justify-content: space-around ;margin-top: 15px">--%>
<%--                            <%--%>
<%--                                {--%>
<%--//                                    AuthenticationContext authenticationContext = FrameworkUtils.getContextData(request);--%>
<%--                                    for (int i = 0; i < 6; i++) {--%>
<%--                            %><input type="text" style="width: 43px" maxlength="1" id="email_otp_<%=i%>"><%--%>
<%--                                }--%>
<%--                            }%>--%>
<%--                        </div>--%>


<%--                        <input type="hidden" name="sessionDataKey"--%>
<%--                               value='<%=Encode.forHtmlAttribute(request.getParameter("sessionDataKey"))%>'/><br/>--%>
<%--                        <div class="align-right buttons">--%>
<%--                            <%--%>
<%--                                if ("true".equals(authenticationFailed)) {--%>
<%--                                    String reSendCode = request.getParameter("resendCode");--%>
<%--                                    if ("true".equals(reSendCode)) {--%>
<%--                            %>--%>
<%--                            <div--%>
<%--                                    id="resendCodeLinkDiv"--%>
<%--                                    class="ui button secondary"--%>
<%--                                    tabindex="0"--%>
<%--                                    onclick="resendOtp()"--%>
<%--                                    onkeypress="javascript: if (window.event.keyCode === 13) resendOtp()">--%>
<%--                                <a id="resend"><%=IdentityManagementEndpointUtil.i18n(resourceBundle, "resend.code")%>--%>
<%--                                </a>--%>
<%--                            </div>--%>
<%--                            <% }--%>
<%--                            } %>--%>
<%--                            <input--%>
<%--                                    type="submit" name="authenticate" id="authenticate"--%>
<%--                                    value="<%=IdentityManagementEndpointUtil.i18n(resourceBundle, "authenticate.button")%>" class="ui primary button"/>--%>
<%--                        </div>--%>
<%--                        <input type='hidden' name='resendCode' id='resendCode' value='false'/>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </layout:component>--%>
<%--    <layout:component componentName="ProductFooter">--%>
<%--        &lt;%&ndash; product-footer &ndash;%&gt;--%>
<%--        <%--%>
<%--            String productFooterFilePath = "extensions/product-footer.jsp";--%>
<%--            if (StringUtils.isNotBlank(customLayoutFileRelativeBasePath)) {--%>
<%--                productFooterFilePath = customLayoutFileRelativeBasePath + "/product-footer.jsp";--%>
<%--            }--%>
<%--            if (!new File(getServletContext().getRealPath(productFooterFilePath)).exists()) {--%>
<%--                productFooterFilePath = "includes/product-footer.jsp";--%>
<%--            }--%>
<%--        %>--%>
<%--        <jsp:include page="<%= productFooterFilePath %>"/>--%>
<%--    </layout:component>--%>
<%--</layout:main>--%>

<%--&lt;%&ndash; footer &ndash;%&gt;--%>
<%--<%--%>
<%--    File footerFile = new File(getServletContext().getRealPath("extensions/footer.jsp"));--%>
<%--    if (footerFile.exists()) {--%>
<%--%>--%>
<%--<jsp:include page="extensions/footer.jsp"/>--%>
<%--<% } else { %>--%>
<%--<jsp:include page="includes/footer.jsp"/>--%>
<%--<% } %>--%>

<%--<script type="text/javascript">--%>
<%--    $(document).ready(function () {--%>
<%--        $.fn.preventDoubleSubmission = function () {--%>
<%--            $('#pin_form').on('submit', function (e) {--%>
<%--                if ($('#pin_form').data('submitted') === true) {--%>
<%--                    // Previously submitted - don't submit again.--%>
<%--                    e.preventDefault();--%>
<%--                    console.warn("Prevented a possible double submit event");--%>
<%--                } else {--%>
<%--                    var OTPcode = document.getElementById("OTPcode").value;--%>
<%--                    if (OTPcode == "") {--%>
<%--                        e.preventDefault();--%>
<%--                        document.getElementById('alertDiv').innerHTML--%>
<%--                            = '<div id="error-msg" class="ui negative message"><%=IdentityManagementEndpointUtil.i18n(resourceBundle, "please.enter.code")%></div><div class="ui divider hidden"></div>';--%>
<%--                    } else {--%>
<%--                        $('#pin_form').data("submitted", true);--%>
<%--                    }--%>
<%--                }--%>
<%--            });--%>
<%--        };--%>
<%--        $('#pin_form').preventDoubleSubmission();--%>
<%--    });--%>

<%--    function resendOtp() {--%>
<%--        document.getElementById("resendCode").value = "true";--%>
<%--        document.getElementById("pin_form").submit();--%>
<%--    }--%>
<%--</script>--%>


<%--<script>--%>
<%--    const lengthOfOTP = 6--%>
<%--    for (let i = 0; i < lengthOfOTP; i++) {--%>
<%--        document.getElementById('email_otp_' + i).addEventListener("keyup", function (event) {--%>
<%--            if (event.keyCode === 8 || event.keyCode === 46) {--%>
<%--                if (this.value.length === 0) focusBack(i);--%>
<%--            } else if (this.value.length >= 1) {--%>
<%--                focusNext(i);--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>

<%--    function focusBack(index) {--%>
<%--        if (index > 0) {--%>
<%--            document.getElementById('email_otp_' + (index - 1)).focus();--%>
<%--            document.getElementById('email_otp_' + (index - 1)).select();--%>
<%--        }--%>
<%--    }--%>

<%--    function focusNext(index) {--%>
<%--        if (index < lengthOfOTP - 1) {--%>
<%--            document.getElementById('email_otp_' + (index + 1)).focus();--%>
<%--            document.getElementById('email_otp_' + (index + 1)).click();--%>
<%--        }--%>
<%--    }--%>

<%--    function getTotp() {--%>
<%--        let totp = "";--%>
<%--        for (let i = 0; i < lengthOfOTP; i++) totp += document.getElementById('email_otp_' + i).value;--%>
<%--        return totp;--%>
<%--    }--%>

<%--    document.querySelector('input[name="OTPcode"]').style.display = 'none';--%>
<%--    document.getElementById("totpForm").addEventListener("submit", function () {--%>
<%--        const tokenInput = document.querySelector('input[name="OTPcode"]');--%>
<%--        tokenInput.value = getTotp();--%>
<%--    });--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>



<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.authenticator.smsotp.SMSOTPUtils"%>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.util.IdentityManagementEndpointUtil" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>
<%@ page import="org.wso2.carbon.identity.authenticator.smsotp.SMSOTPConstants" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.context.AuthenticationContext" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.config.model.AuthenticatorConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="layout" uri="org.wso2.identity.apps.taglibs.layout.controller" %>

<%-- Localization --%>
<%@ include file="includes/localize.jsp" %>

<%-- Include tenant context --%>
<jsp:directive.include file="includes/init-url.jsp"/>

<%-- Branding Preferences --%>
<jsp:directive.include file="includes/branding-preferences.jsp"/>



<%!

    private String getResetUrl(HttpServletRequest request){
        String reSendOTP = "/commonauth?idp=%s&authenticator=%s&sessionDataKey=%s&multiOptionURI=%s";
        AuthenticationContext authenticationContext = FrameworkUtils.getContextData(request);
        String authenticator = "SMSOTP";
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
    private String encodeMobileNumber(String value) {
        if (value == null || value.isEmpty()) return "";
        StringBuilder mobileEncoded = new StringBuilder();
        for (int i = 0; i < value.length(); i++) {
            if(i<value.length()-3) mobileEncoded.append("*");
            else mobileEncoded.append(value.charAt(i));
        }
        return mobileEncoded.toString();
    }

    private String getMobileNumber(HttpServletRequest request) {
        try {
            AuthenticationContext authenticationContext = FrameworkUtils.getContextData(request);
            String username = authenticationContext.getParameter("username").toString();
            return SMSOTPUtils.getMobileNumberForUsername(username);
        }
        catch (Exception e) {
            return "";
        }
    }

    private String getOtpToken(HttpServletRequest request) {
        try {
            return FrameworkUtils.getContextData(request).getProperty("otpToken").toString();
        }
        catch (Exception e) {
            return "123456";
        }
    }
%>



<%
    String mobileNumber = getMobileNumber(request);
    request.getSession().invalidate();
    String queryString = request.getQueryString();
    Map<String, String> idpAuthenticatorMapping = null;
    if (request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP) != null) {
        idpAuthenticatorMapping = (Map<String, String>) request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP);
    }

    String errorMessage = IdentityManagementEndpointUtil.i18n(resourceBundle, "error.retry");
    String authenticationFailed = "false";

    if (Boolean.parseBoolean(request.getParameter(Constants.AUTH_FAILURE))) {
        authenticationFailed = "true";

        if (request.getParameter(Constants.AUTH_FAILURE_MSG) != null) {
            errorMessage = request.getParameter(Constants.AUTH_FAILURE_MSG);

            if (errorMessage.equalsIgnoreCase("authentication.fail.message")) {
                errorMessage = IdentityManagementEndpointUtil.i18n(resourceBundle, "error.retry");
            }
            if (errorMessage.equalsIgnoreCase(SMSOTPConstants.TOKEN_EXPIRED_VALUE)) {
                errorMessage = IdentityManagementEndpointUtil.i18n(resourceBundle, "error.code.expired.resend");
            }
        }
    }
%>

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
            <h2><%=IdentityManagementEndpointUtil.i18n(resourceBundle, "auth.with.smsotp")%>
            </h2>
                <%--                    <h2><%=getOtpToken(request)%>--%>
                <%--                    </h2>--%>
            <div class="ui divider hidden"></div>
            <%
                if ("true".equals(authenticationFailed)) {
            %>
            <div class="ui negative message" id="failed-msg">
                <%=Encode.forHtmlContent(errorMessage)%>
            </div>
            <div class="ui divider hidden"></div>
            <% } %>
            <div class="error-msg"></div>
            <div class="segment-form">
                <form class="ui large form" id="pin_form" name="pin_form" action="../commonauth" method="POST">
                    <%
                        String loginFailed = request.getParameter("authFailure");
                        if (loginFailed != null && "true".equals(loginFailed)) {
                            String authFailureMsg = request.getParameter("authFailureMsg");
                            if (authFailureMsg != null && "login.fail.message".equals(authFailureMsg)) {
                    %>
                    <div class="ui visible negative message">
                        <%=IdentityManagementEndpointUtil.i18n(resourceBundle, "error.retry")%>
                    </div>
                    <div class="ui divider hidden"></div>
                    <% }
                    } %>
                        <%-- Token Pin --%>
                    <% if (request.getParameter("screenvalue") != null) { %>
                    <div class="field">
                        <label for="OTPcode">
                            <%=IdentityManagementEndpointUtil.i18n(resourceBundle, "enter.code.sent.smsotp")%><%=Encode.forHtmlContent(request.getParameter("screenvalue"))%>
                        </label>
                        <input type="password" id='OTPcode' name="OTPcode"
                               size='30'/>
                                <% } else { %>
                        <div class="field">
                            <label for="OTPcode"><%=IdentityManagementEndpointUtil.i18n(resourceBundle, "enter.code.sent.smsotp")%><span>: <b><%=encodeMobileNumber(mobileNumber)%></b></span>
                            </label>
                            <input type="password" id='OTPcode' name="OTPcode"
                                   size='30'/>
                            <% } %>
                        </div>
                        <div style="display: flex; justify-content: space-around ;margin-top: 15px">
                            <%
                                {
                                    for (int i = 0; i < getOtpToken(request).length(); i++) {
                            %><input type="text" style="width: 43px" maxlength="1" id="email_otp_<%=i%>"><%
                                }
                            }%>
                        </div>


                        <input type="hidden" name="sessionDataKey"
                               value='<%=Encode.forHtmlAttribute(request.getParameter("sessionDataKey"))%>'/><br/>
                        <div class="align-right buttons" style="display: flex; justify-items: center; flex-direction: column-reverse">
                            <%
                                if ("true".equals(authenticationFailed)) {
                                    String reSendCode = request.getParameter("resendCode");
                                    if ("true".equals(reSendCode)) {
                            %>
                            <div
                                    style="margin: auto; padding-top: 15px;"
                                    id="resendCodeLinkDiv"
                                    tabindex="0"
                                    onclick="resendOtp()"
                                    onkeypress="javascript: if (window.event.keyCode === 13) resendOtp()">
                                Bạn chưa nhận được mã OTP? <a id="resend" style="cursor: pointer"><%=IdentityManagementEndpointUtil.i18n(resourceBundle, "resend.code")%>
                            </a>
                            </div>
                            <% }
                            } %>
                            <input
                                    style="width: 100%"
                                    type="submit" name="authenticate" id="authenticate"
                                    value="<%=IdentityManagementEndpointUtil.i18n(resourceBundle, "authenticate.button")%>" class="ui primary button"/>
                        </div>
                        <input type='hidden' name='resendCode' id='resendCode' value='false'/>
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

<script type="text/javascript">
    $(document).ready(function () {
        $.fn.preventDoubleSubmission = function () {
            $('#pin_form').on('submit', function (e) {
                if ($('#pin_form').data('submitted') === true) {
                    // Previously submitted - don't submit again.
                    e.preventDefault();
                    console.warn("Prevented a possible double submit event");
                } else {
                    var OTPcode = document.getElementById("OTPcode").value;
                    if (OTPcode == "") {
                        e.preventDefault();
                        document.getElementById('alertDiv').innerHTML
                            = '<div id="error-msg" class="ui negative message"><%=IdentityManagementEndpointUtil.i18n(resourceBundle, "please.enter.code")%></div><div class="ui divider hidden"></div>';
                    } else {
                        $('#pin_form').data("submitted", true);
                    }
                }
            });
        };
        $('#pin_form').preventDoubleSubmission();
    });

    function resendOtp() {
        // document.getElementById("resendCode").value = "true";
        // document.getElementById("pin_form").submit();
        window.location.href="<%=getResetUrl(request)%>";
    }
</script>


<script>
    const lengthOfOTP = <%=getOtpToken(request).length() %>;
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

    document.querySelector('input[name="OTPcode"]').style.display = 'none';
    document.getElementById("pin_form").addEventListener("submit", function () {
        const tokenInput = document.querySelector('input[name="OTPcode"]');
        tokenInput.value = getTotp();
    });
</script>
</body>
</html>
