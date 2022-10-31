<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="menu-form-component">
    <div class="modal fade" id="menuModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="menuModalLabel">메뉴 {{isUpdate ? '수정' : '등록'}}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="form-group">
                            <label for="name">메뉴명</label>
                            <input type="text" class="form-control" id="name" name="name" v-model="data.name"
                                   placeholder="메뉴명을 입력해주세요.">
                            <div id="nameError" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group">
                            <label for="url">URL</label>
                            <input type="text" class="form-control" id="url" name="url" v-model="data.url"
                                   placeholder="URL">
                            <div id="urlError" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group">
                            <label for="icon">Icon <small class="text-muted">(Class Name)</small> </label>
                            <input type="text" class="form-control" id="icon" name="icon" v-model="data.icon"
                                   placeholder="Icon">
                            <div id="iconError" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group">
                            <label for="option1">Option1</label>
                            <input type="text" class="form-control" id="option1" name="option1" v-model="data.option1">
                            <div id="option1Error" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group">
                            <label for="option2">Option2</label>
                            <input type="text" class="form-control" id="option2" name="option2" v-model="data.option2">
                            <div id="option2Error" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group">
                            <label for="option3">Option3</label>
                            <input type="text" class="form-control" id="option3" name="option3" v-model="data.option3">
                            <div id="option3Error" class="invalid-feedback"></div>
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

                        <%--<div class="form-row">
                            <div class="form-group col-12">
                                <label>역할 선택</label>
                                <select class="form-control select2" id="roles" multiple="multiple" &lt;%&ndash;v-model="data.privileges"&ndash;%&gt; v-select2 style="width: 100%;">
                                </select>
                            </div>
                        </div>--%>

                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <div class="col-auto" v-if="data.id">
                        <auth:authorize method="D">
                        <button type="button" class="btn btn-danger" @click="deleteMenu">삭제</button>
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
    var menuFormComponent = {
        template: '#menu-form-component',
        props: ["privileges", "roles"],
        data: function () {
            return {
                data: {
                    name: '',
                    url: '',
                    icon: '',
                    option1: '',
                    option2: '',
                    option3: '',
                    orderNumber: 99999,
                    type: '',
                    authorities: [],
                    parentId: null
                },
                authorities: []
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
                jQuery.ajax(contextPath + '/admin/system/menu', {
                    method: self.isUpdate ? 'PUT' : 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(self.data),
                    dataType: 'json'
                }).done(function (data) {
                    // vm.fetchMenuList();
                    refreshCallback();
                    $('#menuModal').modal('hide')
                    alertSuccess("저장되었습니다.");
                }).fail(function (data) {
                    displayErrors(data);
                });
            },
            deleteMenu: function () {
                var self = this;
                var callback = function (isConfirm) {
                    if (isConfirm) {
                        jQuery.ajax(contextPath + "/admin/system/menu/" + self.data.id, {
                            method: 'DELETE',
                            contentType: 'application/json'
                        })
                        .done(function (data) {
                            // vm.fetchMenuList();
                            refreshCallback();
                            $('#menuModal').modal('hide')
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
                    name: '',
                    url: '',
                    icon: '',
                    option1: '',
                    option2: '',
                    option3: '',
                    orderNumber: 99999,
                    type: '',
                    authorities: [],
                    parentId: null
                };
                clearInvalid();
            },
            createModal: function (parentId, type, callback) {
                refreshCallback = callback;
                this.data.parentId = parentId;
                this.data.type = type;
                $('#menuModal').modal('show');
            },
            openModal: function (data, callback) {
                refreshCallback = callback;
                this.data = $.extend(true, {}, data);
                $('#menuModal').modal('show');
            }
        }
    };

    $(function () {
        $('#menuModal').on('hidden.bs.modal', function (e) {
            vm.$refs.menuModal.clearModalForm();
        })

        $('#menuModal').on('show.bs.modal', function (e) {
            console.log(vm.$refs.menuModal.data.authorities);
            $('#privileges').html('').select2({
                theme: 'bootstrap4',
                closeOnSelect: false,
                data: vm.$refs.menuModal.authorities
            }).val(vm.$refs.menuModal.data.authorities).trigger('change');
        })
    })
</script>
