<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<%--modal--%>
<script type="text/x-template" id="role-modal-form-component">
    <div class="modal fade" id="roleModalForm" data-backdrop="static" data-keyboard="true" tabindex="-1" role="dialog"
         aria-labelledby="modalFormLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalFormLabel">역할 {{isUpdate ? '수정' : '등록'}}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="form-row">
                            <div class="form-group col-6">
                                <label for="name">역할코드</label>
                                <input type="text" class="form-control" id="name" name="name" v-model="data.name">
                                <div id="nameError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-6">
                                <label for="description">역할명</label>
                                <input type="text" class="form-control" id="description" name="description"
                                       v-model="data.description">
                                <div id="descriptionError" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12">
                                <label>권한 선택</label>
                                <select class="form-control select2" id="privileges" multiple="multiple"
                                        v-model="data.privileges" v-select2 style="width: 100%;">
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12">
                                <label>하위역할 선택</label>
                                <select class="form-control select2" id="childRoles" multiple="multiple"
                                        v-model="data.childRoles" v-select2 style="width: 100%;">
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <div class="col-auto" v-if="data.id">
                        <auth:authorize method="D">
                        <button type="button" class="btn btn-danger" @click="deleteRole">삭제</button>
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
<%--/modal--%>

<script type="text/x-template" id="role-component">
    <div class="card card-light">
        <div class="card-header border-transparent py-2">
            <div class="row">
                <div class="col-auto mr-auto">
                    <%--<div class="form-inline">
                        <div class="form-group w-100 mb-0">
                            <%@ include file="/WEB-INF/view/common/view-page-size.jsp" %>
                        </div>
                    </div>--%>
                    <h3 class="card-title">역할 목록</h3>
                </div>
                <div class="col-auto">
                    <auth:authorize method="C">
                    <button type="button" class="btn btn-primary" data-toggle="modal" @click="create">등록</button>
                    </auth:authorize>
                </div>
            </div>
        </div>
        <!-- /.card-header -->
        <div class="card-body p-0">
            <table class="table table-bordered table-hover">
                <thead>
                <tr role="row" class="text-center">
                    <th style="width: 10%">#</th>
                    <th>권한명</th>
                    <th>설명</th>
                    <th>등록일</th>
                    <th>수정일</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="(item, idx) in page.content" class="text-center" style="cursor: pointer"
                    @click="selectRow(item.id)">
                    <td>{{idx | rowNum(page, 'desc')}}</td>
                    <td>{{item.name}}</td>
                    <td>{{item.description}}</td>
                    <td>{{item.createdDate | formatDateTime}}</td>
                    <td>{{item.modifiedDate | formatDateTime}}</td>
                </tr>
                <tr v-if="page == null || page.empty">
                    <td colspan="5" class="text-center">데이터가 없습니다.</td>
                </tr>
                </tbody>
            </table>

            <role-modal-form-component ref="roleModal" :roles="page.content"></role-modal-form-component>
        </div>
        <!-- /.card-body -->
        <!-- .card-footer -->
        <div class="card-footer">
            <ul class="pagination justify-content-center m-0">
                <pagination-component :page="page" :page-item-number="9" v-on:fetch="fetch"
                                      name="rolePagination"></pagination-component>
            </ul>
        </div>
    </div>
</script>


