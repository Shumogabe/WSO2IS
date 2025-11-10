<%--
  ~ Copyright (c) 2014-2023, WSO2 LLC. (https://www.wso2.com).
  ~
  ~ WSO2 LLC. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~    http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.AuthContextAPIClient" %>
<%@ page import="org.apache.commons.collections.CollectionUtils" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.EndpointConfigManager" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.config.ConfigurationFacade" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.config.model.ExternalIdPConfig" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>
<%@ page import="org.wso2.carbon.identity.core.util.IdentityCoreConstants" %>
<%@ page import="org.wso2.carbon.identity.core.util.IdentityUtil" %>
<%@ page import="org.wso2.carbon.base.ServerConfiguration" %>
<%@ page import="org.wso2.carbon.identity.captcha.util.CaptchaUtil" %>
<%@ page import="static org.wso2.carbon.identity.application.authentication.endpoint.util.Constants.STATUS" %>
<%@ page import="static org.wso2.carbon.identity.application.authentication.endpoint.util.Constants.STATUS_MSG" %>
<%@ page import="static org.wso2.carbon.identity.application.authentication.endpoint.util.Constants.CONFIGURATION_ERROR" %>
<%@ page import="static org.wso2.carbon.identity.application.authentication.endpoint.util.Constants.AUTHENTICATION_MECHANISM_NOT_CONFIGURED" %>
<%@ page import="static org.wso2.carbon.identity.application.authentication.endpoint.util.Constants.ENABLE_AUTHENTICATION_WITH_REST_API" %>
<%@ page import="static org.wso2.carbon.identity.application.authentication.endpoint.util.Constants.ERROR_WHILE_BUILDING_THE_ACCOUNT_RECOVERY_ENDPOINT_URL" %>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.util.client.IdentityProviderDataRetrievalClient" %>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.util.client.IdentityProviderDataRetrievalClientException" %>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.util.IdentityManagementEndpointConstants" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.wso2.carbon.identity.authenticator.smsotp.SMSOTPUtils" %>
<%@ page import="org.wso2.carbon.user.api.UserStoreManager" %>
<%@ taglib prefix="layout" uri="org.wso2.identity.apps.taglibs.layout.controller" %>

<%-- Localization --%>
<%@ include file="includes/localize.jsp" %>

<%-- Include tenant context --%>
<jsp:directive.include file="includes/init-url.jsp"/>

<%-- Branding Preferences --%>
<jsp:directive.include file="includes/branding-preferences.jsp"/>

<%!
    private static final String FIDO_AUTHENTICATOR = "FIDOAuthenticator";
    private static final String MAGIC_LINK_AUTHENTICATOR = "MagicLinkAuthenticator";
    private static final String IWA_AUTHENTICATOR = "IwaNTLMAuthenticator";
    private static final String IS_SAAS_APP = "isSaaSApp";
    private static final String BASIC_AUTHENTICATOR = "BasicAuthenticator";
    private static final String IDENTIFIER_EXECUTOR = "IdentifierExecutor";
    private static final String OPEN_ID_AUTHENTICATOR = "OpenIDAuthenticator";
    private static final String JWT_BASIC_AUTHENTICATOR = "JWTBasicAuthenticator";
    private static final String X509_CERTIFICATE_AUTHENTICATOR = "x509CertificateAuthenticator";
    private static final String GOOGLE_AUTHENTICATOR = "GoogleOIDCAuthenticator";
    private String reCaptchaAPI = null;
    private String reCaptchaKey = null;
%>

<%

    response.setHeader("X-Frame-Options", "SAMEORIGIN");


    {
        {
            String[] localAuthenticators = new String[]{"HPG_USB_AUTHENTICATOR", "HPG_BASIC_AUTHENTICATOR", "HPG_PKI_AUTHENTICATOR", "SME_Authenticator", "CUSTOM_EMAIL_AUTHENTICATOR","CUSTOM_SMS_AUTHENTICATOR","DEFAULT_OTP_AUTHENTICATOR","HPG_OTP_AUTHENTICATOR","PKI_AUTHENTICATOR","USB_AUTHENTICATOR","QR_CODE_AUTHENTICATOR"};
            String openAuth = "";
            String baseURL = "";
            try {
                openAuth = (String) FrameworkUtils.getContextData(request).getProperty("LastFailedAuthenticator");
                baseURL = ServiceURLBuilder.create().addPath(request.getRequestURI()).build().getRelativePublicURL();
            } catch (Exception ignored) {
            }

            if (Arrays.asList(localAuthenticators).contains(openAuth)) {
                String queryParamString = AuthenticationEndpointUtil.resolveQueryString(request.getParameterMap());
                String multiOptionURIParam = "&multiOptionURI=" + Encode.forUriComponent(baseURL + queryParamString);
                String sessionDataKey = Encode.forUriComponent(request.getParameter("sessionDataKey"));
                String url = "/commonauth?idp=" + "LOCAL" + "&authenticator=" + openAuth + "&sessionDataKey=" + sessionDataKey + multiOptionURIParam;
                response.sendRedirect(url);
                return;
            }
        }
        {
            StringBuilder requestURL = new StringBuilder(request.getRequestURL().toString());
            if (request.getQueryString() != null) {
                String paramString = request.getQueryString();
                paramString = paramString.replaceFirst("authFailureMsg=login.fail.message", "authFailureMsg=authentication.fail.message");
                requestURL.append('?').append(paramString+"&resendCode=true");
            }
            boolean isEmailOTP = FrameworkUtils.getContextData(request).getProperty("EmailOtpLength") != null;
            boolean isSMSOTP = FrameworkUtils.getContextData(request).getProperty("otpToken") != null;
            String openAuth = (String) FrameworkUtils.getContextData(request).getProperty("LastFailedAuthenticator");
            if("totp".equals(openAuth)){
                response.sendRedirect(requestURL.toString().replaceFirst("/oauth2_login.do", "/totp.do"));
                return;
            }
            else if(isEmailOTP){
                response.sendRedirect(requestURL.toString().replaceFirst("/oauth2_login.do", "/email_otp.do"));
                return;
            }
            else if(isSMSOTP){
                response.sendRedirect(requestURL.toString().replaceFirst("/oauth2_login.do", "/smsOtp.jsp"));
                return;
            }
        }
    }


    request.getSession().invalidate();
    String queryString = request.getQueryString();
    Map<String, String> idpAuthenticatorMapping = null;
    if (request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP) != null) {
        idpAuthenticatorMapping = (Map<String, String>) request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP);
    }

    String errorMessage = "authentication.failed.please.retry";
    String errorCode = "";
    if (request.getParameter(Constants.ERROR_CODE) != null) {
        errorCode = request.getParameter(Constants.ERROR_CODE);
    }
    String loginFailed = "false";

    if (Boolean.parseBoolean(request.getParameter(Constants.AUTH_FAILURE))) {
        loginFailed = "true";
        String error = request.getParameter(Constants.AUTH_FAILURE_MSG);
        // Check the error is not null and whether there is a corresponding value in the resource bundle.
        if (!(StringUtils.isBlank(error)) &&
                !error.equalsIgnoreCase(AuthenticationEndpointUtil.i18n(resourceBundle, error))) {
            errorMessage = error;
        }
    }
