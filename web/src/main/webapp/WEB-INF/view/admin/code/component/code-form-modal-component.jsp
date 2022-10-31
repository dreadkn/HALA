<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="code-form-component">
    <div class="modal fade" id="codeModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="codeModalLabel">코드 {{isUpdate ? '수정' : '등록'}}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <%--<div class="form-group">
                            <label for="name">코드</label>
                            <input type="text" class="form-control" id="code" name="code" v-model="data.code"
                                   placeholder="코드를 입력해주세요.">
                            <div id="codeError" class="invalid-feedback"></div>
                        </div>--%>
                        <div class="form-group">
                            <label for="name">코드명</label>
                            <input type="text" class="form-control" id="name" name="name" v-model="data.name"
                                   placeholder="코드명을 입력해주세요." @keyup.enter="save">
                            <div id="nameError" class="invalid-feedback"></div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <div class="col-auto" v-if="data.id">
                        <auth:authorize method="D">
                        <button type="button" class="btn btn-danger" @click="deleteCode">삭제</button>
                        </auth:authorize>
                    </div>
                    <div class="col-auto ml-auto">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <auth:authorize method="C,U">
                        <button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button>
                        </auth:authorize>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>

<script>
    var refreshCallback;
    var codeFormComponent = {
        template: '#code-form-component',
        // props: ["privileges", "roles"],
        data: function () {
            return {
                data: {
                    id: null,
                    code: '',
                    name: '',
                    parentId: null
                }
            }
        },
        computed: {
            isUpdate: function () {
                return this.data.id != null && this.data.id != '';
            }
        },
        watch: {

        },
        methods: {
            save: function () {
                var self = this;
                jQuery.ajax(contextPath + '/admin/system/codes', {
                    method: self.isUpdate ? 'PUT' : 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(self.data),
                    dataType: 'json'
                }).done(function (data) {
                    refreshCallback();
                    $('#codeModal').modal('hide')
                    alertSuccess("저장되었습니다.");
                }).fail(function (data) {
                    displayErrors(data);
                });
            },
            deleteCode: function () {
                var self = this;
                var callback = function (isConfirm) {
                    if (isConfirm) {
                        jQuery.ajax(contextPath + "/admin/system/codes/" + self.data.id, {
                            method: 'DELETE',
                            contentType: 'application/json'
                        })
                        .done(function (data) {
                            refreshCallback();
                            $('#codeModal').modal('hide')
                            alertSuccess("삭제되었습니다.")
                        })
                        .fail(function (data) {
                            errorToastr("메뉴 목록 삭제중 오류가 발생하였습니다.");
                        })
                    }
                }
                deleteConfirm(callback);
            },
            clearModalForm: function () {
                this.data = {
                    id: null,
                    code: '',
                    name: '',
                    parentId: null
                };
                clearInvalid();
            },
            createModal: function (parentId, type, callback) {
                refreshCallback = callback;
                this.data.parentId = parentId;
                this.data.type = type;
                $('#codeModal').modal('show');
            },
            openModal: function (data, callback) {
                refreshCallback = callback;
                this.data = $.extend(true, {}, data);
                this.data.type = data.type.code;
                $('#codeModal').modal('show');
            }
        }
    };

    $(function () {
        $('#codeModal').on('hidden.bs.modal', function (e) {
            vm.$refs.codeModal.clearModalForm();
        })

        $('#codeModal').on('shown.bs.modal', function (e) {
            $('#name').focus();
        });
    })
</script>
