<%--&lt;%&ndash;--%>
<%--  ~ Copyright (c) 2019-2023, WSO2 LLC. (https://www.wso2.com).--%>
<%--  ~--%>
<%--  ~ WSO2 LLC. licenses this file to you under the Apache License,--%>
<%--  ~ Version 2.0 (the "License"); you may not use this file except--%>
<%--  ~ in compliance with the License.--%>
<%--  ~ You may obtain a copy of the License at--%>
<%--  ~--%>
<%--  ~    http://www.apache.org/licenses/LICENSE-2.0--%>
<%--  ~--%>
<%--  ~ Unless required by applicable law or agreed to in writing,--%>
<%--  ~ software distributed under the License is distributed on an--%>
<%--  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY--%>
<%--  ~ KIND, either express or implied.  See the License for the--%>
<%--  ~ specific language governing permissions and limitations--%>
<%--  ~ under the License.--%>
<%--&ndash;%&gt;--%>

<%--<%@ page import="org.apache.commons.text.StringEscapeUtils" %>--%>
<%--<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.AuthenticationEndpointUtil" %>--%>

<%--&lt;%&ndash; Include tenant context &ndash;%&gt;--%>
<%--<jsp:directive.include file="init-url.jsp"/>--%>

<%--&lt;%&ndash; Branding Preferences &ndash;%&gt;--%>
<%--<jsp:directive.include file="branding-preferences.jsp"/>--%>

<%--&lt;%&ndash; Localization &ndash;%&gt;--%>
<%--<jsp:directive.include file="localize.jsp" />--%>

<%--<script src="libs/jquery_3.6.0/jquery-3.6.0.min.js"></script>--%>


<%--<link rel="preconnect" href="https://fonts.googleapis.com">--%>
<%--<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>--%>
<%--<link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@100..900&display=swap" rel="stylesheet">--%>

<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%--<div class="product-title" data-testid="product-title" style="width: 100%; text-align: center; margin: 100px 0">--%>
<%--    <div class="theme-icon inline auto transparent product-logo portal-logo">--%>
<%--        <img src="<%=getCustomValueProperty(request,"title-logo")%>" id="product-logo" alt="<%=getCustomValueProperty(request,"title-logo-alt")%>" style="height: 200px; width: 200px"/>--%>
<%--    </div>--%>
<%--    <div>--%>
<%--        <div style="font-size: 19px;font-weight: 600;text-transform: uppercase; text-align: center"><%=getCustomValueProperty(request,"title-name")%></div>--%>
<%--        <div style="font-size: 16px;font-style: italic;"><%=getCustomValueProperty(request,"title-description")%></div>--%>
<%--    </div>--%>
<%--</div>--%>


<%--<style>--%>
<%--    * {--%>
<%--        font-family: 'Roboto Slab', sans-serif !important;--%>
<%--    }--%>
<%--    i.icon{--%>
<%--        font-family: 'Icons', serif !important;--%>
<%--    }--%>

<%--    .ui.segment, .ui.segments .segment {--%>
<%--        font-size: 1rem;--%>
<%--        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);--%>
<%--        border-radius: 10px !important;--%>
<%--        border: none;--%>
<%--    }--%>

<%--    .segment{--%>
<%--        border-radius: 8px;--%>
<%--    }--%>

<%--    .ui .segment{--%>

<%--    }--%>

<%--    .button{--%>
<%--        background-color: <%=getCustomValueProperty(request,"button-main-background-color")%> !important;--%>
<%--        color: <%=getCustomValueProperty(request,"button-main-text-color")%> !important;--%>
<%--    }--%>

<%--    .button.secondary{--%>
<%--        background-color: <%=getCustomValueProperty(request,"button-secondary-background-color")%> !important;--%>
<%--        color: <%=getCustomValueProperty(request,"button-secondary-text-color")%> !important;--%>
<%--    }--%>

<%--    body{--%>
<%--        background-image: url("<%=getCustomValueProperty(request,"page-background-image")%>") !important;--%>
<%--        background-attachment: fixed !important;--%>
<%--        background-position: center !important;--%>
<%--    }--%>

<%--    .product-title{--%>
<%--        color: <%=getCustomValueProperty(request,"title-color")%> !important;--%>
<%--    }--%>


<%--</style>--%>





<%--
  ~ Copyright (c) 2019-2023, WSO2 LLC. (https://www.wso2.com).
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

<%@ page import="org.apache.commons.text.StringEscapeUtils" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.AuthenticationEndpointUtil" %>

<%-- Include tenant context --%>
<jsp:directive.include file="init-url.jsp"/>
<%-- Branding Preferences --%>
<jsp:directive.include file="branding-preferences.jsp"/>

<%-- Localization --%>
<jsp:directive.include file="localize.jsp" />

<script src="libs/jquery_3.6.0/jquery-3.6.0.min.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script type="text/javascript" src="js/base64.js"></script>
<script type="text/javascript" src="js/vgcaplugin.js"></script>
<script type="text/javascript" src="js/qrcode.js"></script>

<link rel="icon" type="image/x-icon" href="<%=getCustomValueProperty(request,"page-favicon")%>">


<div class="product-title" data-testid="product-title" style="width: 100%; text-align: center; margin: 30px 0 0 0; line-height:26px;">
    <div class="theme-icon inline auto transparent product-logo portal-logo">
        <img src="<%=getCustomValueProperty(request,"title-logo")%>" id="product-logo" alt="<%=getCustomValueProperty(request,"title-logo-alt")%>" style="height: 100%;"/>
    </div>
    <div id="title-text" style="margin: 0 -100%">
        <div style="font-size: 19px;font-weight: bolder;text-transform: uppercase; text-align: center" class="title-name"><%=getCustomValueProperty(request,"title-name")%></div>
        <div style="font-size: 16px;font-style: italic;" class="title-description"><%=getCustomValueProperty(request,"title-description")%></div>
    </div>
</div>



<div id="custom_loading">
    <p class="loader custom_loading"></p>
</div>
<style>
    #custom_loading{
        position: fixed;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        background-color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        opacity: 0.8;
    }
    .custom_loading {
        width: 64px;
        height: 64px;
        position: relative;
        background-image:
                linear-gradient(#002aff 16px, transparent 0) ,
                linear-gradient(#ff0000 16px, transparent 0) ,
                linear-gradient(#ff0000 16px, transparent 0) ,
                linear-gradient(#002aff 16px, transparent 0);
        background-repeat: no-repeat;
        background-size: 16px 16px;
        background-position: left top , left bottom , right top , right bottom;
        animation: rotate 1s linear infinite;
    }
    @keyframes rotate {
        0% {
            width: 64px;
            height: 64px;
            transform: rotate(0deg)
        }
        50% {
            width: 30px;
            height: 30px;
            transform: rotate(180deg)
        }
        100% {
            width: 64px;
            height: 64px;
            transform: rotate(360deg)
        }
    }
</style>

<script>
    document.addEventListener("DOMContentLoaded", function(){
        document.getElementById("custom_loading").style.display = "none";
    });
    window.addEventListener('beforeunload', (event) => {
        document.getElementById("custom_loading").style.display = "flex";
    });
</script>

<%@include file="../css/global.jsp"%>
