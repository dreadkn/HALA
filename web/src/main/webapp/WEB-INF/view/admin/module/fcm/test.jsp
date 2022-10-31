<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/common/vue-datatable-pagination.jsp"/>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">FCM 테스트</h4>
                </div>
                <div class="d-none col-sm-6 d-md-block">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">FCM 관리</li>
                        <li class="breadcrumb-item active">FCM 관리</li>
                        <li class="breadcrumb-item active">FCM 테스트</li>
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
                <div class="col-12">

                    <button class="btn btn-primary" @click="sendFcm">FCM 테스트</button>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
    var dataTable;
    // Root
    var vm = new Vue({
        el: '#vue-app',
        mounted: function () {

        },
        data: {
            fcm : {
                token: '',
                title: '',
                msg: '',
                type: 'SOUND',
                sound: '',
            }
        },
        watch: {
        },
        computed: {

        },
        methods: {
            sendFcm: function () {
                axios.post("/admin/module/fcm/send", this.fcm).then(function (res) {
                    alertSuccess("보냈습니다.");
                }).catch(function (err) {
                    displayErrors(err);
                });
            },

        }
    });

</script>

