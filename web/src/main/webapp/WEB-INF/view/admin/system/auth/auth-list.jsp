<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="component/privilege-component.jsp"/>
<jsp:include page="component/role-component.jsp"/>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">권한 및 역할 관리</h4>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">시스템 관리</li>
                        <li class="breadcrumb-item active">권한 및 역할 관리</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <role-component ref="roles"></role-component>
            <privilege-component ref="privilege"></privilege-component>
        </div>
    </div>

</div>

<script>
    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'privilege-component': privilegeComponent,
            'role-component': roleComponent
        }
    });

</script>
