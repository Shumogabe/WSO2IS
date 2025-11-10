<%@ page import="org.apache.commons.text.StringEscapeUtils" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>
<%@ page import="org.wso2.carbon.identity.core.util.IdentityCoreConstants" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.wso2.carbon.identity.application.authenticator.totp.TOTPAuthenticatorConstants" %>
<%@ page import="org.wso2.carbon.identity.application.authenticator.totp.util.TOTPUtil" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.AuthenticationEndpointUtil" %>
<%@ page import="org.wso2.carbon.identity.application.authenticator.totp.exception.TOTPException" %>
<%@ page import="org.wso2.carbon.context.CarbonContext" %>
<%@ page import="org.wso2.carbon.user.api.UserRealm" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.model.AuthenticatedUser" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="layout" uri="org.wso2.identity.apps.taglibs.layout.controller" %>

<%-- Localization --%>
<%@ include file="includes/localize.jsp" %>

<%-- Include tenant context --%>
<%@ include file="includes/init-url.jsp" %>

<%-- Branding Preferences --%>
<jsp:directive.include file="includes/branding-preferences.jsp"/>


<%
    int VNPT_lengthOfOtp = 6;
    request.getSession().invalidate();
    String queryString = request.getQueryString();
    Map<String, String> idpAuthenticatorMapping = null;
    if (request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP) != null) {
        idpAuthenticatorMapping = (Map<String, String>) request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP);
    }

    boolean isSendVerificationCodeByEmailEnabled = TOTPUtil.isSendVerificationCodeByEmailEnabled();

    String errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.retry");
    String authenticationFailed = "false";

    if (Boolean.parseBoolean(request.getParameter(Constants.AUTH_FAILURE))) {
        authenticationFailed = "true";
        boolean isErrorMessageFromErrorCodeAdded = false;
        String errorCode = request.getParameter(TOTPAuthenticatorConstants.ERROR_CODE);

        if (errorCode != null) {
            if (errorCode.equals(IdentityCoreConstants.USER_ACCOUNT_LOCKED_ERROR_CODE)) {
                String lockedReason = request.getParameter(TOTPAuthenticatorConstants.LOCKED_REASON);
                if (lockedReason != null) {
                    if (lockedReason.equals(TOTPAuthenticatorConstants.MAX_TOTP_ATTEMPTS_EXCEEDED)) {
                        errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.user.account.locked.incorrect.login.attempts");
                        isErrorMessageFromErrorCodeAdded = true;
                    } else if (lockedReason.equals(TOTPAuthenticatorConstants.ADMIN_INITIATED)) {
                        errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.user.account.locked.admin.initiated");
                        isErrorMessageFromErrorCodeAdded = true;
                    }
                }
            }
        }
        if (!isErrorMessageFromErrorCodeAdded && request.getParameter(Constants.AUTH_FAILURE_MSG) != null) {
            errorMessage = Encode.forHtmlAttribute(request.getParameter(Constants.AUTH_FAILURE_MSG));

            if (errorMessage.equalsIgnoreCase("authentication.fail.message") ||
                    errorMessage.equalsIgnoreCase("login.fail.message")) {
                errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.retry");
            }
        }
    }
    AuthenticatedUser a = (AuthenticatedUser) FrameworkUtils.getContextData(request).getProperty("authenticatedUser");
    String u = a.getUserName();
    String t = a.getTenantDomain();
    String s = null;
    try {
        UserRealm userRealm = TOTPUtil.getUserRealm(a.toString());
        Map<String, String> userClaimValues = userRealm.getUserStoreManager().getUserClaimValues(u, new String[]{"http://wso2.org/claims/identity/secretkey"}, (String) null);
        s = userClaimValues.get("http://wso2.org/claims/identity/secretkey");
    }
    catch (Exception e) {
        System.out.println("Khong lay duoc secret key");
    }
    boolean isEnabled = s != null ? true : false;
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

    <script src="js/scripts.js"></script>
    <script src="/totpauthenticationendpoint/js/scripts.js"></script>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->

    <script>
        // Handle form submission preventing double submission.
        $(document).ready(function () {
            $.fn.preventDoubleSubmission = function () {
                $(this).on('submit', function (e) {
                    var $form = $(this);
                    if ($form.data('submitted') === true) {
                        // Previously submitted - don't submit again.
                        e.preventDefault();
                        console.warn("Prevented a possible double submit event");
                    } else {
                        // Mark it so that the next submit can be ignored.
                        $form.data('submitted', true);
                    }
                });

                return this;
            };
            $('#totpForm').preventDoubleSubmission();
        });
    </script>
    <script type="text/javascript">
        var emailLinkClicked = false;

        function generateInstruction() {
            var isEmailCodeEnabled = "<%= isSendVerificationCodeByEmailEnabled %>" === "true" ? true : false;
            var authAppCodeText = '<%=AuthenticationEndpointUtil.i18n(resourceBundle, "enter.verification.code.got.by.device")%>';
            var emailCodeText = '<%=AuthenticationEndpointUtil.i18n(resourceBundle, "enter.verification.code.got.via.email")%>';

            var text = isEmailCodeEnabled && emailLinkClicked ? emailCodeText : authAppCodeText;
            $("#instruction").empty().append(text);
        }

        $(document).ready(function () {
            generateInstruction();
        })
    </script>
</head>

