<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<!-- Main Sidebar Container -->
<aside class="main-sidebar elevation-4">
    <!-- Brand Logo -->
    <a href="<c:url value="/admin/main"/>" class="brand-link">

            <img src="<c:url value="/resources/img/admin/logo_white.png"/>" alt="Logo" class="brand-image">

    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <sec:authorize access="isAuthenticated()">
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">
                <i class="fas fa-user-circle fa-2x" style="color: #bcc0c9"></i>
<%--                <img src="<c:url value="/webjars/AdminLTE/3.0.4/dist/img/user2-160x160.jpg"/>" class="img-circle elevation-2" alt="User Image">--%>
            </div>
            <div class="info">
                <a href="<c:url value="/admin/my"/>" class="d-block">${principal.username}</a>
            </div>
        </div>
        </sec:authorize>

<%--        ${menus}--%>
        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column nav-child-indent ${navFlat eq '1' ? 'nav-flat' : ''}" data-widget="treeview" role="menu" data-accordion="false">

                <c:forEach var="menu" items="${menus}" varStatus="status">
                    <li class="nav-item ${empty menu.childMenu ? '' : 'has-treeview'}">
                        <a href="<c:url value="${menu.url}"/>" class="nav-link">
                            <i class="nav-icon ${menu.icon}"></i>
                            <%--<div class="mw-side d-inline-block text-center">
                                <img src="/resources/img/ic_side_0${status.count}.png" class="mr-3 ">
                            </div>--%>
                            <c:choose>
                                <c:when test="${empty menu.childMenu}">
                                    <p>${menu.name}</p>
                                </c:when>
                                <c:otherwise>
                                    <p>${menu.name}<i class="right fas fa-angle-left"></i></p>
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <c:if test="${!empty menu.childMenu}">
                            <ul class="nav nav-treeview">
                                <c:forEach var="menu2" items="${menu.childMenu}">
                                    <li class="nav-item">
                                        <a href="<c:url value="${menu2.url}"/>" class="nav-link">
                                            <i class="nav-icon ${menu2.icon}"></i>
                                            <c:choose>
                                                <c:when test="${empty menu2.childMenu}">
                                                    <p>${menu2.name}</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p>${menu2.name}<i class="right fas fa-angle-left"></i></p>
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                        <c:if test="${!empty menu2.childMenu}">
                                            <ul class="nav nav-treeview">
                                                <c:forEach var="menu3" items="${menu2.childMenu}">
                                                    <li class="nav-item">
                                                        <a href="<c:url value="${menu3.url}"/>" class="nav-link">
                                                            <i class="nav-icon ${menu3.icon}"></i>
                                                            <c:choose>
                                                                <c:when test="${empty menu3.childMenu}">
                                                                    <p>${menu3.name}</p>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <p>${menu3.name}<i class="right fas fa-angle-left"></i></p>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </li>
                </c:forEach>

                <sec:authorize access="hasRole('SYSTEM')">
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-cogs"></i>
                        <p>시스템 관리<i class="right fas fa-angle-left"></i></p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value="/admin/system/menu"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>메뉴 관리</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin/system/auth"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>권환 및 역할 관리</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin/system/resources"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>리소스 관리</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin/system/codes"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>코드 관리</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/admin/boards"/>" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>게시판 관리</p>
                            </a>
                        </li>
                    </ul>
                </li>
                </sec:authorize>
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>

<script>
    $(function () {
       var url = (window.location + "");
       var path = url.substr(url.indexOf(window.location.pathname));
       var indexCount = path.replace("?", "/").split("/").length-1;

        var menus = getMenus();
        while (indexCount > 0) {
            let pathByIndex = getPathByIndex(path, indexCount);
            for (var i=0; i < menus.length; i++) {
                if ($(menus[i]).attr('href').replace("?", "/") === pathByIndex) {
                    $(menus[i]).addClass('active');
                    $(menus[i]).parents('li.nav-item.has-treeview').addClass('menu-open');
                    $(menus[i]).parents('li.nav-item.has-treeview').children('a.nav-link').addClass('active');
                    return;
                }
            }
            indexCount--;
        }

        function getPathByIndex(path, index) {
            let split = path.replace("?", "/").split("/");
            split = split.filter(function (val) { return val !== ""});
            var returnPath = "/";
            for (var i=0; i < index; i++) {
                returnPath = returnPath + split[i];
                returnPath = i < index-1 ? returnPath + "/" : returnPath;
            }

            return returnPath;
        }

        function getMenus() {
            return $('.nav.nav-sidebar a.nav-link');
        }
    });

</script>
