<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.0.5/dist/css/adminlte.min.css"/>">

<style>
    .content-wrapper {
        width: 100%;
        height: 100%;
        margin-left: 0 !important;
    }
</style>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>404 Error Page</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">404 Error Page</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="error-page">
            <h2 class="headline text-warning"> 404</h2>

            <div class="error-content">
                <h3><i class="fas fa-exclamation-triangle text-warning"></i> 페이지를 찾을 수 없습니다.</h3>

                <p>
                    요청하신 페이지가 사라졌거나, 잘못된 경로를 이용하셨습니다.
                </p>

                <div class="input-group">
                    <button class="btn btn-warning" onclick="history.back()">뒤로가기</button>
                </div>
            </div>
        </div>
    </section>
</div>
