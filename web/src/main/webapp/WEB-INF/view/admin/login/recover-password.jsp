<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<style>
    body.login-page {
        background-image: url("/resources/img/admin/background.jpg");
        background-size: cover;
    }
</style>

<html>
<body class="hold-transition login-page">
    <div id="vue-app" class="login-box">
        <div class="login-logo">
            <img src="<c:url value="/resources/img/admin/bi.png"/>"  alt="logo">
            <small class="text-nowrap">Content Management System</small>
        </div>
        <!-- /.login-logo -->
        <div class="card">
            <div class="card-body login-card-body">
                <p class="login-box-msg">비밀번호를 변경해주세요.</p>

                <form id="form" method="post">
                    <div class="input-group mb-3">
                        <input type="password" name="newPassword" class="form-control" placeholder="비밀번호" v-model="newPassword">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div id="newPasswordError" class="invalid-feedback"></div>
                    <div class="input-group mb-3">
                        <input type="password" name="matchingPassword" class="form-control" placeholder="비밀번호 확인" v-model="matchingPassword">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div id="matchingPasswordError" class="invalid-feedback"></div>
                    <div class="row">
                        <div class="col-12">
                            <button type="button" class="btn btn-primary btn-block" @click="save">비밀번호 변경</button>
                        </div>
                        <!-- /.col -->
                    </div>
                </form>


                <p class="mt-3 mb-1">
                    <a href="<c:url value="/admin/login"/>">Login</a>
                </p>
            </div>
            <!-- /.login-card-body -->
        </div>
    </div>
</body>
</html>

<script>
    var vm = new Vue({
        el: '#vue-app',
        data: {
            newPassword: '',
            matchingPassword: ''
        },
        methods: {
            save: function () {
                var self = this;
                axios.post('/user/recoverPassword', self._data).then(function (res) {
                    var callback = function(isConfirm) {
                        if (isConfirm) {
                            location.replace("/admin/login");
                        }
                    }
                    alertSuccessAfterCallback(callback, res.data.message, "확인");
                });
            }
        }
    });
</script>
<%--
<script>
    $('form').submit(function (e) {
        e.preventDefault();
        clearInvalid();
        var query = $('#form').serialize();
        jQuery.ajax(contextPath + '/user/recoverPassword', {
            method: 'POST',
            data: query
        }).done(function (data) {
            var callback = function(isConfirm) {
                if (isConfirm) {
                    location.href=contextPath + "/admin/login";
                }
            }
            alertSuccessAfterCallback(callback, data.message, "확인");
        })
        .fail(function (data) {
            displayErrors(data);
        })
    });
</script>
--%>