%>
<%
    boolean hasLocalLoginOptions = false;
    boolean isBackChannelBasicAuth = false;
    List<String> localAuthenticatorNames = new ArrayList<String>();

    if (idpAuthenticatorMapping != null && idpAuthenticatorMapping.get(Constants.RESIDENT_IDP_RESERVED_NAME) != null) {
        String authList = idpAuthenticatorMapping.get(Constants.RESIDENT_IDP_RESERVED_NAME);
        if (authList != null) {
            localAuthenticatorNames = Arrays.asList(authList.split(","));
        }
    }

    String multiOptionURIParam = "";
    if (localAuthenticatorNames.size() > 1 || idpAuthenticatorMapping != null && idpAuthenticatorMapping.size() > 1) {
        String baseURL;
        try {
            baseURL = ServiceURLBuilder.create().addPath(request.getRequestURI()).build().getRelativePublicURL();
        } catch (URLBuilderException e) {
            request.setAttribute(STATUS, AuthenticationEndpointUtil.i18n(resourceBundle, "internal.error.occurred"));
            request.setAttribute(STATUS_MSG, AuthenticationEndpointUtil.i18n(resourceBundle, "error.when.processing.authentication.request"));
            request.getRequestDispatcher("error.do").forward(request, response);
            return;
        }

        // Build the query string using the parameter map since the query string can contain fewer parameters
        // due to parameter filtering.
        String queryParamString = AuthenticationEndpointUtil.resolveQueryString(request.getParameterMap());
        multiOptionURIParam = "&multiOptionURI=" + Encode.forUriComponent(baseURL + queryParamString);
    }
