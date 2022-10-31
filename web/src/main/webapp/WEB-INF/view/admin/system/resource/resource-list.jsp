<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="component/resource-form-modal-component.jsp"/>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">리소스 관리</h4>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">시스템 관리</li>
                        <li class="breadcrumb-item active">리소스 관리</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">

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
                            <button type="button" class="btn btn-primary" data-toggle="modal"
                                    data-target="#resourceModalForm">등록
                            </button>
                            </auth:authorize>
                        </div>
                    </div>
                </div>
                <!-- /.card-header -->
                <div class="card-body p-0">
                    <table class="table table-sm table-bordered table-hover">
                        <thead>
                        <tr role="row" class="text-center">
                            <th style="width: 10%">#</th>
                            <th>타입</th>
                            <th>리소스명</th>
                            <th>메소드</th>
                            <th>패턴</th>
                            <th>설명</th>
                            <th>적용순서</th>
                            <th>등록일</th>
                            <th>수정일</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="(item, idx) in page.content" class="text-center" style="cursor: pointer"
                            @click="selectRow(item.id)">
                            <td>{{idx | rowNum(page, 'desc')}}</td>
                            <td>{{item.type}}</td>
                            <td>{{item.name}}</td>
                            <td>{{item.methodType}}</td>
                            <td>{{item.pattern}}</td>
                            <td>{{item.description}}</td>
                            <td>{{item.sortOrder}}</td>
                            <td>{{item.createdDate | formatDateTime}}</td>
                            <td>{{item.modifiedDate | formatDateTime}}</td>
                        </tr>
                        <tr v-if="page == null || page.empty">
                            <td colspan="7" class="text-center">데이터가 없습니다.</td>
                        </tr>
                        </tbody>
                    </table>

                    <resource-modal-form-component ref="resourceModal" :privileges="privileges"
                                                   :roles="roles"></resource-modal-form-component>
                </div>
                <!-- /.card-body -->
                <!-- .card-footer -->
                <div class="card-footer">
                    <ul class="pagination justify-content-center m-0">
                        <pagination-component :page="page" :page-item-number="9"
                                              v-on:fetch="fetch"></pagination-component>
                    </ul>
                </div>
            </div>

        </div>
    </div>

</div>

<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'resource-modal-form-component': resourceModalFormComponent,
        },
        mounted: function () {
            this.fetchAuthorities();
            this.fetch(0);
        },
        data: {
            page: {},
            privileges: [],
            roles: [],
        },
        methods: {
            fetch: function (pageNumber) {
                var self = this;
                pageNumber = pageNumber == null ? this.page.number : pageNumber;
                jQuery.ajax(contextPath + "/admin/system/resources?&page=" + pageNumber, {
                    method: 'GET',
                    contentType: 'application/json'
                })
                .done(function (data) {
                    self.page = data;
                })
                .fail(function (data) {
                    errorToastr("리소스 목록 조회중 오류가 발생하였습니다.");
                })
            },
            fetchAuthorities: function () {
                var self = this;
                jQuery.get(contextPath + "/admin/system/auth/privilege?size=999999999")
                .done(function (data) {
                    self.privileges = data.content.map(function (o) {
                        return {name: o.name, desc: o.description};
                    });
                })
                .fail(function (data) {
                    errorToastr("권한 목록 조회중 오류가 발생하였습니다.");
                })

                jQuery.get(contextPath + "/admin/system/auth/role?size=999999999")
                .done(function (data) {
                    self.roles = data.content.map(function (o) {
                        return {name: o.name, desc: o.description};
                    });
                })
                .fail(function (data) {
                    errorToastr("권한 목록 조회중 오류가 발생하였습니다.");
                })
            },
            selectRow: function (id) {
                var self = this;
                jQuery.get(contextPath + "/admin/system/resources/" + id)
                .done(function (data) {
                    self.$refs.resourceModal.openModal(data);
                })
                .fail(function (data) {
                    errorToastr("리소스 조회중 오류가 발생하였습니다.");
                })
            }
        }
    });

</script>
