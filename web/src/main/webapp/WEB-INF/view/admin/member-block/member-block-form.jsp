<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="component/member-block-info-component.jsp"/>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">차단 회원 {{isNew ? '등록' : '수정'}}</h4>
                </div>
                <div class="col-sm-6 d-none d-md-block">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">차단 회원 관리</li>
                        <li class="breadcrumb-item active">차단 회원 관리</li>
                        <li class="breadcrumb-item active">차단 회원 {{isNew ? '등록' : '수정'}}</li>
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

                <div class="col-md-8">
                    <member-block-info-component ref="info" ></member-block-info-component>
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
            'member-block-info-component': memberBlockInfoComponent
        },
        mounted: function () {
            if (this.isUpdate) {
                this.fetch();
            }
        },
        data: {
            id: '${id}'
        },
        computed: {
            isNew: function () {
                return this.id == null || this.id == '';
            },
            isUpdate: function () {
                return this.id != null && this.id != '';
            }
        },
        methods: {
            fetch: function () {
                var self = this;
                axios.get(contextPath + "/admin/member-block/detail/" + self.id, {data: {}}).then(function (data) {
                    self.$refs.info.member = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                    setTimeout(function () {
                        back('/admin/member-block');
                    }, 1500)
                });
            }
        }
    });

</script>

