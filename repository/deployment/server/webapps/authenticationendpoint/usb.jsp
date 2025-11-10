<%@ page import="org.owasp.encoder.Encode" %>
    <%@ page import="org.wso2.carbon.identity.mgt.endpoint.util.IdentityManagementEndpointUtil" %>
        <%@ page import="java.io.File" %>
            <%@ page import="org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils" %>
                <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                    <%@ taglib prefix="layout" uri="org.wso2.identity.apps.taglibs.layout.controller" %>
                        <%@ page import="org.owasp.encoder.Encode" %>
                            <%-- Localization --%>
                                <%@ include file="includes/localize.jsp" %>

                                    <%-- Include tenant context --%>
                                        <jsp:directive.include file="includes/init-url.jsp" />

                                        <%-- Branding Preferences --%>
                                            <jsp:directive.include file="includes/branding-preferences.jsp" />


                                            <%-- Data for the layout from the page --%>
                                                <% layoutData.put("containerSize", "medium" ); %>


                                                    <html lang="en-US">

                                                    <head>
                                                        <%-- header --%>
                                                            <% File headerFile=new
                                                                File(getServletContext().getRealPath("extensions/header.jsp"));
                                                                if (headerFile.exists()) { %>
                                                                <jsp:include page="extensions/header.jsp" />
                                                                <% } else { %>
                                                                    <jsp:include page="includes/header.jsp" />
                                                                    <% } %>
                                                                        <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
                                                    </head>

                                                    <body class="login-portal layout sms-otp-portal-layout">
                                                        <layout:main layoutName="<%= layout %>"
                                                            layoutFileRelativePath="<%= layoutFileRelativePath %>"
                                                            data="<%= layoutData %>">
                                                            <layout:component componentName="ProductHeader">
                                                                <%-- product-title --%>
                                                                    <% String
                                                                        productTitleFilePath="extensions/product-title.jsp"
                                                                        ; if
                                                                        (StringUtils.isNotBlank(customLayoutFileRelativeBasePath))
                                                                        {
                                                                        productTitleFilePath=customLayoutFileRelativeBasePath
                                                                        + "/product-title.jsp" ; } if (!new
                                                                        File(getServletContext().getRealPath(productTitleFilePath)).exists())
                                                                        {
                                                                        productTitleFilePath="includes/product-title.jsp"
                                                                        ; } %>
                                                                        <jsp:include
                                                                            page="<%= productTitleFilePath %>" />
                                                            </layout:component>
                                                            <layout:component componentName="MainSection">
                                                                <div class="ui segment">
                                                                    <h4>USB ký số</h4>
                                                                    <p class="center">
                                                                        Tải công cụ ký điện tử trên Windows
                                                                        <a href="https://dangkyid.monre.gov.vn/statics/plugin/VGCASignServiceSetup.msi"
                                                                            target="_blank" class="main"> tại đây</a>
                                                                        hoặc MacOS <a
                                                                            href="https://dangkyid.monre.gov.vn/statics/plugin/VGCA_VCTKInstaller.pkg"
                                                                            target="_blank" class="main"> tại đây</a>
                                                                    </p>
                                                                    <div class="ui divider hidden"></div>
                                                                    <div class="error-msg"></div>
                                                                    <div class="ui divider hidden"></div>
                                                                    <div class="segment-form">
                                                                        <form class="ui large form" id="usb_login_form"
                                                                            name="pin_form" action="../commonauth"
                                                                            method="POST">
                                                                            <input id="serial" name="serial"
                                                                                type="hidden">
                                                                            <input id="signedData" name="signedData"
                                                                                type="hidden">
                                                                            <input id="dataBeforeSign"
                                                                                name="dataBeforeSign" type="hidden">
                                                                            <input id="sessionDataKey"
                                                                                value="<%=request.getParameter("
                                                                                sessionDataKey")%>"
                                                                            name="sessionDataKey" hidden>
                                                                            <div class="align-center buttons">
                                                                                <input type="button" style="width: 100%"
                                                                                    name="authenticate"
                                                                                    id="usb_login_button"
                                                                                    value="<%=IdentityManagementEndpointUtil.i18n(resourceBundle, "
                                                                                    authenticate.button")%>" class="ui
                                                                                primary button"/>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                    <div style="display: flex; justify-content: center"
                                                                        id="register-block">
                                                                        <div style="margin-top: 20px">
                                                                            Bạn chưa có tài khoản?
                                                                            <a class="register"
                                                                                href="<%=getCustomValueProperty(request,"
                                                                                register-url")%>">Đăng ký</a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </layout:component>
                                                            <layout:component componentName="ProductFooter">
                                                                <% String
                                                                    productFooterFilePath="extensions/product-footer.jsp"
                                                                    ; if
                                                                    (StringUtils.isNotBlank(customLayoutFileRelativeBasePath))
                                                                    {
                                                                    productFooterFilePath=customLayoutFileRelativeBasePath
                                                                    + "/product-footer.jsp" ; } if (!new
                                                                    File(getServletContext().getRealPath(productFooterFilePath)).exists())
                                                                    {
                                                                    productFooterFilePath="includes/product-footer.jsp"
                                                                    ; } %>
                                                                    <jsp:include page="<%= productFooterFilePath %>" />
                                                            </layout:component>
                                                        </layout:main>

                                                        <%-- footer --%>
                                                            <% File footerFile=new
                                                                File(getServletContext().getRealPath("extensions/footer.jsp"));
                                                                if (footerFile.exists()) { %>
                                                                <jsp:include page="extensions/footer.jsp" />
                                                                <% } else { %>
                                                                    <jsp:include page="includes/footer.jsp" />
                                                                    <% } %>
                                                    </body>

                                                    </html>


                                                    <%--<script type="text/javascript" src="js/base64.js"></script>--%>
                                                        <%--<script type="text/javascript" src="js/vgcaplugin.js">
                                                            </script>--%>

                                                            <script type="text/javascript">
                                                                function SignJSONCallBack(sender, rv) {
                                                                    var received_msg = JSON.parse(rv);
                                                                    if (received_msg.Status == 0) {
                                                                        document.getElementById("signedData").value = received_msg.Signature;
                                                                        exc_verify_json();
                                                                    } else {
                                                                        alert("Ký số không thành công:" + received_msg.Status + ":" + received_msg.Error);
                                                                    }
                                                                }
                                                                function VerifyJSONCallBack(rv) {
                                                                    var received_msg = JSON.parse(rv);
                                                                    if (received_msg.Status == 0) {
                                                                        console.log(received_msg)
                                                                        document.getElementById("serial").value = received_msg.SigningCertInfo.SerialNumber;
                                                                        document.getElementById("dataBeforeSign").value = received_msg.JsonContent;
                                                                        document.getElementById("usb_login_form").submit();
                                                                    } else {
                                                                        alert("Error:" + received_msg.Status + ":" + received_msg.Message);
                                                                    }
                                                                }
                                                                function exc_sign_json(sender) {
                                                                    var prms = {};
                                                                    prms["JsonContent"] = "<%=Encode.forHtmlAttribute(request.getParameter("sessionDataKey"))%>";
                                                                    prms["DetachPayload"] = "false";
                                                                    prms["IsPss"] = "true";
                                                                    var json_prms = JSON.stringify(prms);
                                                                    vgca_sign_json(sender, json_prms, SignJSONCallBack);
                                                                }

                                                                function exc_verify_json() {
                                                                    var content = document.getElementById("signedData").value;
                                                                    vgca_verify_json(content, VerifyJSONCallBack);
                                                                }
                                                            </script>


                                                            <script>

                                                                function showUsbMessage(message) {
                                                                    document.querySelector('.error-msg').innerHTML = message;
                                                                }

                                                                function showErrorUSBByCode(CODE) {
                                                                    if (CODE.startsWith("USB_FAILURE_ERROR_CODE")) {
                                                                        showUsbMessage("Lỗi xác thực!");
                                                                        return;
                                                                    }
                                                                    if (CODE.startsWith("USB_NETWORK_ERROR_CODE")) {
                                                                        showUsbMessage("Không tìm thấy user theo serial! Vui lòng thử lại sau");
                                                                        return;
                                                                    }
                                                                    if (CODE.startsWith("USB_USER_NOT_EXIST_ERROR_CODE")) {
                                                                        showUsbMessage("Tài khoản không tồn tại trong hệ thống!");
                                                                        return;
                                                                    }
                                                                    if (CODE.startsWith("USB_USER_NOT_ACTIVE_ERROR_CODE")) {
                                                                        showUsbMessage("Tài khoản bị khoá!");
                                                                        return;
                                                                    }
                                                                    if (CODE.startsWith("USB_NETWORK_TIMEOUT_ERROR_CODE")) {
                                                                        showUsbMessage("Lỗi mạng!");
                                                                        return;
                                                                    }
                                                                    if (CODE.startsWith("USB_USER_NOT_FOUND_BY_SERIAL_ERROR_CODE")) {
                                                                        showUsbMessage("Không tìm thấy tài khoản theo serial!");
                                                                        return;
                                                                    }
                                                                    if (CODE.startsWith("USB_NOT_HAVE_USERNAME_OR_CERTIFICATE_ERROR_CODE")) {
                                                                        showUsbMessage("Không tìm thấy tài khoản theo serial!");
                                                                        return;
                                                                    }
                                                                    if (CODE.startsWith("USB_CERTIFICATE_VERIFICATION_FAILED_ERROR_CODE")) {
                                                                        showUsbMessage("Lỗi khi validation certificate!");
                                                                        return;
                                                                    }
                                                                }

                                                                let USB_ERROR_CODE = '<%=FrameworkUtils.getContextData(request).getProperty("CUS_CODE")%>';
                                                                showErrorUSBByCode(USB_ERROR_CODE);

                                                                document.getElementById("usb_login_button").addEventListener("click", function () {
                                                                    exc_sign_json();
                                                                })
                                                            </script>