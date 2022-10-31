<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="resource-modal-form-component">
    <div class="modal fade" id="resourceModalForm" data-backdrop="static" data-keyboard="true" tabindex="-1"
         role="dialog" aria-labelledby="modalFormLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalFormLabel">리소스 {{isUpdate ? '수정' : '등록'}}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="form-row">
                            <div class="form-group col-4">
                                <label for="name">적용순서</label>
                                <input type="number" class="form-control" id="sortOrder" name="sortOrder"
                                       v-model="data.sortOrder">
                                <div id="sortOrderError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-4">
                                <label for="type">타입</label>
                                <select class="custom-select form-control" id="type" name="type" v-model="data.type">
                                    <option value="url">url</option>
                                    <option value="method" disabled>method</option>
                                    <option value="pointcut" disabled>pointcut</option>
                                </select>
                            </div>
                            <div class="form-group col-4">
                                <label for="methodType">메소드타입</label>
                                <select class="custom-select form-control" id="methodType" name="methodType"
                                        v-model="data.methodType">
                                    <option value="ALL">ALL</option>
                                    <option value="GET">GET</option>
                                    <option value="POST">POST</option>
                                    <option value="PUT">PUT</option>
                                    <option value="PATCH">PATCH</option>
                                    <option value="DELETE">DELETE</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12">
                                <label for="name">리소스명</label>
                                <input type="text" class="form-control" id="name" name="name" v-model="data.name">
                                <div id="nameError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-12">
                                <label for="pattern">패턴</label>
                                <input type="text" class="form-control" id="pattern" name="pattern"
                                       v-model="data.pattern">
                                <div id="patternError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-12">
                                <label for="description">설명</label>
                                <textarea type="text" class="form-control" id="description" name="description"
                                          v-model="data.description"></textarea>
                                <div id="descriptionError" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12">
                                <label>권한 선택</label>
                                <select class="form-control select2" id="privileges" name="privileges"
                                        multiple="multiple"
                                        v-model="data.authorities" v-select2 style="width: 100%;">
                                </select>
                                <div id="privilegesError" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <div class="col-auto" v-if="data.id">
                        <auth:authorize method="D">
                        <button type="button" class="btn btn-danger" @click="deleteResource">삭제</button>
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
    var resourceModalFormComponent = {
        template: '#resource-modal-form-component',
        props: ["privileges", "roles"],
        data: function () {
            return {
                data: {
                    type: 'url',
                    methodType: 'ALL',
                    name: '',
                    pattern: '',
                    description: '',
                    sortOrder: '',
                    authorities: []
                },
                authorities: [
                    {id: 'IS_AUTHENTICATED_FULLY', text: 'IS_AUTHENTICATED_FULLY (로그인 사용자)'},
                    {id: 'IS_AUTHENTICATED_REMEMBERED', text: 'IS_AUTHENTICATED_REMEMBERED (리멤버미 사용자)'},
                    {id: 'IS_AUTHENTICATED_ANONYMOUSLY', text: 'IS_AUTHENTICATED_ANONYMOUSLY (익명사용자)'},
                    {id: 'CHANGE_PASSWORD_PRIVILEGE', text: 'CHANGE_PASSWORD_PRIVILEGE (비밀번호 변경 임시)'}
                ]
            }
        },
        computed: {
            isUpdate: function () {
                return this.data.id != null && this.data.id != '';
            }
        },
        watch: {
            privileges: function () {
                this.authorities.push({
                    text: '권한', children: this.privileges.map(function (o) {
                        var text = o.desc != null && o.desc != '' ? o.name + " (" + o.desc + ")" : o.name;
                        return {id: o.name, text: text};
                    })
                })
                $('#privileges').html('').select2({
                    theme: 'bootstrap4',
                    closeOnSelect: false,
                    data: this.authorities
                });
            },
            roles: function () {
                this.authorities.push({
                    text: '역할', children: this.roles.map(function (o) {
                        var text = o.desc != null && o.desc != '' ? o.name + " (" + o.desc + ")" : o.name;
                        return {id: o.name, text: text};
                    })
                });
                $('#privileges').html('').select2({
                    theme: 'bootstrap4',
                    closeOnSelect: false,
                    data: this.authorities
                });
            }
        },
        methods: {
            save: function () {
                var self = this;
                jQuery.ajax(contextPath + '/admin/system/resources', {
                    method: self.isUpdate ? 'PUT' : 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(self.data),
                    dataType: 'json'
                }).done(function (data) {
                    vm.fetch();
                    $('#resourceModalForm').modal('hide')
                    alertSuccess("저장되었습니다.");
                }).fail(function (data) {
                    displayErrors(data);
                });
            },
            deleteResource: function () {
                var self = this;
                var callback = function (isConfirm) {
                    if (isConfirm) {
                        jQuery.ajax(contextPath + "/admin/system/resources/" + self.data.id, {
                            method: 'DELETE',
                            contentType: 'application/json'
                        })
                        .done(function (data) {
                            vm.fetch();
                            $('#resourceModalForm').modal('hide')
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
                    type: 'url',
                    methodType: 'ALL',
                    name: '',
                    pattern: '',
                    description: '',
                    sortOrder: '',
                    authorities: []
                };
                clearInvalid();
            },
            createModal: function (parentId, type, callback) {
                refreshCallback = callback;
                this.data.parentId = parentId;
                this.data.type = type;
                $('#resourceModalForm').modal('show');
            },
            openModal: function (data) {
                this.data = $.extend(true, {}, data);
                $('#resourceModalForm').modal('show');
            }
        }
    };

    $(function () {
        $('#resourceModalForm').on('hidden.bs.modal', function (e) {
            vm.$refs.resourceModal.clearModalForm();
        })

        $('#resourceModalForm').on('show.bs.modal', function (e) {
            $('#privileges').html('').select2({
                theme: 'bootstrap4',
                closeOnSelect: false,
                data: vm.$refs.resourceModal.authorities
            }).val(vm.$refs.resourceModal.data.authorities).trigger('change');
        })
    })
</script>
