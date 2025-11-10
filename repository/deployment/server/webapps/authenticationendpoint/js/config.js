var FORGOT_PASSWORD = "https://reg-union.vnpt.vn/reset/confirm";
const CAS_MAIL_VNPT= "https://id.vnpt.com.vn/cas/login?service=";
const CAS_SERVICE = window.location.origin + "/authenticationendpoint/cas-login.jsp";

window.onload = function() {
    if(location.hostname == "idp-onegov.vnpt.vn"){
        FORGOT_PASSWORD = "https://user-portal-onegov.vnpt.vn/reset/confirm";
    }    
};