<!--
* Copyright (c) 2022, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
*
* WSO2 LLC. licenses this file to you under the Apache License,
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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="static org.wso2.carbon.identity.core.util.IdentityUtil.getServerURL" %>
<%@ page import="static org.wso2.carbon.utils.multitenancy.MultitenantConstants.SUPER_TENANT_DOMAIN_NAME"%>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="static org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils.isOrganizationManagementEnabled"%>

<jsp:scriptlet>
    if(request.getParameter("code") != null && !request.getParameter("code").trim().isEmpty()) {request.getRequestDispatcher("/authenticate?code="+request.getParameter("code")+"&AuthenticatedIdPs="+request.getParameter("AuthenticatedIdPs")+"&session_state="+request.getParameter("session_state")).forward(request, response);}
</jsp:scriptlet>

<!DOCTYPE html>
<html>
    <head>
        <script>
            // Handles myaccount tenanted signout before auth sdk get loaded
            var applicationDomain = window.location.origin;
            var userAccessedPath = window.location.href;
            var isSignOutSuccess = userAccessedPath.includes("sign_out_success");

            if(isSignOutSuccess) {
                window.location.href = applicationDomain+'/'+"myaccount"
            }
        </script>
        <script src="/myaccount/auth-spa-0.3.3.min.js"></script>
    </head>
    <body>
        <script>
            var serverOrigin = "<%=getServerURL("", true, true)%>";
            var authorizationCode = "<%=Encode.forHtml(request.getParameter("code"))%>" != "null"
                                        ? "<%=Encode.forHtml(request.getParameter("code"))%>"
                                        : null;
            var authSessionState = "<%=Encode.forHtml(request.getParameter("session_state"))%>" != "null"
                                        ? "<%=Encode.forHtml(request.getParameter("session_state"))%>"
                                        : null;
            var isOrganizationManagementEnabled = JSON.parse("<%= isOrganizationManagementEnabled() %>");


            if(!authorizationCode) {
                function getApiPath(path) {
                    if(path) {
                        return serverOrigin + path;
                    }

                    return serverOrigin;
                }

                var auth = AsgardeoAuth.AsgardeoSPAClient.getInstance();

                var authConfig = {
                    signInRedirectURL: applicationDomain.replace(/\/+$/, '') + "/" + "myaccount",
                    signOutRedirectURL: applicationDomain.replace(/\/+$/, ''),
                    clientID: "MY_ACCOUNT",
                    baseUrl: getApiPath(),
                    responseMode: "form_post",
                    scope: ["openid SYSTEM"],
                    storage: "webWorker",
                    enablePKCE: true
                }

                if(isOrganizationManagementEnabled) {
                    authConfig.endpoints = {
                        authorizationEndpoint: getApiPath("/t/carbon.super/oauth2/authorize?ut=")
                    }
                }

                sessionStorage.setItem("auth_callback_url_my_account",
                    userAccessedPath.split(window.origin)[1]
                    ? userAccessedPath.split(window.origin)[1].replace(/\/+$/, '')
                    : null
                )

                auth.initialize(authConfig);
                auth.signIn();
            }
        </script>
    </body>
</html>
