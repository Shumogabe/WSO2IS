<%@ page import="java.util.Properties" %>
<%@ page import="java.io.*" %>
<%!
    public String getConfigProperty(String config, String rootPath) {
        String configFilePath = getServletContext().getRealPath(rootPath+"/properties.txt");
        String result = null;
        Properties properties = new Properties();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(
                new FileInputStream(configFilePath), StandardCharsets.UTF_8))) {
            properties.load(reader);
            result = properties.getProperty(config);
            if (result !=null )
            {
                result = result.trim();
            }
        } catch (IOException e) {
            // Xử lý nếu xảy ra lỗi khi đọc tệp cấu hình
            e.printStackTrace();
        }
        return result;
    }
%>