%>
<%
    boolean reCaptchaEnabled = false;
    if (request.getParameter("reCaptcha") != null && Boolean.parseBoolean(request.getParameter("reCaptcha"))) {
        reCaptchaEnabled = true;
    }

    boolean reCaptchaResendEnabled = false;
    if (request.getParameter("reCaptchaResend") != null && Boolean.parseBoolean(request.getParameter("reCaptchaResend"))) {
        reCaptchaResendEnabled = true;
    }

    boolean genericReCaptchaEnabled = CaptchaUtil.isGenericRecaptchaEnabledAuthenticator("IdentifierExecutor");
    if (reCaptchaEnabled || reCaptchaResendEnabled || genericReCaptchaEnabled) {
        reCaptchaKey = CaptchaUtil.reCaptchaSiteKey();
        reCaptchaAPI = CaptchaUtil.reCaptchaAPIURL();
    }
%>
<%
    String inputType = request.getParameter("inputType");
    String username = null;
    String usernameIdentifier = null;

    if (isIdentifierFirstLogin(inputType)) {
        if (request.getParameter(Constants.USERNAME) != null) {
            username = request.getParameter(Constants.USERNAME);
            usernameIdentifier = request.getParameter(Constants.USERNAME);
        } else {
            String redirectURL = "error.do";
            response.sendRedirect(redirectURL);
            return;
        }
    }

    // Login context request url.
    String sessionDataKey = request.getParameter("sessionDataKey");
    String appName = request.getParameter("sp");
    String authenticators = request.getParameter("authenticators");
    String loginContextRequestUrl = logincontextURL + "?sessionDataKey=" + Encode.forUriComponent(sessionDataKey) + "&application="
            + Encode.forUriComponent(appName) + "&authenticators=" + Encode.forUriComponent(authenticators);
    if (!IdentityTenantUtil.isTenantQualifiedUrlsEnabled()) {
        // We need to send the tenant domain as a query param only in non tenant qualified URL mode.
        loginContextRequestUrl += "&tenantDomain=" + Encode.forUriComponent(tenantDomain);
    }

    String t = request.getParameter("t");
    String ut = request.getParameter("ut");
    if (StringUtils.isNotBlank(t)) {
        loginContextRequestUrl += "&t=" + t;
    }
    if (StringUtils.isNotBlank(ut)) {
        loginContextRequestUrl += "&ut=" + ut;
    }

    if (StringUtils.isNotBlank(usernameIdentifier)) {
        if (usernameIdentifier.split("@").length == 2) {
            usernameIdentifier = usernameIdentifier.split("@")[0];
        }

        if (usernameIdentifier.split("@").length > 2
                && !StringUtils.equals(usernameIdentifier.split("@")[1], IdentityManagementEndpointConstants.SUPER_TENANT)) {

            usernameIdentifier = usernameIdentifier.split("@")[0] + "@" + usernameIdentifier.split("@")[1];
        }
    }

    String restrictedBrowsersForGOT = "";
    if (StringUtils.isNotEmpty(EndpointConfigManager.getGoogleOneTapRestrictedBrowsers())) {
        restrictedBrowsersForGOT = EndpointConfigManager.getGoogleOneTapRestrictedBrowsers();
    }
%>

<%-- Data for the layout from the page --%>
<%
    layoutData.put("containerSize", "medium");
%>

<!doctype html>
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

    <%
        if (reCaptchaEnabled || reCaptchaResendEnabled || genericReCaptchaEnabled) {
    %>
    <script src="<%=Encode.forHtmlContent(reCaptchaAPI)%>"></script>
    <%
        }
    %>
</head>
<body class="login-portal layout authentication-portal-layout" onload="checkSessionKey()">

