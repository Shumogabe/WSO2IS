<%@ page import="com.google.gson.JsonElement" %>
<%@ page import="com.google.gson.JsonParser" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.context.AuthenticationContext" %>
<%@ page import="org.apache.commons.io.FileUtils" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="org.wso2.carbon.idp.mgt.IdentityProviderManager" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.framework.util.FrameworkUtils" %>
<%@ page import="org.wso2.carbon.base.ServerConfiguration" %>
<%@ page import="org.wso2.carbon.identity.core.util.IdentityCoreConstants" %>
<%!
    public String getCustomValueProperty(HttpServletRequest request,String key){
        String value = null;
        try {
            File file = new File("repository/deployment/server/webapps/authenticationendpoint/cus-property.json");
            String content = FileUtils.readFileToString(file, "UTF-8");
            value = JsonParser.parseString(content).getAsJsonObject().get(key).getAsString();
        }
        catch (Exception ignored){
        }
        return value==null?key:value;
    }

%>
