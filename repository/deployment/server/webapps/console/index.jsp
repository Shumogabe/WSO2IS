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

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="static org.wso2.carbon.identity.core.util.IdentityUtil.getServerURL" %>
<%@ page import="static org.wso2.carbon.utils.multitenancy.MultitenantConstants.SUPER_TENANT_DOMAIN_NAME"%>
<%@ page import="org.owasp.encoder.Encode" %>

<script>
    var userAccessedPath = window.location.href;
    sessionStorage.setItem("userAccessedPath", userAccessedPath.split(window.origin)[1]);
</script>

<jsp:scriptlet>
    if(request.getParameter("code") != null && !request.getParameter("code").trim().isEmpty()) {request.getRequestDispatcher("/authenticate?code="+request.getParameter("code")+"&AuthenticatedIdPs="+request.getParameter("AuthenticatedIdPs")+"&session_state="+request.getParameter("session_state")).forward(request, response);}
</jsp:scriptlet>

<!DOCTYPE HTML>
<html>
    <head>
        <script src="/console/auth-spa-0.3.3.min.js"></script>
    </head>
    <body>
        <script>
            var userAccessedPath = window.location.href;
            var applicationDomain = window.location.origin;

            var serverOrigin = "<%=getServerURL("", true, true)%>";
            var authorizationCode = "<%=Encode.forHtml(request.getParameter("code"))%>" != "null"
                                        ? "<%=Encode.forHtml(request.getParameter("code"))%>"
                                        : null;
            var authSessionState = "<%=Encode.forHtml(request.getParameter("session_state"))%>" != "null"
                                        ? "<%=Encode.forHtml(request.getParameter("session_state"))%>"
                                        : null;

            if (!authorizationCode) {
                function getApiPath(path) {
                    if (path) {
                        return serverOrigin + path;
                    }

                    return serverOrigin;
                }

                var auth = AsgardeoAuth.AsgardeoSPAClient.getInstance();
                var orgPrefix = "o";

                /**
                 * Get the organization name.
                 *
                 * @returns {string}
                 */
                function getOrganizationName() {
                    const path = window.location.pathname;
                    const pathChunks = path.split("/");

                    const orgPrefixIndex = pathChunks.indexOf(orgPrefix);

                    if (orgPrefixIndex !== -1) {
                        return pathChunks[ orgPrefixIndex + 1 ];
                    }

                    return "";
                };

                /**
                 * Get the organization path.
                 *
                 * @returns {string}
                 */
                function getOrganizationPath() {
                    return getOrganizationName() !== ""
                        ? "/" + orgPrefix + "/" +  getOrganizationName()
                        : "";
                };

                var authConfig = {
                    signInRedirectURL: applicationDomain.replace(/\/+$/, '') + getOrganizationPath() + "/"
                        + "console",
                    signOutRedirectURL: applicationDomain.replace(/\/+$/, '') + getOrganizationPath(),
                    clientID: "CONSOLE",
                    baseUrl: getApiPath(),
                    responseMode: "form_post",
                    scope: ["openid SYSTEM profile"],
                    storage: "webWorker",
                    enablePKCE: true,
                    endpoints: {
                        authorizationEndpoint: getApiPath("/t/carbon.super/oauth2/authorize?ut=" + getOrganizationName())
                    }
                }

                var isSilentSignInDisabled = userAccessedPath.includes("disable_silent_sign_in");
                var isSignOutSuccess = userAccessedPath.includes("sign_out_success");

                if (isSignOutSuccess) {
                    window.location.href = userAccessedPath.split("?")[0];
                }

                if (isSilentSignInDisabled) {
                    window.location.href = applicationDomain + '/' + "console" + '/authenticate?disable_silent_sign_in=true&invite_user=true';
                } else {
                    auth.initialize(authConfig);
                    auth.signIn();
                }
            }
        </script>
    </body>
</html>