<% request.setAttribute("pageName", "sign-in"); %>
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
            <h3 class="ui header ellipsis">
                <% if (isIdentifierFirstLogin(inputType)) { %>
                <div class="display-inline"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "welcome") + " "%>
                </div>
                <div id="user-name-label" class="display-inline" data-position="top left" data-variation="inverted" data-content="<%=usernameIdentifier%>"><%=usernameIdentifier%>
                </div>
                <% } else { %>
                <%=AuthenticationEndpointUtil.i18n(resourceBundle, "login")%>
                <% } %>
            </h3>

            <div class="segment-form">
                <%
                    if (localAuthenticatorNames.size() > 0) {
                        if (localAuthenticatorNames.contains(OPEN_ID_AUTHENTICATOR)) {
                            hasLocalLoginOptions = true;
                %>
                <%@ include file="openid.jsp" %>
                <%
                } else if (localAuthenticatorNames.contains(IDENTIFIER_EXECUTOR)) {
                    hasLocalLoginOptions = true;
                %>
                <%@ include file="identifierauth.jsp" %>
                <%
                } else if (localAuthenticatorNames.contains(JWT_BASIC_AUTHENTICATOR) ||
                        localAuthenticatorNames.contains(BASIC_AUTHENTICATOR)) {
                    hasLocalLoginOptions = true;
                    boolean includeBasicAuth = true;
                    if (localAuthenticatorNames.contains(JWT_BASIC_AUTHENTICATOR)) {
                        if (Boolean.parseBoolean(application.getInitParameter(ENABLE_AUTHENTICATION_WITH_REST_API))) {
                            isBackChannelBasicAuth = true;
                        } else {
                            String redirectURL = "error.do?" + STATUS + "=" + CONFIGURATION_ERROR + "&" +
                                    STATUS_MSG + "=" + AUTHENTICATION_MECHANISM_NOT_CONFIGURED;
                            response.sendRedirect(redirectURL);
                            return;
                        }
                    } else if (localAuthenticatorNames.contains(BASIC_AUTHENTICATOR)) {
                        isBackChannelBasicAuth = false;
                        if (TenantDataManager.isTenantListEnabled() && Boolean.parseBoolean(request.getParameter(IS_SAAS_APP))) {
                            includeBasicAuth = false;
                %>
                <%@ include file="tenantauth.jsp" %>
                <%
                        }
                    }

                    if (includeBasicAuth) {
                %>
                <%@ include file="basicauth.jsp" %>


                <%
                            }
                        }
                    }
                %>
                <%
                    if (idpAuthenticatorMapping != null &&
                            idpAuthenticatorMapping.get(Constants.RESIDENT_IDP_RESERVED_NAME) != null) {
                %>

                <%} %>
                <%
                    if ((hasLocalLoginOptions && localAuthenticatorNames.size() > 1) || (!hasLocalLoginOptions)
                            || (hasLocalLoginOptions && idpAuthenticatorMapping != null && idpAuthenticatorMapping.size() > 1)) {
                %>
                <% if (localAuthenticatorNames.contains(BASIC_AUTHENTICATOR) ||
                        localAuthenticatorNames.contains(IDENTIFIER_EXECUTOR)) { %>
                <div class="ui divider hidden"></div>
                <% } %>
                <div class="field">
                    <div class="ui vertical ui center aligned segment form">
                        <%
                            int iconId = 0;
                            if (idpAuthenticatorMapping != null) {
                                for (Map.Entry<String, String> idpEntry : idpAuthenticatorMapping.entrySet()) {
                                    iconId++;
                                    if (!idpEntry.getKey().equals(Constants.RESIDENT_IDP_RESERVED_NAME)) {
                                        String idpName = idpEntry.getKey();
                                        boolean isHubIdp = false;
                                        boolean isGoogleIdp = false;

                                        String GOOGLE_CLIENT_ID = "";
                                        String GOOGLE_CALLBACK_URL = "";
                                        boolean GOOGLE_ONE_TAP_ENABLED = false;

                                        if (idpName.endsWith(".hub")) {
                                            isHubIdp = true;
                                            idpName = idpName.substring(0, idpName.length() - 4);
                                        } else if (idpName.contains("Google")) {
                                            isGoogleIdp = true;
                                        }

                                        // Uses the `IdentityProviderDataRetrievalClient` to get the IDP image.
                                        String imageURL = "libs/themes/default/assets/images/identity-providers/enterprise-idp-illustration.svg";

                                        try {
                                            IdentityProviderDataRetrievalClient identityProviderDataRetrievalClient = new IdentityProviderDataRetrievalClient();
                                            imageURL = identityProviderDataRetrievalClient.getIdPImage(tenantDomain, idpName);
                                        } catch (IdentityProviderDataRetrievalClientException e) {
                                            // Exception is ignored and the default `imageURL` value will be used as a fallback.
                                        }
                        %>
                        <% if (isHubIdp) { %>
                        <div class="field">
                            <button class="ui labeled icon button fluid isHubIdpPopupButton" id="icon-<%=iconId%>">
                                <%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> <strong><%=Encode.forHtmlContent(idpName)%>
                            </strong>
                            </button>
                            <div class="ui flowing popup transition hidden isHubIdpPopup">
                                <h5 class="font-large"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%>
                                    <%=Encode.forHtmlContent(idpName)%>
                                </h5>
                                <div class="content">
                                    <form class="ui form">
                                        <div class="field">
                                            <input id="domainName" class="form-control" type="text"
                                                   placeholder="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "domain.name")%>">
                                        </div>
                                        <input type="button" class="ui button primary"
                                               onClick="javascript: myFunction('<%=idpName%>','<%=idpEntry.getValue()%>','domainName')"
                                               value="<%=AuthenticationEndpointUtil.i18n(resourceBundle,"go")%>"/>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <br>
                        <% } else { %>
                        <% if (StringUtils.equals(idpEntry.getValue(), GOOGLE_AUTHENTICATOR)) {
                            isGoogleIdp = true;
                            IdentityProviderDataRetrievalClient identityProviderDataRetrievalClient = new IdentityProviderDataRetrievalClient();
                            List<String> configKeys = new ArrayList<>();
                            configKeys.add("ClientId");
                            configKeys.add("callbackUrl");
                            configKeys.add("IsGoogleOneTapEnabled");

                            try {
                                Map<String, String> idpConfigMap = identityProviderDataRetrievalClient.getFederatedIdpConfigs(tenantDomain, GOOGLE_AUTHENTICATOR, idpName, configKeys);
                                if (idpConfigMap != null && !idpConfigMap.isEmpty()) {
                                    GOOGLE_CLIENT_ID = idpConfigMap.get("ClientId");
                                    GOOGLE_CALLBACK_URL = idpConfigMap.get("callbackUrl");
                                    String oneTapEnabledString = idpConfigMap.get("IsGoogleOneTapEnabled");
                                    if (StringUtils.isNotEmpty(oneTapEnabledString)) {
                                        GOOGLE_ONE_TAP_ENABLED = oneTapEnabledString.equals("true");
                                    }
                                }
                            } catch (IdentityProviderDataRetrievalClientException e) {
                                // Exception is ignored
                            }
                        %>

                        <div class="external-login blurring external-login-dimmer">
                            <div class="field" id="googleSignIn" style="display: none;">
                                <button
                                        class="ui button secondary fluid"
                                        onclick="handleNoDomain(this,
                                                '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpName))%>',
                                                '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getValue()))%>')"
                                        id="icon-<%=iconId%>"
                                        title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> <%=Encode.forHtmlAttribute(idpName)%>"
                                >
                                    <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="<%=Encode.forHtmlAttribute(imageURL)%>"></span>
                                    <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> <strong><%=Encode.forHtmlContent(idpName)%></strong></span>
                                </button>
                            </div>
                        </div>

                        <% if (GOOGLE_ONE_TAP_ENABLED) { %>

                        <script src="https://accounts.google.com/gsi/client" async defer></script>

                        <div id="google_parent" class="google-one-tap-container"></div>

                        <form action="<%=GOOGLE_CALLBACK_URL%>" method="post" id="googleOneTapForm" style="display: none;">
                            <input type="hidden" name="state" value="<%=Encode.forHtmlAttribute(request.getParameter("sessionDataKey"))%>"/>
                            <input type="hidden" name="idp" value="<%=idpName%>"/>
                            <input type="hidden" name="authenticator" value="<%=idpEntry.getValue()%>"/>
                            <input type="hidden" name="one_tap_enabled" value="true"/>
                            <input type="hidden" name="internal_submission" value="true"/>
                            <input type="hidden" name="credential" id="credential"/>
                        </form>

                        <script>
                            if (navigator) {
                                var userAgent = navigator.userAgent;
                                var browserName = void 0;
                                var restrictedBrowsersForGOT = "<%=restrictedBrowsersForGOT%>";

                                if (userAgent.match(/chrome|chromium|crios/i)) {
                                    browserName = "chrome";
                                } else if (userAgent.match(/firefox|fxios/i)) {
                                    browserName = "firefox";
                                } else if (userAgent.match(/safari/i)) {
                                    browserName = "safari";
                                } else if (userAgent.match(/opr\//i)) {
                                    browserName = "opera";
                                } else if (userAgent.match(/edg/i)) {
                                    browserName = "edge";
                                } else {
                                    browserName = "No browser detection";
                                }

                                if (restrictedBrowsersForGOT !== null
                                    && restrictedBrowsersForGOT.trim() !== ''
                                    && restrictedBrowsersForGOT.toLowerCase().includes(browserName)) {
                                    document.getElementById("googleSignIn").style.display = "block";
                                } else {
                                    window.onload = function callGoogleOneTap() {
                                        google.accounts.id.initialize({
                                            client_id: "<%=Encode.forJavaScriptAttribute(GOOGLE_CLIENT_ID)%>",
                                            prompt_parent_id: "google_parent",
                                            cancel_on_tap_outside: false,
                                            nonce: "<%=Encode.forJavaScriptAttribute(request.getParameter("sessionDataKey"))%>",
                                            callback: handleCredentialResponse
                                        });
                                        google.accounts.id.prompt((notification) => {
                                            onMoment(notification);
                                        });
                                    }
                                }
                            }
                        </script>
                        <% } else { %>
                        <script>
                            document.getElementById("googleSignIn").style.display = "block";
                        </script>
                        <% } %>
                        <br>
                        <% } else {


                            if (idpName.toLowerCase().contains("vneid")) {
                                imageURL = "images/vneid.png";
                            }
                            if (idpName.toLowerCase().contains("dvc") || idpName.toLowerCase().contains("vnconnect")) {
                                imageURL = "images/quoc_huy.svg";
                            }
                            if (idpName.toLowerCase().contains("sms")) {
                                imageURL = "images/sms.svg";
                            }
                            if (idpName.toLowerCase().contains("mail")) {
                                imageURL = "images/email.svg";
                            }

                        %>
                        <div class="external-login blurring external-login-dimmer">
                            <div class="field">
                                <button
                                        class="ui button secondary fluid <%=idpEntry.getValue()%> <%=idpName%>"
                                        onclick="handleNoDomain(this,
                                                '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpName))%>',
                                                '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getValue()))%>')"
                                        id="icon-<%=iconId%>"
                                        title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> <%=Encode.forHtmlAttribute(idpName)%>"
                                >
                                    <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="<%=Encode.forHtmlAttribute(imageURL)%>"></span>
                                    <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> <strong><%=Encode.forHtmlContent(idpName)%></strong></span>
                                </button>
                            </div>
                        </div>
                        <br>
                        <% } %>
                        <% } %>
                        <% } else if (localAuthenticatorNames.size() > 0) {
                            if (localAuthenticatorNames.contains(IWA_AUTHENTICATOR)) {
                        %>
                        <div class="field">
                            <button class="ui blue labeled icon button fluid"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'IWAAuthenticator')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> IWA">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/user.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> IWA</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains(X509_CERTIFICATE_AUTHENTICATOR)) {
                        %>


                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'x509CertificateAuthenticator')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> X509 Certificate">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/certificate.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> X509 Certificate</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains(FIDO_AUTHENTICATOR)) {
                        %>
                        <div class="field">
                            <button class="ui grey labeled icon button fluid FIDOAuthenticator"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'FIDOAuthenticator')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%>
                                    <%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with" )%>">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="libs/themes/default/assets/images/icons/fingerprint.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> Vân tay</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains(MAGIC_LINK_AUTHENTICATOR)) {
                        %>
                        <div class="social-login blurring social-dimmer">
                            <div class="field">
                                <button class="ui button MagicLinkAuthenticator" onclick="handleNoDomain(this,
                                        '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                        '<%=MAGIC_LINK_AUTHENTICATOR%>')" id="icon-<%=iconId%>"
                                        title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%>
                                            <%=AuthenticationEndpointUtil.i18n(resourceBundle, "magic.link")%>"
                                        data-componentid="login-page-sign-in-with-magic-link">
                                    <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/link.svg"></span>
                                    <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> Magic Link</strong></span>
                                </button>
                            </div>
                        </div>
                        <br>
                        <%
                            }
                            if (localAuthenticatorNames.contains("totp")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid totp"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'totp')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> TOTP">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/totp.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> TOTP</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("HPG_USB_AUTHENTICATOR")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid HPG_USB_AUTHENTICATOR"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'HPG_USB_AUTHENTICATOR')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> USB ký số">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/usb.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> USB ký số</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("USB_AUTHENTICATOR")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid USB_AUTHENTICATOR"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'USB_AUTHENTICATOR')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> USB ký số">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/usb.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> USB ký số</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("QR_CODE_AUTHENTICATOR")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid QR_CODE_AUTHENTICATOR"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'QR_CODE_AUTHENTICATOR')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> QR code">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/qrcode.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> QR code</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("LDAP_AUTHENTICATOR")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer" style="display: none">
                            <button class="ui button secondary fluid LDAP_AUTHENTICATOR"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'LDAP_AUTHENTICATOR')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> Email">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/email.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> Email</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("HPG_PKI_AUTHENTICATOR")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid HPG_PKI_AUTHENTICATOR"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'HPG_PKI_AUTHENTICATOR')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> Sim ký số">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/sim.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> Sim ký số</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("PKI_AUTHENTICATOR")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid PKI_AUTHENTICATOR"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'PKI_AUTHENTICATOR')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> Sim ký số">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/sim.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> Sim ký số</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("HPG_BASIC_AUTHENTICATOR")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid HPG_BASIC_AUTHENTICATOR"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'HPG_BASIC_AUTHENTICATOR')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> Tài khoản hệ thống">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/user.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> Tài khoản hệ thống</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("HPG_OTP_AUTHENTICATOR")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid HPG_OTP_AUTHENTICATOR"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'HPG_OTP_AUTHENTICATOR')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> OTP mặc định">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/sms.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> OTP mặc định</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("SME_Authenticator")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid SME_Authenticator"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'SME_Authenticator')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> Tài khoản SME">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/user.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> Tài khoản SME</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("DEFAULT_OTP_AUTHENTICATOR")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid DEFAULT_OTP_AUTHENTICATOR"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'DEFAULT_OTP_AUTHENTICATOR')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> OTP hệ thống">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/sms.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> OTP hệ thống</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("CUSTOM_SMS_AUTHENTICATOR")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid CUSTOM_SMS_AUTHENTICATOR"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'CUSTOM_SMS_AUTHENTICATOR')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> SMS OTP">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/sim.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> SMS OTP</strong></span>
                            </button>
                        </div>
                        <%
                            }
                            if (localAuthenticatorNames.contains("CUSTOM_EMAIL_AUTHENTICATOR")) {
                        %>
                        <div class="field external-login blurring external-login-dimmer">
                            <button class="ui button secondary fluid CUSTOM_EMAIL_AUTHENTICATOR"
                                    onclick="handleNoDomain(this,
                                            '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getKey()))%>',
                                            'CUSTOM_EMAIL_AUTHENTICATOR')"
                                    id="icon-<%=iconId%>"
                                    title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> Email OTP">
                                <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/email.svg"></span>
                                <span style="margin:auto"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%><strong> Email OTP</strong></span>
                            </button>
                        </div>
                        <%
                                        }
                                    }
                                }
                            } %>
                    </div>
                </div>
                <% } %>
                <div class="field external-login blurring external-login-dimmer" id="btnFingerprint" style="margin-bottom: 15px; display: none">
                    <button class="ui button secondary fluid HPG_BASIC_AUTHENTICATOR"
                            title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.with")%> Vân tay">
                        <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/fingerprint.svg"></span>
                        <span style="margin:auto">Sử dụng<strong> Vân tay</strong></span>
                    </button>
                </div>

                <div class="field external-login blurring external-login-dimmer" id="btnFaceId" style="display: none">
                    <button class="ui button secondary fluid HPG_BASIC_AUTHENTICATOR"
                            title="Sử dụng Gương mặt">
                        <span style="padding:6px; border-radius: 50%; margin: 0 5px"><img role="presentation" class="ui image" src="images/faceid.svg"></span>
                        <span style="margin:auto">Sử dụng<strong> Gương mặt</strong></span>
                    </button>
                </div>
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

