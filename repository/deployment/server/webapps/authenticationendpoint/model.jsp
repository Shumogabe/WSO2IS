<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div id="myModal" class="modal">
    <div class="modal-content">
        <span id="modal-content-close" class="modal-content-close close" onclick="hideModal()">&times;</span>
        <h2 class="modal-content-title">Thông báo</h2>
        <p class="modal-content-message" id="modal-content-message"></p>
        <button id="btn-submit-error" class="ui primary fluid large button" onclick="hideModal()">Đóng</button>
    </div>
</div>

<script>

    function hideModal() {
        document.getElementById("myModal").style.display = "none";
    }
    function showModal() {
        let type =  localStorage.getItem("type");
        localStorage.removeItem("type");
        if(type==="face_fingerprint"){
            document.getElementById("modal-content-message").innerText="Tài khoản của bạn đã đổi Tên đăng nhập hoặc Mật khẩu. Vui lòng thực hiện đăng ký lại [Vân tay/ khuôn mặt]";
            document.getElementById("myModal").style.display = "block";
        }
    }

    if(window.location.href.indexOf("authFailure=true") !== -1) {
        showModal();
    }

</script>

<style>
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.5);
        transition: opacity 0.3s ease;
    }
    .modal-content {
        background-color: #fff;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 500px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        animation: slide-down 0.3s ease-out;
        border-radius: 10px;
    }
    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
    }
    .close:hover,
    .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }
    @keyframes slide-down {
        from {
            transform: translateY(-50px);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }
</style>
