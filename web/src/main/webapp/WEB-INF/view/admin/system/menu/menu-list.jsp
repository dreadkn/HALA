<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="component/menu-form-modal-component.jsp"/>
<jsp:include page="component/menu-component.jsp"/>


<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">메뉴 관리</h4>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">시스템 관리</li>
                        <li class="breadcrumb-item active">메뉴 관리</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-6">
                    <menu-component ref="adminMenu" :type="'ADMIN'" @create-menu="createMenu"
                                    @update-menu="updateMenu"></menu-component>
                </div>
                <div class="col-sm-6">
                    <menu-component ref="userMenu" :type="'USER'" @create-menu="createMenu"
                                    @update-menu="updateMenu"></menu-component>
                </div>
            </div>
        </div>
    </div>

    <menu-form-component ref="menuModal" :privileges="privileges" :roles="roles"></menu-form-component>
</div>

<script>
    var sortableArray = [];
    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'menu-component': menuComponent,
            'menu-form-component': menuFormComponent
        },
        mounted: function () {
            this.fetchAuthorities();
        },
        data: {
            privileges: [],
            roles: [],
        },
        methods: {
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
            createMenu: function (parentId, type, callback) {
                this.$refs.menuModal.createModal(parentId, type, callback);
            },
            updateMenu: function (menuData, callback) {
                this.$refs.menuModal.openModal(menuData, callback);
            }
        }
    });

</script>