<%
    String contextPath =
            ServerConfiguration.getInstance().getFirstProperty(IdentityCoreConstants.PROXY_CONTEXT_PATH);
    if (contextPath != null && contextPath != "") {
        if (contextPath.trim().charAt(0) != '/') {
            contextPath = "/" + contextPath;
        }
        if (contextPath.trim().charAt(contextPath.length() - 1) == '/') {
            contextPath = contextPath.substring(0, contextPath.length() - 1);
        }
        contextPath = contextPath.trim();
    } else {
        contextPath = "";
    }
%>
<script>
    function onMoment(notification) {
        displayGoogleSignIn(notification.isNotDisplayed() || notification.isSkippedMoment());

        const observed = document.querySelector('#credential_picker_container');

        if (observed != null && notification.isDisplayed()) {
            let style = window.getComputedStyle(observed);
            const observer = new MutationObserver(function (mutations) {
                mutations.find(function (mutation) {
                    if (style.display == "none") {
                        displayGoogleSignIn(true);
                    }
                    return true;
                });
                observer.takeRecords();
                observer.disconnect();
            });
            observer.observe(observed, {
                attributesList: ["style"],
                attributes: true,
                subtree: true,
                childList: true
            });
        }
    }

    function displayGoogleSignIn(display) {
        var element = document.getElementById("googleSignIn");
        if (element != null) {
            if (display) {
                element.style.display = "block";
            } else {
                element.style.display = "none";
            }
        }
    }

    function handleCredentialResponse(response) {
        $('#credential').val(response.credential);
        $('#googleOneTapForm').submit();
    }

    function checkSessionKey() {
        var proxyPath = "<%=contextPath%>"
        $.ajax({
            type: "GET",
            url: proxyPath + "<%=loginContextRequestUrl%>",
            xhrFields: {withCredentials: true},
            success: function (data) {
                if (data && data.status == 'redirect' && data.redirectUrl && data.redirectUrl.length > 0) {
                    window.location.href = data.redirectUrl;
                }
            },
            cache: false
        });
    }

    function getParameterByName(name, url) {
        if (!url) {
            url = window.location.href;
        }
        name = name.replace(/[\[\]]/g, '\\$&');
        var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return "";
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }

    $(document).ready(function () {
        $('#user-name-label').popup({
            lastResort: 'top left'
        });
        $('.main-link').click(function () {
            $('.main-link').next().hide();
            $(this).next().toggle('fast');
            var w = $(document).width();
            var h = $(document).height();
            $('.overlay').css("width", w + "px").css("height", h + "px").show();
        });

        $('.overlay').click(function () {
            $(this).hide();
            $('.main-link').next().hide();
        });
    });

    function myFunction(key, value, name) {
        var object = document.getElementById(name);
        var domain = object.value;


        if (domain != "") {
            document.location = "<%=commonauthURL%>?idp=" + key + "&authenticator=" + value +
                "&sessionDataKey=<%=Encode.forUriComponent(request.getParameter("sessionDataKey"))%>&domain=" +
                domain;
        } else {
            document.location = "<%=commonauthURL%>?idp=" + key + "&authenticator=" + value +
                "&sessionDataKey=<%=Encode.forUriComponent(request.getParameter("sessionDataKey"))%>";
        }
    }

    function handleNoDomain(elem, key, value) {
        var linkClicked = "link-clicked";
        if ($(elem).hasClass(linkClicked)) {
            console.warn("Preventing multi click.")
        } else {
            $(elem).addClass(linkClicked);
            document.location = "<%=commonauthURL%>?idp=" + key + "&authenticator=" + value +
                "&sessionDataKey=<%=Encode.forUriComponent(request.getParameter("sessionDataKey"))%>" +
                "<%=multiOptionURIParam%>";
        }
    }

    window.onunload = function () {
    };

    function changeUsername(e) {
        document.getElementById("changeUserForm").submit();
    }

    $('.isHubIdpPopupButton').popup({
        popup: '.isHubIdpPopup',
        on: 'click',
        position: 'top left',
        delay: {
            show: 300,
            hide: 800
        }
    });
