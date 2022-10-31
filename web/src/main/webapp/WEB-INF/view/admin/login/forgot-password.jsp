<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<style>
  body.login-page {
    background-image: url("/resources/img/admin/background.jpg");
    background-size: cover;
  }
</style>

<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
      <img src="<c:url value="/resources/img/admin/bi.png"/>"  alt="logo">
      <small class="text-nowrap">Content Management System</small>
  </div>
  <!-- /.login-logo -->
  <div class="card">
    <div class="card-body login-card-body">
      <p class="login-box-msg">아이디와 이메일을 입력해주세요.</p>

      <form id="form" method="post">
        <div class="input-group mb-3">
          <div class="input-group mb-3">
            <input type="name" name="userId" class="form-control" placeholder="아이디">
            <div class="input-group-append">
              <div class="input-group-text">
                <span class="fas fa-user-circle"></span>
              </div>
            </div>
            <div id="userIdError" class="invalid-feedback"></div>
          </div>
          <input type="email" name="email" class="form-control" placeholder="이메일">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
          <div id="emailError" class="invalid-feedback"></div>
        </div>
        <div class="row">
          <div class="col-12">
            <button type="submit" class="btn btn-primary btn-block">비밀번호 찾기</button>
          </div>
          <!-- /.col -->
        </div>
      </form>

      <p class="mt-3 mb-1">
        <a href="<c:url value="/admin/login"/>">로그인</a>
      </p>
      <%--<p class="mb-0">
        <a href="register.html" class="text-center">Register a new membership</a>
      </p>--%>
    </div>
    <!-- /.login-card-body -->
  </div>
</div>

<script>
  $('form').submit(function (e) {
    e.preventDefault();
    clearInvalid();
    var query = $('#form').serialize();
    jQuery.ajax(contextPath + '/user/resetPassword', {
      method: 'POST',
      data: query
    }).done(function (data) {
      alertSuccess(data.message, "확인");
    })
    .fail(function (data) {
      displayErrors(data);
    })
  });
</script>
</body>