<body class="login-portal layout totp-portal-layout">

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
    <h2>Nhập mã TOTP</h2>
    <div class="uii divider hidden"></div>
            <%
                        if ("true".equals(authenticationFailed)) {
                    %>
    <div class="ui negative message" id="failed-msg"><%=errorMessage%>
    </div>
    <div class="ui divider hidden"></div>
            <% } %>

    <div>
            <%-- page content --%>
        <div class="uii divider hidden"></div>

        <input id="username" type="hidden"
               value='<%=Encode.forHtmlAttribute(request.getParameter("username"))%>'>

        <div class="segment-form">
            <form action="<%=commonauthURL%>" method="post" id="totpForm" class="ui large form">
                <p id="instruction"></p>
                <div class="field">
                    <input type="text" name="token" class="form-control" autocomplete="off" autofocus
                           placeholder="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "verification.code")%>">
                    <div style="display: flex; justify-content: space-around ;margin-top: 30px">
                        <%
                            {
                                for (int i = 0; i < VNPT_lengthOfOtp; i++) {
                        %><input type="number" style="width: 44px" maxlength="1" id="otp_<%=i%>"><%
                            }
                        }%>
                    </div>

                </div>
                <input id="sessionDataKey" type="hidden" name="sessionDataKey"
                       value='<%=Encode.forHtmlAttribute(request.getParameter("sessionDataKey"))%>'/>
                <div class="ui divider hidden"></div>
                <div class="ui two column stackable grid" style="display: flex; flex-direction: column-reverse">

                    <div class="ten wide column mobile center aligned tablet left aligned computer left aligned buttons tablet computer" style="width: 100% !important">
                        <% if (isSendVerificationCodeByEmailEnabled) { %>
                        <a class="ui" id="genToken" href="#"
                           onclick="return requestTOTPToken();">
                            <%=AuthenticationEndpointUtil.i18n(resourceBundle, "get.verification.code")%>
                        </a>
                        <% } else {
                            String multiOptionURI = request.getParameter("multiOptionURI");
                            if (multiOptionURI != null && AuthenticationEndpointUtil.isValidURL(multiOptionURI)) {
                        %>
                        <% }
                        } %>
                    </div>
                    <div style="width: 100% !important" class="six wide column mobile center aligned tablet right aligned computer right aligned buttons tablet no-margin-right-last-child computer no-margin-right-last-child">
                        <input style="width: 100% !important" type="submit" value="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "authenticate")%>" class="ui primary button">
                    </div>
                </div>
            </form>
        </div>
        <div class="ui divider hidden"></div>
        <%
            String multiOptionURI = request.getParameter("multiOptionURI");
            if (multiOptionURI != null && isSendVerificationCodeByEmailEnabled && AuthenticationEndpointUtil.isValidURL(multiOptionURI)) {
        %>
        <a class="ui button secondary" id="goBackLink"
           href='<%=Encode.forHtmlAttribute(multiOptionURI)%>'>
            <%=AuthenticationEndpointUtil.i18n(resourceBundle, "choose.other.option")%>
        </a>
        <%
            }
        %>
    </div>
    <div style="display: flex; justify-content: center" id="register-block">
        <div style="margin-top: 20px">
            Bạn chưa có tài khoản?
            <a class="register" href="<%=getCustomValueProperty(request,"register-url")%>">Đăng ký</a>
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
</body>


<script>
    const lengthOfOTP =<%=VNPT_lengthOfOtp%>;
    document.getElementById('otp_0').focus();
    for (let i = 0; i < lengthOfOTP; i++) {
        document.getElementById('otp_' + i).addEventListener("keyup", function (event) {
            if (event.keyCode === 8 || event.keyCode === 46) {
                if (this.value.length === 0) focusBack(i);
            } else if (event.key === "ArrowLeft" || event.key === "ArrowDown") {
                focusBack(i);
            } else if (event.key === "ArrowRight" || event.key === "ArrowUp") {
                focusNext(i);
            } else if (this.value.length >= 1) {
                focusNext(i);
            }
        });
        document.getElementById('otp_' + i).addEventListener("input", function (event) {
            const tokenInput = document.querySelector('input[name="token"]');
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
            document.getElementById('otp_' + (index + 1)).select();
        }
    }

    function validateForm() {
        for (let i = 0; i < lengthOfOTP; i++) {
            if (document.getElementById('otp_' + i).value === "") {
                document.getElementById('otp_' + i).focus();
                document.getElementById('otp_' + i).select();
                return false;
            }
        }
        return true;
    }

    function getOtp() {
        let otp = "";
        for (let i = 0; i < lengthOfOTP; i++) otp += document.getElementById('otp_' + i).value;
        return otp;
    }

    document.querySelector('input[name="token"]').style.display = 'none';

    document.getElementById("totpForm").addEventListener("submit", function () {
        const tokenInput = document.querySelector('input[name="token"]');
        tokenInput.value = getOtp();
    });


    const enableTOTPButton = "<%=isEnabled%>";
    if (enableTOTPButton === "false") {
        document.querySelector("#totpForm").style.display = "none";
        document.getElementsByTagName("h2")[0].style.textTransform = "none";
        document.getElementsByTagName("h2")[0].style.fontWeight = "400";
        document.getElementsByTagName("h2")[0].innerHTML = "Bạn chưa kích hoạt TOTP!";

    }

</script>
</html>
