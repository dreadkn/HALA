<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="modal-form-component">
    <div class="modal fade" id="accountModal" tabindex="-1" role="dialog" aria-labelledby="accountModalLabel" aria-hidden="true">
        <div class="modal-dialog modal modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="accountModalLabel">계정 등록</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="form-row">
                            <div class="form-group col-6">
                                <legend class="col-form-label font-weight-bold">권한</legend>
                                <select class="custom-select" v-model="data.type">
                                    <tags:enum-select code="AdminType" />
                                </select>
                            </div>

                            <div class="form-group col-6">
                                <legend class="col-form-label font-weight-bold">계정상태</legend>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enabled" id="enabledTrue" value="true" v-model="data.enabled">
                                    <label class="form-check-label" for="enabledTrue">정상</label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enabled" id="enabledFalse" value="false" v-model="data.enabled">
                                    <label class="form-check-label" for="enabledFalse">차단</label>
                                </div>
                                <div id="enabledError" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-6">
                                <label for="userId">아이디</label>
                                <input type="text" class="form-control" id="userId" name="userId" v-model="data.userId" :disabled="data.id" required>
                                <div id="userIdError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-6">
                                <label for="name">이름</label>
                                <input type="text" class="form-control" id="name" name="name" v-model="data.name" required>
                                <div id="nameError" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-6">
                                <label for="email">이메일</label>
                                <input type="email" class="form-control" id="email" name="email" v-model="data.email" required>
                                <div id="emailError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-6">
                                <label for="phone">전화번호</label>
                                <input type="text" class="form-control" id="phone" name="phone" v-model="data.phone" required>
                                <div id="phoneError" class="invalid-feedback"></div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <div class="col-auto" v-if="data.id">
                        <button type="button" class="btn btn-danger" @click="resetPassword">비밀번호 초기화</button>
                    </div>
                    <div class="col-auto ml-auto">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" @click="submit">{{isUpdate ? '저장' : '등록'}}</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>

<script>
    Vue.component("modal-form-component", {
        template: '#modal-form-component',
        data: function () {
            return {
                data: {
                    enabled: 'true',
                    userId: '',
                    name: '',
                    phone: '',
                    email: '',
                    type: 'NORMAL_ADMIN'
                }
            }
        },
        watch: {
            data: {
                deep: true,
                handler: function (val, oldVal) {
                    this.data.phone = val.phone.replace(/[^0-9]/g,"");
                }
            }
        },
        computed: {
            isUpdate: function () {
                return this.data.id != null && this.data.id != '';
            }
        },
        methods: {
            submit: function () {
                this.save();
            },
            save: function () {
                var self = this;
                var url = this.isUpdate ? "/admin/account/" + this.data.userId
                    : "/admin/account";

                jQuery.ajax(url, {
                    method: self.isUpdate ? 'PUT' : 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(self.data),
                    dataType: 'json'
                }).done(function (data) {
                    var callback = function (isConfirm) {
                        location.reload();
                    }
                    $('#accountModal').modal('hide');
                    self.isUpdate ? alertUpdated() : alertSuccessAfterCallback(callback, "등록되었습니다!", "초기 비밀번호는 입력하신 아이디와 동일합니다.");
                }).fail(function (data) {
                    displayErrors(data);
                });
            },
            resetPassword: function () {
                var self = this;
                var callback = function (isConfirm) {
                    if (isConfirm) {
                        jQuery.post(contextPath + "/admin/account/" + self.data.userId + "/reset")
                        .done(function (data) {
                            alertSuccess("비밀번호가 초기화 되었습니다.")
                        })
                        .fail(function (data) {
                            errorToastr("비밀번호 초기화중 오류가 발생하였습니다.");
                        })
                    }
                }

                alertConfirm(callback, "비밀번호를 초기화 하시겠습니까?", "이메일이 입력된 경우 비밀번호 변경 링크가 발송됩니다. 이메일이 존재하지 않을시 아이디와 동일한 비밀번호로 초기화 됩니다.", "초기화", "취소", "red");
            },
            clearModalForm: function () {
                this.data = {
                    enabled: 'true',
                    userId: '',
                    name: '',
                    phone: '',
                    email: '',
                    type: 'NORMAL_ADMIN'
                };
                clearInvalid();
            },
            openUserDetail: function (data) {
                this.data = data;
                this.data.type = data.roles[0].name.substr(5);
                $('#accountModal').modal('show');
            }
        }
    });

</script>
