<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<body class="hold-transition login-page">

  <div class="login-box">
    <!-- /.login-logo -->
    <div class="">
      <div class="card-body login-card-body">
        <p class="login-box-msg"></p>

        <form name="f" action="" method="post">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <div class="row align-items-center login-layout">
            <div class="col-12 ">
              <div class="mb-4">
                <img src="<c:url value="/resources/img/admin/logo_white.png"/>"  alt="logo" class="mxw-50">
              </div>
              <div class="row  mb-3">
                <div class="col-12 col-sm-auto">
                  <div class="input-group mb-3">
                    <input type="text" class="form-control" name="username" placeholder="ID" autofocus value="">
                  </div>
                  <div class="input-group ">
                    <input type="password" class="form-control" name="password" placeholder="Password" value="" >
                  </div>
                </div>
                <div class="col-12 col-sm-4 mt-3 mt-sm-0">
                  <div class="login-btn-wrap">
                    <button type="submit" class="btn btn-primary btn-block btn-login">LOGIN</button>
                  </div>
                </div>
              </div>
              <div class="">
                <div class="icheck-primary">
                  <label class="checkbox-wrap mx-3">
                    <input type="checkbox" id="idSave" name="idSave" checked>
                    <span class="checkmark"></span>
                  </label>
                  <label for="idSave">아이디 저장</label>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>

  <c:if test="${param.message != null}">
    <div class="alert alert-info">${param.message}</div></c:if>

  <c:if test="${param.error != null}">
    <div class="alert alert-danger">${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"]}</div>
  </c:if>

</body>
<script>
  $(function(){
    if (getCookie("loginsave") != '')
    {
      $('[name=username]').val(getCookie("loginsave"));
      $('#idSave').prop('checked', true);
    }


    $(f).on('submit', function(){
      if ($('#idSave').is(':checked')) {
        setCookie("loginsave", $('[name=username]').val(), 7);
      }
    });
  });
</script>