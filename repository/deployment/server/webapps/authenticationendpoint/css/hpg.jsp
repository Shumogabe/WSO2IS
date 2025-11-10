<style>

@font-face {
    font-family: 'Open Sans';
    src:url('/fonts/opensans/OpenSans-Regular.eot?#iefix') format('embedded-opentype'),
    url('/fonts/opensans/OpenSans-Regular.woff') format('woff'),
    url('/fonts/opensans/OpenSans-Regular.ttf') format('truetype'),
    url('/fonts/opensans/OpenSans-Regular.svg#SFUFutura') format('svg');
    font-weight: normal;
}

* {
    font-family: 'Open Sans', sans-serif !important;
}
label{
    font-size: 12px !important;
}
.cookie-policy-message{
    font-size: 12px !important;
}
i.icon{
    font-family: 'Icons', serif !important;
}

.ui.segment, .ui.segments .segment {
    font-size: 1rem;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
    border-radius: 10px !important;
    border: none;
}

.segment{
    border-radius: 8px;
}
.button.primary{
    background-color: <%=getCustomValueProperty(request,"button-main-background-color")%> !important;
    color: <%=getCustomValueProperty(request,"button-main-text-color")%> !important;
    font-weight: bolder !important;
}

.button.secondary, .button{
    background-color: <%=getCustomValueProperty(request,"button-secondary-background-color")%> !important;
    color: <%=getCustomValueProperty(request,"button-secondary-text-color")%> !important;
}

body{
    background-image: url("<%=getCustomValueProperty(request,"page-background-image")%>") !important;
    background-attachment: fixed !important;
    background-position: center !important;
}

.product-title{
    color: <%=getCustomValueProperty(request,"title-color")%> !important;
}

input, .input{
    border-radius: 5px !important;
    /*border: 1px solid #d5b8ff !important;*/
}

button, .button{
    border-radius: 5px !important;
    box-shadow: none !important;
    /*border: 1px solid #d5b8ff !important;*/
}

.header{
    margin-top: -1px !important;
    font-weight: bolder !important;
    text-transform: uppercase;
}

.ui.header, .ui h1, .ui h2, .ui h3, .ui h4, .ui h5, .ui h6 {
    text-transform: uppercase;
    color: <%=getCustomValueProperty(request,"title-color")%> !important;
}

.ui.icon.button{
    /*box-shadow: 0px 0px 0px 0px rgba(0,0,0,.12),0px 1px 0.5px 1px rgba(0,0,0,.24) !important*/
    border: 1px solid #CE7A58 !important;
    height: 55px !important;
}
.ui.secondary.button{
    /*box-shadow: 0px 0px 0px 0px rgba(0,0,0,.12),0px 1px 0.5px 1px rgba(0,0,0,.24) !important*/
    border: 1px solid #CE7A58  !important;
    height: 45px !important;
    color: black !important;
}
.button{
    /*box-shadow: 0px 0px 0px 0px rgba(0,0,0,.12),0px 1px 0.5px 1px rgba(0,0,0,.24) !important*/
    border: 1px solid #CE7A58 !important;
    height: 45px !important;
}
button>i.icon{
    background-color: <%=getCustomValueProperty(request,"button-secondary-background-color")%> !important;
}

.usb-login::before {
    content: url("images/usb.svg") !important;
    width: 20px;
}
.sim-login::before {
    content: url("images/sim.svg") !important;
    width: 20px;
}
.email-login::before {
    content: url("images/totp.svg") !important;
    width: 20px;
    padding: 5px;
}

button:hover{
    opacity: 0.8 !important;
}

button>img{
    height: 33px !important;
    width: 33px !important;
    background-color: <%=getCustomValueProperty(request,"button-main-background-color")%> !important;
    padding: 6px;
    border-radius: 40% !important;
    margin: 1px;
}

.forgot-password{
    color: <%=getCustomValueProperty(request,"title-color")%> !important;
}
.forgot-password:hover{
    opacity: 0.7;
}
.register{
    color: <%=getCustomValueProperty(request,"title-color")%> !important;
}
.register:hover{
    opacity: 0.7;
}

.button{
    font-weight: lighter !important;
}

.error-msg{
    background-color: #fae3e3 !important;
}

.title-description{
    opacity: 0.8 !important;
}
</style>
