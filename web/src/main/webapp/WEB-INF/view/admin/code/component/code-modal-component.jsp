<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="code-modal-form-component">
    <div class="modal fade" id="codeModal" tabindex="-1" role="dialog" aria-labelledby="codeModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="codeModalLabel">코드 {{isNew ? '등록' : '수정'}}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="form-row">
                            <div class="form-group col-12">
                                <legend class="col-form-label font-weight-bold">타입</legend>

                                <div v-for="(option, idx) in types" class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="type" :id="'type'+idx"
                                           :value="option.code" v-model="code.type" disabled>
                                    <label class="form-check-label" :for="'type'+idx">{{option.value}}</label>
                                </div>
                                <div id="typeError" class="invalid-feedback"></div>
                            </div>
                            <%--<div class="form-group col-6">
                                <label for="name">코드</label>
                                <input type="text" class="form-control" id="code" name="code" v-model="code.code">
                                <div id="codeError" class="invalid-feedback"></div>
                            </div>--%>
                            <div class="form-group col-12">
                                <label for="name">코드명 <small class="text-danger">*</small></label>
                                <input type="text" class="form-control" id="name" name="name" v-model="code.name">
                                <div id="nameError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-12">
                                <label for="name">설명</label>
                                <input type="text" class="form-control" id="desc" name="desc" v-model="code.desc">
                                <div id="descError" class="invalid-feedback"></div>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <div class="col-auto ml-auto">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
<%--                        <auth:authorize method="C,U">--%>
                        <button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}
                        </button>
<%--                        </auth:authorize>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>

<script>
    var codeModalFormComponent = {
        template: '#code-modal-form-component',
        mixins: [mixinForm],
        props: ["types", "type"],
        data: function () {
            return {
                id: null,
                code: {
                    id: null,
                    type: type,
                    code: null,
                    name: null,
                    desc: null
                }
            }
        },
        methods: {
            save: function () {
                var self = this;
                var url = contextPath + "/admin/codes";
                if (this.isUpdate) {
                    url += "/" + this.code.id;
                }

                jQuery.ajax(url, {
                    method: self.isUpdate ? 'PUT' : 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(self.code)
                }).done(function (data) {
                    var callback = function (isConfirm) {
                        location.reload();
                    }
                    $('#codeModal').modal('hide');
                    self.isUpdate ? alertUpdated() : alertSuccessAfterCallback(callback, "등록되었습니다!");
                }).fail(function (data) {
                    displayErrors(data);
                });
            },
            clearModalForm: function () {
                this.id = null;
                this.code = {
                    id: null,
                    type: 'STATION',
                    code: null,
                    name: null,
                    desc: null
                };
                clearInvalid();
            },
            openDetail: function (data) {
                this.code = data;
                this.code.type = data.type.code;
                this.id = data.id;
                $('#codeModal').modal('show');
            }
        }
    }

</script>









