<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/tags.jspf"%>

<!DOCTYPE html>
<html lang="ko">

<style>


</style>
<tiles:insertAttribute name="head"/>

<body class="hold-transition layout-fixed layout-navbar-fixed sidebar-mini ${toggleSidebar eq '1' ? 'sidebar-collapse' : ''}">

<div class="dimming-backdrop fade"></div>
<div id="loading-container">
  <div class="title">processing...</div>
  <div class="animation">
    <div class="loading"></div>
  </div>
</div>
<div class="wrapper">
  <!-- Navbar -->
  <tiles:insertAttribute name="navbar"/>

  <!-- Main Sidebar Container -->
  <tiles:insertAttribute name="main-sidebar"/>

  <!-- Content Wrapper. Contains page content -->
  <tiles:insertAttribute name="content"/>

  <!-- Control Sidebar -->
  <tiles:insertAttribute name="control-sidebar"/>

  <!-- Main Footer -->
  <tiles:insertAttribute name="footer"/>

</div>
<!-- ./wrapper -->

<%@ include file="/WEB-INF/view/common/vue-pagination.jsp" %>

</body>
</html>