<script>
    // 역할 모달 폼
    var privilegeSelect;
    var roleSelect;
    var roleModalFormComponent = {
        template: '#role-modal-form-component',
        props: ["roles"],
        mounted: function () {
            // this.fetchPrivilege();
        },
        computed: {
            isUpdate: function () {
                return this.id != null && this.id != '';
            },
            privilegeOptions: function () {
                return _.map(this.privileges, function (o) {
                    var text = o.description != null && o.description != '' ? o.name + " (" + o.description + ")" : o.name;
                    return {id: o.id, text: text}
                })
            }
        },
        data: function () {
            return {
                id: '',
                data: {
                    name: '',
                    description: '',
                    privileges: [],
                    childRoles: []
                },
                privileges: []
            }
        },
        watch: {
            roles: function () {
            }
        },
        methods: {
            roleOptions: function (id) {
                var self = this;
                var filter = _.filter(this.roles, function (o) {
                    return o.id != self.id;
                });
                return _.map(filter, function (o) {
                    var text = o.description != null && o.description != '' ? o.name + " (" + o.description + ")" : o.name;
                    return {'id': o.id + '', 'text': text}
                });
            },
            fetch: function (id) {
                var self = this;
                jQuery.get(contextPath + "/admin/system/auth/role/" + id)
                .done(function (data) {
                    self.data.id = data.id;
                    self.data.name = data.name;
                    self.data.description = data.description;
                    self.data.privileges = data.privileges.map(function (o) {
                        return o.id + ''
                    })
                    self.data.childRoles = data.childRoles.map(function (o) {
                        return o.id + ''
                    })
                })
                .fail(function (data) {
                    errorToastr("역할 조회중 오류가 발생하였습니다.");
                }).always(function () {
                    setTimeout(function () {
                        $('#privileges').select2({
                            theme: 'bootstrap4',
                            closeOnSelect: false
                        }).val(self.data.privileges).trigger('change');
                        $('#childRoles').select2({
                            theme: 'bootstrap4',
                            closeOnSelect: false
                        }).val(self.data.childRoles).trigger('change');
                    }, 100)
                })
            },
            save: function () {
                var self = this;
                jQuery.ajax("/admin/system/auth/role", {
                    method: self.isUpdate ? 'PUT' : 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(self.data),
                    dataType: 'json'
                }).done(function (data) {
                    self.isUpdate ? alertUpdated() : alertRegistered();
                    setTimeout(function () {
                        self.closeModal();
                        vm.$refs.roles.fetch();
                    }, 1500);
                }).fail(function (data) {
                    displayErrors(data);
                });
            },
            deleteRole: function () {
                var self = this;
                var callback = function (isConfirm) {
                    if (isConfirm) {
                        jQuery.ajax("/admin/system/auth/role/" + self.data.id, {
                            method: 'DELETE'
                        }).done(function (data) {
                            alertSuccess("삭제되었습니다.");
                            self.closeModal();
                            vm.$refs.roles.fetch();
                        }).fail(function (data) {
                            errorToastr("권한 삭제중 오류가 발생하였습니다.");
                        });
                    }
                }
                deleteConfirm(callback);
            },
            clearModalForm: function () {
                this.data = {id: null, name: '', description: '', privileges: [], childRoles: []};
                clearInvalid();
            },
            openModal: function (id) {
                var self = this;
                this.id = id;
                this.fetchPrivilege();
                if (id != null) {
                    self.fetch(id);
                }
                $('#roleModalForm').modal('show');
            },
            closeModal: function () {
                $('#roleModalForm').modal('hide');
            },
            fetchPrivilege: function () {   // 권한 목록 조회.
                var self = this;
                jQuery.get(contextPath + "/admin/system/auth/privilege?page=0&size=999999")
                .done(function (data) {
                    self.privileges = data.content;
                    $('#privileges').select2({
                        theme: 'bootstrap4',
                        closeOnSelect: false,
                        data: self.privilegeOptions
                    });
                    $('#childRoles').html('').select2({
                        theme: 'bootstrap4',
                        closeOnSelect: false,
                        data: self.roleOptions(self.id)
                    })
                })
                .fail(function (data) {
                    errorToastr("권한 목록 조회중 오류가 발생하였습니다.");
                })
            }
        }
    }

    // 역할 목록
    var roleComponent = {
        template: '#role-component',
        components: {
            'role-modal-form-component': roleModalFormComponent
        },
        mounted: function () {
            this.fetch();
        },
        data: function () {
            return {
                page: {}
            }
        },
        methods: {
            fetch: function (pageNumber) {
                var self = this;
                pageNumber = pageNumber == null ? this.page.number : pageNumber;
                jQuery.get(contextPath + "/admin/system/auth/role?&page=" + pageNumber)
                .done(function (data) {
                    self.page = data;
                })
                .fail(function (data) {
                    errorToastr("역할 목록 조회중 오류가 발생하였습니다.");
                })
            },
            selectRow: function (id) {
                this.$refs.roleModal.openModal(id);
            },
            create: function () {
                this.$refs.roleModal.openModal()
            }
        }
    }

    $(function () {
        $('#roleModalForm').on('hidden.bs.modal', function (e) {
            $('#childRoles').select2('destroy');
            vm.$refs.roles.$refs.roleModal.clearModalForm();
        })

    })
</script>
