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
            <div class="ui divider hidden"></div>
            <div class="ui visible negative message" id="error-msg" style="display: none"></div>
            <div class="ui divider hidden"></div>
            <div class="segment-form">
                <div id="qrcode" style="display: flex; justify-content: center"></div>
                <div class="align-center buttons">
                        <%--                    <button type="button" style="width: 100%; margin: 11px 0" class="ui primary button">Other Way</button>--%>
                    <button type="button" style="width: 100%; margin: 11px 0" class="ui primary button" onclick="generateQRCode()">Tạo QR Code mới</button>
                    <form id="qr_code_login_form" action="../commonauth" method="POST">
                        <input id="sessionDataKey" value="<%=request.getParameter("sessionDataKey")%>" name="sessionDataKey" hidden>
                        <input id="qr_code" name="qr_code" hidden>
<%--                        <input type="submit" value="Submit">--%>
                    </form>
                </div>
            </div>
            <div style="display: flex; justify-content: center" id="register-block">
                <div style="margin-top: 20px">
                    Bạn chưa có tài khoản?
                    <a class="register" href="<%=getCustomValueProperty(request,"register-url")%>">Đăng ký</a>
                </div>
            </div>
        </div>
    </layout:component>
    <layout:component componentName="ProductFooter">
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
</html>


<script type="text/javascript">
    let content;
    let countCallAPI = 0;
    let qrcode;
    let isSubmit = true;
    function generateUUID() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            const r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    }

    function generateQRCode() {
        countCallAPI = 0;
        content = generateUUID();
        document.getElementById("qr_code").value = content;
        document.getElementById("qrcode").innerHTML = "";
        if (qrcode) qrcode.clear();

        qrcode = new QRCode("qrcode", {
            text: content,
            width: 170,
            height: 170,
            colorDark: "#000000",
            colorLight: "#ffffff",
            correctLevel: QRCode.CorrectLevel.H
        });
        document.querySelector("#qrcode > img").style.opacity = "1";
        console.log(content)
    }

    function checkValidQRCode() {
        countCallAPI++;
        $.ajax({
            url: "http://localhost:8081/api/qrcode/validate",
            type: "GET",
            data: {
                qrcode: content,
            },
            success: function(response) {
                if (isSubmit) {
                    // document.getElementById("qr_code_login_form").submit();
                    // isSubmit = false;
                }
            },
            error: function(xhr, status, error) {
            }
        });
    }

    function disableQRCode() {
        document.querySelector("#qrcode > img").style.opacity = "0.2";
    }


    setInterval(() => {
        if (countCallAPI < 20) {
            checkValidQRCode();
        } else {
            disableQRCode();
        }
    }, 2000)
    generateQRCode();
    let ERROR_CODE = '<%=FrameworkUtils.getContextData(request).getProperty("CUS_CODE")%>';
    showErrorUSBByCode(ERROR_CODE);

    function showUsbMessage(message) {
        document.querySelector('#error-msg').style.display="block";
        document.querySelector('#error-msg').innerHTML=message;
    }

    function showErrorUSBByCode(CODE) {
        if (CODE.startsWith("QR_CODE_NOT_FOUND_USERNAME")) {
            showUsbMessage("Không có username!");
            return;
        }
        if (CODE.startsWith("QR_CODE_NOT_FOUND_TENANT")) {
            showUsbMessage("Không có tenant!");
            return;
        }
        if (CODE.startsWith("QR_CODE_NOT_ACTIVE")) {
            showUsbMessage("QR code bị quá hạn");
            return;
        }
        if (CODE.startsWith("QR_CODE_ERROR")) {
            showUsbMessage("Lỗi xác thực!");
        }

    }

    // document.getElementById("qr_code_login_form").submit();

</script>
