<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/tags.jspf"%>

<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0,minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Inpply | Content Management System</title>

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/fontawesome-free/css/all.min.css"/>">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="<c:url value="/resources/lib/bootstrap-5.1.3-dist/css/bootstrap.css"/>">
    <!-- Toastr -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/toastr/toastr.min.css"/>">
    <!-- Ekko Lightbox -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/ekko-lightbox/ekko-lightbox.css"/>">
    <!-- daterange picker -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/daterangepicker/daterangepicker.css"/>">
    <!-- datetimepicker Bootstrap 4 -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css"/>">
    <%--bootstarp-fileinput--%>
    <%--<link rel="stylesheet" href="<c:url value="/webjars/bootstrap-fileinput/5.0.8/css/fileinput.min.css"/>" media="all"  type="text/css" />--%>
    <%--quill--%>
    <link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <!-- Theme style -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/dist/css/adminlte.min.css"/>">
    <%--  <link rel="stylesheet" href="<c:url value="/resources/css/adminlte.css"/>">--%>
    <!-- Google Font: Source Sans Pro -->

    <!-- fullCalendar -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/fullcalendar/main.min.css"/>">

    <!-- Bootstrap4 Duallistbox -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css"/>">
    <!-- select2 -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/select2/css/select2.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css"/>">
    <%--Bootstrap Tags Input--%>
    <link rel="stylesheet" href="<c:url value="/resources/lib/tagsinput/tagsinput.css"/>">
    <%--Dropzonejs--%>
<%--    <link rel="stylesheet" href="<c:url value="/webjars/dropzone/5.7.2/dropzone.css"/>">--%>
    <link rel="stylesheet" href="<c:url value="/resources/lib/dropzone-5.7.0/dropzone.css"/>">

    <link rel="stylesheet" href="<c:url value="/resources/lib/datetimepicker/jquery.datetimepicker.css" />">
    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/sweetalert2/sweetalert2.css"/>">

    <link rel="stylesheet" href="/resources/lib/bootstrap-context-menu/css/context.standalone.css">

    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-custom.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/style-admin.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/common.css"/>">

    <!-- REQUIRED SCRIPTS -->
    <!-- Vuejs -->
    <c:choose>
        <c:when test="${profile eq 'prod'}">
            <script src="<c:url value="/webjars/vue/2.6.11/vue.min.js"/>"></script>
        </c:when>
        <c:otherwise>
            <script src="<c:url value="/webjars/vue/2.6.11/vue.js"/>"></script>
        </c:otherwise>
    </c:choose>
    <script src="<c:url value="/resources/lib/bootstrap-5.1.3-dist/js/bootstrap.bundle.js"/>"></script>
    <!-- URI.js -->
    <script src="<c:url value="/webjars/uri.js/1.17.1/src/URI.js"/>"></script>
    <!-- jQuery -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/jquery/jquery.min.js"/>"></script>
    <!-- jQuery UI -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/jquery-ui/jquery-ui.min.js"/>"></script>
    <!-- jQuery serialize-object plugin -->
    <script src="<c:url value="/webjars/github-com-macek-jquery-serialize-object/2.5.0/dist/jquery.serialize-object.min.js"/>"></script>
    <!-- Bootstrap 4 -->
<%--    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"/>"></script>--%>
    <script src="<c:url value="/resources/lib/bootstrap/js/bootstrap.bundle.min.js"/>"></script>
    <!-- DataTables -->
    <link rel="stylesheet" href="/webjars/AdminLTE/3.2.0/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="/webjars/AdminLTE/3.2.0/plugins/datatables-select/css/select.bootstrap4.min.css">
    <link rel="stylesheet" href="/webjars/AdminLTE/3.2.0/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <!-- InputMask -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/inputmask/jquery.inputmask.js"/>"></script>
    <!-- SweetAlert2 -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/sweetalert2/sweetalert2.js"/>"></script>
    <!-- Toastr -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/toastr/toastr.min.js"/>"></script>
    <!-- Ekko Lightbox -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/ekko-lightbox/ekko-lightbox.min.js"/>"></script>
    <!-- moment -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/moment/moment.min.js"/>"></script>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/moment/moment-with-locales.min.js"/>"></script>
    <!-- date-range-picker -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/daterangepicker/daterangepicker.js"/>"></script>

    <!-- bs-custom-file-input -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/bs-custom-file-input/bs-custom-file-input.min.js"/>"></script>
    <%--quill--%>

    <!-- AdminLTE App -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/dist/js/adminlte.min.js"/>"></script>
    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.15/lodash.min.js"></script>

    <!-- fullCalendar 2.2.5 -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/fullcalendar/main.min.js"/>"></script>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/fullcalendar/locales-all.js"/>"></script>

    <!-- Bootstrap4 Duallistbox -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"/>"></script>
    <!-- select2 -->
