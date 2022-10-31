<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
        <li class="nav-item" onclick="toggleSidebar()">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
        <%--<li class="nav-item d-none d-sm-inline-block">
            <a href="index3.html" class="nav-link">Home</a>
        </li>
        <li class="nav-item d-none d-sm-inline-block">
            <a href="#" class="nav-link">Contact</a>
        </li>--%>
    </ul>

    <!-- SEARCH FORM -->
    <%--<form class="form-inline ml-3">
        <div class="input-group input-group-sm">
            <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
            <div class="input-group-append">
                <button class="btn btn-navbar" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </form>--%>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
        <form id="logout" class="form-inline ml-3" action="<c:url value="/admin/logout"/>" method="post">
            <div class="input-group input-group-sm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <sec:authorize access="isAuthenticated()">
                <button class="btn btn-outline-secondary btn-sm" type="button" onclick="logout()">로그아웃</button>
                </sec:authorize>
                <sec:authorize access="!isAuthenticated()">
                    <button class="btn btn-outline-secondary btn-sm" type="button" onclick="login()">로그인</button>
                </sec:authorize>
            </div>
        </form>
    </ul>
</nav>
<!-- /.navbar -->
<script>
    $(function () {
        $('#logout').submit(function(e) {
            e.stopImmediatePropagation();
        });
    });
    function logout() {
        alertConfirm(function (isConfirm) {
            if (isConfirm) {
                $('#logout').submit();
            }
        }, "로그아웃 하시겠습니까?", "사용자의 접속이 해제 됩니다.", "로그아웃", "취소", "#dc3545");
    }

    function login() {
        location.href=contextPath + "/admin/login";
    }
</script>
