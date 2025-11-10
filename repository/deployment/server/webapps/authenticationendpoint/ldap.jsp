
<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.util.IdentityManagementEndpointUtil" %>
<%@ page import="java.io.File" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="layout" uri="org.wso2.identity.apps.taglibs.layout.controller" %>

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
      <h4>Đăng nhập bằng email</h4>
      </p>
      <div class="ui divider hidden"></div>
      <div class="error-msg">Vui lòng không nhập hậu tố email: <b>@monre.gov.vn</b></div>
      <div class="ui divider hidden"></div>
      <div class="segment-form">
        <form class="ui large form" id="usb_login_form" name="pin_form" action="../commonauth" method="POST">
          <div class="field">
            <div class="ui fluid left icon input">
              <input type="text" name="usernameLdap" placeholder="Nhập địa chỉ email ..." required>
              <i aria-hidden="true" class="user icon"></i>
            </div>
          </div>


          <div class="field">
            <div class="ui fluid left icon input addon-wrapper">
              <input type="password" name="passwordLdap" id="passwordLdap" autocomplete="off" required placeholder="Nhập mật khẩu ..." style="padding-right: 2.3em !important;">
              <i aria-hidden="true" class="lock icon"></i>
              <i id="passwordUnmaskIcon" class="eye icon mr-0" style="margin: 0 auto; right: 0; pointer-events: auto; cursor: pointer;"></i>
            </div>
          </div>

          <input id="sessionDataKey" value="<%=request.getParameter("sessionDataKey")%>" name="sessionDataKey" hidden>
          <div class="align-center buttons">
            <input style="width: 100%" type="submit" name="authenticate" value="<%=IdentityManagementEndpointUtil.i18n(resourceBundle, "authenticate.button")%>" class="ui primary button"/>
          </div>

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




<script>

  function showHpgUsbMessage(message) {
    document.querySelector('.error-msg').innerHTML=message;
  }

  function showErrorUSBByCode(CODE) {
    if (CODE.startsWith("NOT_HAVE_USER")) {
      showHpgUsbMessage("Không tồn tại tài khoản có chứa email mà bạn đăng nhập. Vui lòng đăng ký tài khoản để sử dụng dịch vụ!");
    }
    else if (CODE.startsWith("LDAP_AUTHENTICATION_FAILED")) {
      showHpgUsbMessage("Thông tin tài khoản không chính xác!");
    }
    else if (CODE.startsWith("AUTHENTICATION_FAILED")) {
      showHpgUsbMessage("Thông tin tài khoản không chính xác!");
    }
  }

  let USB_ERROR_CODE = '<%=FrameworkUtils.getContextData(request).getProperty("CUS_CODE")%>';
  showErrorUSBByCode(USB_ERROR_CODE);

  document.getElementById("passwordUnmaskIcon").addEventListener("click", function(event) {

    if (document.getElementById("passwordLdap").getAttribute("type") === "password") {
      document.getElementById("passwordLdap").setAttribute("type", "text");
      document.getElementById("passwordUnmaskIcon").classList.add("slash");
    }
    else document.getElementById("passwordLdap").setAttribute("type", "password");
  })

</script>
