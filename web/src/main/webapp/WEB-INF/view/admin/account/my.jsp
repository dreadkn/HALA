<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0 text-dark">내 정보 관리</h1>
                </div>
                <%--<div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">내정보관리</li>
                    </ol>
                </div>--%>
            </div>
        </div>
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div id="vue-app" class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <div class="card card-light">
                        <div class="card-header">
                            <h3 class="card-title">내 정보 수정</h3>
                        </div>
                        <div class="card-body">
                            <div class="form-row">
                                <div class="form-group col-lg-6">
                                    <label for="userId">아이디</label>
                                    <input type="text" id="userId" name="userId" v-model="user.userId" required="required" class="form-control" disabled="disabled">
                                    <div id="userIdError" class="invalid-feedback"></div>
                                </div>
                                <div class="form-group col-lg-6">
                                    <label for="name">이름</label>
                                    <input type="text" id="name" name="name" v-model="user.name" required="required" class="form-control">
                                    <div id="nameError" class="invalid-feedback"></div>
                                </div>
                                <div class="form-group col-lg-6">
                                    <label for="name">전화번호</label>
                                    <input type="text" id="phone" name="phone" v-model="user.phone" class="form-control">
                                    <div id="phoneError" class="invalid-feedback"></div>
                                </div>
                                <div class="form-group col-lg-6">
                                    <label for="name">이메일</label>
                                    <input type="text" id="email" name="email" v-model="user.email" class="form-control">
                                    <div id="emailError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <div class="row justify-content-end">
                                <div class="col-auto">
                                    <button type="button" class="btn btn-primary" @click="save">저장</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-md-6">
                    <div class="card card-light">
                        <div class="card-header">
                            <h3 class="card-title">비밀번호 변경</h3>
                        </div>
                        <div class="card-body">
                            <div class="form-row">
                                <div class="form-group col-12">
                                    <label for="userId">비밀번호</label>
                                    <input type="password" id="oldPassword" name="oldPassword" v-model="pass.oldPassword" required="required" class="form-control">
                                    <div id="oldPasswordError" class="invalid-feedback"></div>
                                </div>
                                <div class="form-group col-12">
                                    <label for="name">신규 비밀번호</label>
                                    <input type="password" id="newPassword" name="newPassword" v-model="pass.newPassword" required="required" class="form-control">
                                    <div id="newPasswordError" class="invalid-feedback"></div>
                                </div>
                                <div class="form-group col-12">
                                    <label for="name">비밀번호 확인</label>
                                    <input type="password" id="matchingPassword" name="matchingPassword" v-model="pass.matchingPassword" required="required" class="form-control">
                                    <div id="matchingPasswordError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <div class="row justify-content-end">
                                <div class="col-auto">
                                    <button type="button" class="btn btn-primary" @click="changePassword">비밀번호 변경</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- /.content -->

</div>

<script>
    // Root
    var vm = new Vue({
        el: '#vue-app',
        data: {
            user: {},
            pass: {
                oldPassword: '',
                newPassword: '',
                matchingPassword: ''
            }
        },
        mounted: function () {
            this.fetchMyDetail();
        },
        methods: {
            fetchMyDetail: function () {
                var self = this;
                jQuery.ajax(contextPath + '/admin/my', {
                    method: 'GET',
                    contentType: 'application/json'
                }).done(function (data) {
                    self.user = data;
                }).fail(function (data) {
                    errorToastr("사용자 정보 조회 중 오류가 발생하였습니다.");
                });
            },
            save: function () {
                var self = this;
                var callback = function (isConfirm) {
                    if (isConfirm) {
                        clearInvalid();
                        jQuery.ajax(contextPath + '/admin/my', {
                            method: 'PATCH',
                            contentType: 'application/json',
                            data: JSON.stringify(self.user)
                        }).done(function (data) {
                            alertSuccess("저장되었습니다.");
                        }).fail(function (data) {
                            displayErrors(data);
                        });
                    }
                }
                alertConfirm(callback, "내 정보를 저장 하시겠습니까?", null, "저장");
            },
            changePassword: function () {
                var self = this;
                var callback = function (isConfirm) {
                    if (isConfirm) {
                        clearInvalid();
                        jQuery.ajax(contextPath + '/admin/my/password', {
                            method: 'PATCH',
                            contentType: 'application/json',
                            data: JSON.stringify(self.pass)
                        }).done(function (data) {
                            alertSuccess("비밀번호가 변경 되었습니다.");
                        }).fail(function (data) {
                            displayErrors(data);
                        });
                    }
                }
                alertConfirm(callback, "비밀번호를 변경 하시겠습니까?", null, "변경");
            }
        }

    });

</script>
