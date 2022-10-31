<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="component/code-form-modal-component.jsp"/>
<jsp:include page="component/code-component.jsp"/>


<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">코드 관리</h4>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">시스템 관리</li>
                        <li class="breadcrumb-item active">코드 관리</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <ul class="nav nav-tabs" id="pills-tab">
                        <li v-for="(code, idx) in codeTypes" class="nav-item" role="presentation">
                            <a class="nav-link" :class="[idx === 0 ? 'active' : '']" :id="'nav-tab-' + idx" data-toggle="pill" :href="'#nav-tab-body-' + idx" role="tab">{{code.value}}</a>
                        </li>
                    </ul>
                </div>
                <div class="card-body">

                    <div class="tab-content" id="pills-tabContent">
                        <div v-for="(code, idx) in codeTypes" class="tab-pane fade" :class="[idx === 0 ? 'show active' : '']" :id="'nav-tab-body-' + idx">
                            <code-component ref="codeComponent" :type="code.code" @create-code="createCode"
                                            @update-code="updateCode"></code-component>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <code-form-component ref="codeModal"></code-form-component>
</div>

<script>
    <tags:enum-code code="CodeType"/>
    var codeTypes = ${enumJson};
    var sortableArray = [];
    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'code-component': codeComponent,
            'code-form-component': codeFormComponent
        },
        mounted: function () {
            // this.fetchAuthorities();
        },
        data: {
            codeTypes: codeTypes,
        },
        methods: {
            createCode: function (parentId, type, callback) {
                this.$refs.codeModal.createModal(parentId, type, callback);
            },
            updateCode: function (menuData, callback) {
                this.$refs.codeModal.openModal(menuData, callback);
            }
        }
    });

</script>
