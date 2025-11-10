<html>
<head>
	<meta charset="UTF-8">
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<title>Hệ sinh thái công đoàn VNPT</title>

    <script type="text/javascript" src="js/jquery/jquery.2.1.1.min.js"></script>
    <script type="text/javascript" src="js/custom-cas.js"></script>
    <script src="js/config.js"></script>
</head>
<body>
    <form  action="../commonauth" method="post" id="loginCasForm" style="">
        <input type="hidden" id="CasAuthenticator" name="authenticator" value='CasAuthenticator'/>
        <input type="hidden" id="ticket" name="ticket" value=''/>
        <input type="hidden" id='service' name="service" value=''/>
        <input type="hidden" id='sessionDataKey' name="sessionDataKey" value=''/>
    </form>

	<div class="login-footer">	
		Bản quyền thuộc về Công đoàn VNPT
	</div>
    
</body>
<script>
    $(document).ready(function() {
        checkCasAuthenticator();
    });

    function checkCasAuthenticator(){
        let searchParams = new URLSearchParams(window.location.search);
        var ticket = searchParams.get("ticket");
        
        if(ticket != null){
            $('#ticket').val(ticket);
            $('#service').val(CAS_SERVICE);
            $('#sessionDataKey').val(sessionStorage.getItem("cd_sessionDataKey"));
            // alert($('#sessionDataKey').val());
            $("#loginCasForm").submit();
        }
    }

</script>
</html>	