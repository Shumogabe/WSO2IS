<!--
* Copyright (c) 2022, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
*
* WSO2 Inc. licenses this file to you under the Apache License,
* Version 2.0 (the "License"); you may not use this file except
* in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing,
* software distributed under the License is distributed on an
* "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
* KIND, either express or implied. See the License for the
* specific language governing permissions and limitations
* under the License.
-->

<%@ page import="static org.wso2.carbon.identity.core.util.IdentityUtil.getServerURL" %>
<%@ page import="static org.wso2.carbon.utils.multitenancy.MultitenantConstants.TENANT_AWARE_URL_PREFIX"%>
<%@ page import="static org.wso2.carbon.utils.multitenancy.MultitenantConstants.SUPER_TENANT_DOMAIN_NAME"%>
<%@ page import="static org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils.isAdaptiveAuthenticationAvailable"%>
<%@ page import="static org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils.isOrganizationManagementEnabled"%>

<jsp:scriptlet>
    session.setAttribute("authCode", request.getParameter("code"));
    session.setAttribute("sessionState", request.getParameter("session_state"));
    if(request.getParameter("state") != null) {session.setAttribute("state", request.getParameter("state"));}
</jsp:scriptlet>

<!DOCTYPE HTML>
<html>
    <head>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
        <meta name="referrer" content="no-referrer" />

        <link href="/console/libs/themes/default/theme.c3616ae0.min.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="/console/libs/themes/default/assets/images/branding/favicon.ico" />

        <script>
            var contextPathGlobal = "/console/";
            var serverOriginGlobal = "<%=getServerURL("", true, true)%>";
            var superTenantGlobal = "<%=SUPER_TENANT_DOMAIN_NAME%>";
            var tenantPrefixGlobal = "<%=TENANT_AWARE_URL_PREFIX%>";
            var isAdaptiveAuthenticationAvailable = JSON.parse("<%= isAdaptiveAuthenticationAvailable() %>");
            var isOrganizationManagementEnabled = JSON.parse("<%= isOrganizationManagementEnabled() %>");
        </script>

        <script>

            var userAccessedPath = sessionStorage.getItem("userAccessedPath");
            var isSilentSignInDisabled = userAccessedPath.includes("disable_silent_sign_in") ||
                                            window.location.href.includes("disable_silent_sign_in");
            var isInviteUserFlow = userAccessedPath.includes("invite_user");
            var isApplicationsPath = userAccessedPath.includes("develop/applications") ||
                                        window.location.href.includes("develop/applications");

            if(isInviteUserFlow) {
                window.location.href = window.location.origin;
            }
        </script>

    <script defer src="/console/static/js/runtime.31571245.js?ef0214eadccecff3"></script><script defer src="/console/static/js/0.aca291ee.js?ef0214eadccecff3"></script><script defer src="/console/static/js/1.4ea9b21c.js?ef0214eadccecff3"></script><script defer src="/console/static/js/vendor.130c094f.js?ef0214eadccecff3"></script><script defer src="/console/static/js/main.53cae456.js?ef0214eadccecff3"></script></head>
    <body>
        <noscript>
            You need to enable JavaScript to run this app.
        </noscript>
        <div id="root"></div>
    </body>
</html>
