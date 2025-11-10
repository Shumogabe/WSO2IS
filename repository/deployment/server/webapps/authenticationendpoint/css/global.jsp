<style>

    @font-face {
        font-family: 'Open Sans';
        src: url('fonts/opensans/OpenSans-Regular.eot?#iefix') format('embedded-opentype'),
        url('fonts/opensans/OpenSans-Regular.ttf') format('truetype'),
        url('fonts/opensans/OpenSans-Regular.svg#SFUFutura') format('svg');
        font-weight: normal;
    }

    * {
        font-family: 'Open Sans', sans-serif !important;
    }

    label {
        font-size: 12px !important;
    }

    .cookie-policy-message {
        font-size: 12px !important;
    }

    i.icon {
        font-family: 'Icons', serif !important;
    }

    .ui.segment, .ui.segments .segment {
        font-size: 1rem;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        border-radius: 10px !important;
        border: none;
    }

    .button.primary {
        font-weight: bolder !important;
        height: 45px !important;
        background-color: <%=getCustomValueProperty(request,"button-main-background-color")%> !important;
        color: <%=getCustomValueProperty(request,"button-main-text-color")%> !important;
        box-shadow: <%=getCustomValueProperty(request,"button-main-box-shadow")%> !important;
        border-radius: <%=getCustomValueProperty(request,"button-main-border-radius")%> !important;
        border: <%=getCustomValueProperty(request,"button-main-border")%> !important;

    }

    .button.secondary, .button {
        height: 45px !important;
        background-color: <%=getCustomValueProperty(request,"button-secondary-background-color")%> !important;
        color: <%=getCustomValueProperty(request,"button-secondary-text-color")%> !important;
        border-radius: <%=getCustomValueProperty(request,"button-secondary-border-radius")%> !important;
        box-shadow: <%=getCustomValueProperty(request,"button-secondary-box-shadow")%> !important;
        border: <%=getCustomValueProperty(request,"button-main-border")%> !important;
    }

    button > i.icon {
        background-color: <%=getCustomValueProperty(request,"button-secondary-background-color")%> !important;
    }

    body {
        background-image: url("<%=getCustomValueProperty(request,"page-background-image")%>") !important;
        background-attachment: fixed !important;
        background-position: center !important;
    }

    .product-title {
        color: <%=getCustomValueProperty(request,"title-color")%> !important;
    }

    input, .input {
        border-radius: <%=getCustomValueProperty(request,"button-main-border-radius")%> !important;
    }

    .header {
        margin-top: -1px !important;
        font-weight: bolder !important;
        text-transform: uppercase;
    }

    .ui.header, .ui h1, .ui h2, .ui h3, .ui h4, .ui h5, .ui h6 {
        text-transform: uppercase;
        color: <%=getCustomValueProperty(request,"title-color")%> !important;
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

    button:hover {
        opacity: 0.8 !important;
    }

    button > img {
        height: 33px !important;
        width: 33px !important;
        background-color: <%=getCustomValueProperty(request,"button-main-background-color")%> !important;
        padding: 6px;
        border-radius: 45%;
    }

    .forgot-password {
        color: <%=getCustomValueProperty(request,"title-color")%> !important;
    }

    .forgot-password:hover {
        opacity: 0.7;
    }

    .register {
        color: <%=getCustomValueProperty(request,"title-color")%> !important;
    }

    .register:hover {
        opacity: 0.7;
    }

    .error-msg {
        background-color: #fae3e3 !important;
        border-radius: 10px !important;
    }

    .title-description {
        opacity: 0.8 !important;
    }

    span:has(img){
        background-color: <%=getCustomValueProperty(request,"button-main-background-color")%> !important;
    }

    @media only screen and (max-width: 768px) {
        #title-text {
            margin: 0 0 0 0 !important;
        }
    }

    @media only screen and (max-width: 768px) {
        #register-block{
            display: none !important;
        }
    }

    input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
        -webkit-appearance: none !important;
        margin: 0 !important;
    }

    input[type=number] {
        -moz-appearance: textfield !important;
    }

</style>
