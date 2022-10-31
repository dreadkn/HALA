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
                    <h1>400 Error Page</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <%--                        <li class="breadcrumb-item"><a href="#">Home</a></li>--%>
                        <li class="breadcrumb-item active">400 Error Page</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="error-page">
            <h2 class="headline text-danger">400</h2>

            <div class="error-content">
                <h3><i class="fas fa-exclamation-triangle text-danger"></i> 유효하지 않은 요청입니다.</h3>

                <p>
                    이용에 불편을 드려 죄송합니다. <br>
                    유효하지 않은 요청을 하셨습니다. 잠시 후 다시 확인해주세요.
                </p>

                <div class="input-group">
                    <button class="btn btn-danger" onclick="history.back()">뒤로가기</button>
                </div>
            </div>
        </div>
        <!-- /.error-page -->

    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->


<%--에러 상태 코드 출력--%>
<%--<c:out value="${requestScope['javax.servlet.error.status_code']}"/>
&lt;%&ndash;예외처리 클래스 출력&ndash;%&gt;
<c:out value="${requestScope['javax.servlet.error.exception_type']}"/>
&lt;%&ndash;오류 메세지 출력&ndash;%&gt;
<c:out value="${requestScope['javax.servlet.error.message']}"/>
&lt;%&ndash;문제가 되는 request uri 정보를 출력&ndash;%&gt;
<c:out value="${requestScope['javax.servlet.error.request_uri']}"/>
&lt;%&ndash;발생한 예외처리 내용 출력&ndash;%&gt;
<c:out value="${requestScope['javax.servlet.error.exception']}"/>
&lt;%&ndash;에러가 난 서블릿 명 출력&ndash;%&gt;
<c:out value="${requestScope['javax.servlet.error.servlet_name']}"/>--%>