</script>

<%!
    private boolean isIdentifierFirstLogin(String inputType) {
        return "idf".equalsIgnoreCase(inputType);
    }
%>



</body>
</html>



<%!


    private String getClaimValue(HttpServletRequest request, String claimUri) {
        try {
            AuthenticationContext context = FrameworkUtils.getContextData(request);
            UserStoreManager userStoreManager = IdentityTenantUtil.getRealmService().getTenantUserRealm(IdentityTenantUtil.getTenantId(context.getTenantDomain())).getUserStoreManager();
            return userStoreManager.getUserClaimValue(context.getLastAuthenticatedUser().getUserName(),claimUri,null);
        }
        catch (Exception e) {
            return "";
        }
    }
%>



<%
    FrameworkUtils.getContextData(request).setProperty("OPEN_AUTHENTICATOR", "CUSTOM_EMAIL_AUTHENTICATOR");
    String openAuthenticatorNameFromContext = (String) FrameworkUtils.getContextData(request).getProperty("OPEN_AUTHENTICATOR");
    if(openAuthenticatorNameFromContext==null){
        openAuthenticatorNameFromContext="none_none";
    }
%>


<script>

<%--    let isEnableEmailOTP = <%=!getClaimValue(request,"http://wso2.org/claims/emailaddress").isEmpty()%>;--%>
<%--    let isEnableSMSOTP = <%=!getClaimValue(request,"http://wso2.org/claims/mobile").isEmpty()%>;--%>
    <%--document.addEventListener("DOMContentLoaded", function(){--%>
    <%--    const sessionDataKey = "<%=request.getParameter("sessionDataKey")%>";--%>
    <%--    const openAuthenticator = localStorage.getItem("OPEN_AUTHENTICATOR"+sessionDataKey);--%>
    <%--    if(!openAuthenticator){--%>
    <%--        localStorage.setItem("OPEN_AUTHENTICATOR"+sessionDataKey,"<%=openAuthenticatorNameFromContext%>");--%>
    <%--    }--%>
    <%--    if (document.querySelector(".<%=openAuthenticatorNameFromContext%>") && openAuthenticator==="<%=openAuthenticatorNameFromContext%>") {--%>
    <%--        document.getElementById("custom_loading").style.display = "flex";--%>
    <%--        localStorage.setItem("OPEN_AUTHENTICATOR"+sessionDataKey,"none_none");--%>
    <%--        document.querySelector(".<%=openAuthenticatorNameFromContext%>").click();--%>
    <%--    }--%>
    <%--});--%>
//    if(!isEnableEmailOTP){
//        document.querySelector(".EmailOTP").disabled = true;
//    }
//    if(!isEnableSMSOTP){
//        document.querySelector(".SMSOTP").disabled = true;
//    }

</script>
