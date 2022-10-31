<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<%--modal--%>
<script type="text/x-template" id="privilege-modal-form-component">
    <div class="modal fade" id="privilegeModalForm" data-backdrop="static" data-keyboard="true" tabindex="-1"
         role="dialog" aria-labelledby="modalFormLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalFormLabel">권한 {{isUpdate ? '수정' : '등록'}}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="form-row">
                            <div class="form-group col-6">
                                <label for="name">권한코드</label>
                                <input type="text" class="form-control" id="name" name="name" v-model="data.name">
                                <div id="nameError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-6">
                                <label for="description">권한명</label>
                                <input type="text" class="form-control" id="description" name="description"
                                       v-model.number="data.description">
                                <div id="descriptionError" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <div class="col-auto" v-if="data.id">
                        <auth:authorize method="D">
                        <button type="button" class="btn btn-danger" @click="deletePrivilege">삭제</button>
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

<script type="text/x-template" id="privilege-component">
    <div class="card card-light">
        <div class="card-header border-transparent py-2">
            <div class="row">
                <div class="col-auto mr-auto">
                    <%--<div class="form-inline">
                        <div class="form-group w-100 mb-0">
                            <%@ include file="/WEB-INF/view/common/view-page-size.jsp" %>
                        </div>
                    </div>--%>
                    <h3 class="card-title">권한 목록</h3>
                </div>
                <div class="col-auto">
                    <auth:authorize method="C">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#privilegeModalForm">
                        등록
                    </button>
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

            <privilege-modal-form-component ref="privilegeModal"></privilege-modal-form-component>
        </div>
        <!-- /.card-body -->
        <!-- .card-footer -->
        <div class="card-footer">
            <ul class="pagination justify-content-center m-0">
                <pagination-component :page="page" :page-item-number="9" v-on:fetch="fetch"></pagination-component>
            </ul>
        </div>
    </div>
</script>

<script>
    var privilegeModalFormComponent = {
        template: '#privilege-modal-form-component',
        computed: {
            isUpdate: function () {
                return this.data.id != null && this.data.id != '';
            }
        },
        data: function () {
            return {
                data: {
                    name: '',
                    description: ''
                }
            }
        },
        methods: {
            save: function () {
                var self = this;
                jQuery.ajax("/admin/system/auth/privilege", {
                    method: self.isUpdate ? 'PUT' : 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(self.data),
                    dataType: 'json'
                }).done(function (data) {
                    self.isUpdate ? alertUpdated() : alertRegistered();
                    setTimeout(function () {
                        self.closeModal();
                        vm.$refs.privilege.fetch();
                    }, 1500);
                }).fail(function (data) {
                    displayErrors(data);
                });
            },
            deletePrivilege: function () {
                var self = this;
                var callback = function (isConfirm) {
                    if (isConfirm) {
                        jQuery.ajax("/admin/system/auth/privilege/" + self.data.id, {
                            method: 'DELETE'
                        }).done(function (data) {
                            alertSuccess("삭제되었습니다.");
                            self.closeModal();
                            vm.$refs.privilege.fetch();
                        }).fail(function (data) {
                            errorToastr(data.responseJSON.message);
                        });
                    }
                }
                deleteConfirm(callback);
            },
            clearModalForm: function () {
                this.data = {id: null, name: '', description: ''};
                clearInvalid();
            },
            openModal: function (data) {
                this.data = $.extend({}, data);
                $('#privilegeModalForm').modal('show');
            },
            closeModal: function () {
                $('#privilegeModalForm').modal('hide');
            }
        }
    }

    var privilegeComponent = {
        template: '#privilege-component',
        components: {
            'privilege-modal-form-component': privilegeModalFormComponent
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
                jQuery.get(contextPath + "/admin/system/auth/privilege?page=" + pageNumber)
                .done(function (data) {
                    self.page = data;
                })
                .fail(function (data) {
                    errorToastr("권한 목록 조회중 오류가 발생하였습니다.");
                })
            },
            selectRow: function (id) {
                var data = _.find(this.page.content, function (o) {
                    return o.id === id;
                });
                this.$refs.privilegeModal.openModal(data);
            }
        }
    }

    $(function () {
        $('#privilegeModalForm').on('hidden.bs.modal', function (e) {
            vm.$refs.privilege.$refs.privilegeModal.clearModalForm();
        })
    })
</script>