<%--    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/select2/js/i18n/ko.js"/>"></script>--%>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/select2/js/select2.min.js"/>"></script>
    <%--Bootstrap Tags Input--%>
    <script src="<c:url value="/resources/lib/tagsinput/tagsinput.js"/>"></script>
    <%--Dropzonejs--%>
<%--    <script src="<c:url value="/webjars/dropzone/5.7.2/dropzone.js"/>"></script>--%>
    <script src="<c:url value="/resources/lib/dropzone-5.7.0/dropzone.js"/>"></script>
    <%--Sortable--%>
    <script src="//cdn.jsdelivr.net/npm/sortablejs@1.8.4/Sortable.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/Vue.Draggable/2.20.0/vuedraggable.umd.min.js"></script>

    <!--amchart-->
    <script src="https://cdn.amcharts.com/lib/4/core.js"></script>
    <script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
    <script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
    <script src="//www.amcharts.com/lib/4/lang/ko_KR.js"></script>

    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/admind/postcode.v2.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9ea483ef1722a0b11cb9bfbad8a87539&libraries=services,clusterer,drawing"></script>
    <!-- DataTables -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/datatables/jquery.dataTables.min.js"/>"></script>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/datatables-select/js/dataTables.select.min.js"/>"></script>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"/>"></script>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/datatables-responsive/js/dataTables.responsive.min.js"/>"></script>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"/>"></script>


    <%--ckeditor4--%>
<%--    <script src="/resources/lib/ckeditor/ckeditor.js"></script>--%>

    <%--suneditor--%>
    <link rel="stylesheet" href="/node_modules/suneditor/dist/css/suneditor.min.css">
    <script src="/node_modules/suneditor/dist/suneditor.min.js"></script>
    <script src="/node_modules/suneditor/src/lang/ko.js"></script>
    <script src="/resources/js/common/suneditor_config.js"></script>

    <%--Axios--%>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <script src="<c:url value='/resources/lib/datetimepicker/jquery.datetimepicker.full.js' />"></script>

    <script src="/resources/lib/bootstrap-context-menu/js/initialize.js"></script>
    <script src="/resources/lib/bootstrap-context-menu/js/context.js"></script>

<%--    <script src="<c:url value="/resources/js/common/ckeditor_config.js"/>"></script>--%>
    <script src="<c:url value="/resources/js/common/common.js"/>"></script>
    <script src="<c:url value="/resources/js/common/dataTables.js"/>"></script>
    <script src="<c:url value="/resources/js/common/vue-mixin.js"/>"></script>
    <script src="<c:url value="/resources/js/common/vue-filters.js"/>"></script>
    <script src="<c:url value="/resources/js/common/vue-directive.js"/>"></script>
    <script src="<c:url value="/resources/js/api/api-servicei.js"/>"></script>

    <script>
        <c:if test="${profile eq 'prod'}">
        Vue.config.silent = true;
        Vue.config.devtools = false;
        </c:if>


        // init axios
        axios.defaults.headers.common['${_csrf.headerName}'] = '${_csrf.token}';
        axios.defaults.headers.common['Content-Type'] = 'application/json';
        axios.interceptors.request.use(
            function (config) {
                showLoading();
                return config;
            },
            function (error) {
                hideLoading();
                return Promise.reject(error);
            });
        axios.interceptors.response.use(function (response) {
            hideLoading();
            clearInvalid();
            return response;
        }, function (error) {
            hideLoading();
            if (error.response.status === 401) {
                location.href = contextPath + "/admin/login";
            } else if (error.response.status === 403) {
                alertFailed("권한이 없습니다.");
            } else if (error.response.data.errors != null) {
                _displayErrors(error.response.data.errors);
            }
            return Promise.reject(error);
        });

        // init variables
        var contextPath = '${contextPath}';
        Vue.prototype.$contextPath = '${contextPath}';

        $.ajaxPrefilter(function (options) {
            var headerName = '${_csrf.headerName}';
            var token = '${_csrf.token}';
            if (options.method !== 'GET') {
                options.headers = options.headers || {};
                options.headers[headerName] = token;
            }
        });
        $( document ).ajaxError(function (event, jqxhr, settings, thrownError) {
            if (jqxhr.status === 401) {
                location.href = contextPath + "/login";
            } else if (jqxhr.status === 403) {
                alertFailed("권한이 없습니다.");
            }
        })
    </script>
    <meta name="${_csrf.headerName}" content="${_csrf.token}">

    <script src="https://unpkg.com/webp-hero@0.0.0-dev.21/dist-cjs/polyfills.js"></script>
    <script src="https://unpkg.com/webp-hero@0.0.0-dev.21/dist-cjs/webp-hero.bundle.js"></script>
    <script>
        var webpMachine = new webpHero.WebpMachine();
        webpMachine.polyfillDocument();

        function columnSetValue(value, className) {
            var selectClassName = value == 0 ? 'text-muted' : className;
            var bold = value == 0 ? '' : 'font-weight-bold ';
            return '<span class="' + bold + selectClassName + '">' + value + '</span>';
        }
    </script>

</head>
