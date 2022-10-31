<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta property="og:url" content="https://">
    <meta property="og:type" content="website">
    <meta property="og:title" content="굿모닝제주">
    <meta property="og:description" content="">
    <title>굿모닝제주</title>

    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="<c:url value="/resources/lib/bootstrap-5.1.3-dist/css/bootstrap.css"/>">
    <%--    <link rel="stylesheet" href="<c:url value="/webjars/bootstrap/4.5.2/dist/css/bootstrap.css"/>">--%>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/fontawesome-free/css/all.min.css"/>">
    <!-- Toastr -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/toastr/toastr.min.css"/>">
    <!-- Ekko Lightbox -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/ekko-lightbox/ekko-lightbox.css"/>">
    <%--quill--%>
    <%--<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">--%>


    <link rel="stylesheet" href="<c:url value="/resources/lib/datetimepicker/jquery.datetimepicker.css" />">

    <link rel="stylesheet" href="<c:url value="/resources/lib/dropzone-5.7.0/dropzone.css"/>">

    <!-- DataTables -->
    <link rel="stylesheet" href="/webjars/AdminLTE/3.2.0/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="/webjars/AdminLTE/3.2.0/plugins/datatables-select/css/select.bootstrap4.min.css">
    <link rel="stylesheet" href="/webjars/AdminLTE/3.2.0/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

    <%--Bootstrap 5--%>
    <link rel="stylesheet" href="/webjars/bootstrap/5.2.0/dist/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="<c:url value="/resources/lib/aos/aos.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/css/common.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
<%--    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-gothic.css" rel="stylesheet" />--%>

    <!-- REQUIRED SCRIPTS -->
    <!-- Vuejs -->
    <c:choose>
        <c:when test="${profile eq 'prod'}">
            <script src="<c:url value="/resources/lib/vue/2.6.11/vue.min.js"/>"></script>
        </c:when>
        <c:otherwise>
            <script src="<c:url value="/resources/lib/vue/2.6.11/vue.js"/>"></script>
        </c:otherwise>
    </c:choose>
    <!-- jQuery -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/jquery/jquery.min.js"/>"></script>
    <!-- Bootstrap 4 -->
    <script src="<c:url value="/resources/lib/bootstrap-5.1.3-dist/js/bootstrap.bundle.js"/>"></script>
    <!-- Toastr -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/toastr/toastr.min.js"/>"></script>
    <!-- Ekko Lightbox -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/ekko-lightbox/ekko-lightbox.min.js"/>"></script>
    <!-- moment -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/moment/moment.min.js"/>"></script>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/moment/moment-with-locales.min.js"/>"></script>
    <!-- date-range-picker -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/daterangepicker/daterangepicker.js"/>"></script>

    <script src="<c:url value="/resources/lib/dropzone-5.7.0/dropzone.js"/>"></script>
    <!-- URI.js -->
    <script src="<c:url value="/webjars/uri.js/1.17.1/src/URI.js"/>"></script>
    <!-- DataTables -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/datatables/jquery.dataTables.min.js"/>"></script>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/datatables-select/js/dataTables.select.min.js"/>"></script>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"/>"></script>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/datatables-responsive/js/dataTables.responsive.min.js"/>"></script>
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"/>"></script>

    <%--Axios--%>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="<c:url value="/webjars/AdminLTE/3.2.0/plugins/sweetalert2/sweetalert2.css"/>">

    <%--quill--%>
<%--    <script src="//cdn.quilljs.com/1.3.6/quill.min.js"></script>--%>

    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.15/lodash.min.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/admind/postcode.v2.js"></script>
<%--    <script type="text/javascript"--%>
<%--            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9ea483ef1722a0b11cb9bfbad8a87539&libraries=services,clusterer,drawing"></script>--%>
<%--    <script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>--%>

    <!-- SweetAlert2 -->
    <script src="<c:url value="/webjars/AdminLTE/3.2.0/plugins/sweetalert2/sweetalert2.js"/>"></script>

    <script src="<c:url value='/resources/lib/datetimepicker/jquery.datetimepicker.full.js' />"></script>
    <script src="<c:url value='/resources/lib/aos/aos.js' />"></script>
    <script src="https://unpkg.com/vue-infinite-loading@^2/dist/vue-infinite-loading.js"></script>

    <script src="<c:url value="/resources/lib/detectmobilebrowser.js"/>"></script>
    <script src="<c:url value="/resources/js/common/common.js"/>"></script>
    <script src="<c:url value="/resources/js/common/dataTables.js"/>"></script>
    <script src="<c:url value="/resources/js/common/vue-mixin.js"/>"></script>
    <script src="<c:url value="/resources/js/common/vue-filters.js"/>"></script>
    <%--swiper--%>
    <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
    <script>

        /*if (window.navigator.userAgent.match(/MSIE|Internet Explorer|Trident/i)) {
            window.location = "microsoft-edge:" + window.location.href;
            window.close();
        }*/
        // init axios
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
        axios.interceptors.response.use(
            function (response) {
                hideLoading();
                clearInvalid();
                return response;
            },
            function (error) {
                hideLoading();
                console.log(error.response);
                if (error.response && error.response.status === 401) {
                    location.href = contextPath + "/login";
                } else if (error.response && error.response.status === 403) {
                    alertFailed("권한이 없습니다.");
                } else if (error.response && error.response.data.errors != null) {
                    console.log('displayErrors');
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

        $(function () {
            $.ajaxSetup({
                error: function(jqXHR, exception) {
                    if (jqXHR.status === 401) {
                        var callback = function(isConfirm) {
                            if (isConfirm) {
                                location.href = contextPath + "/login";
                            }
                        }
                        _alertConfirm(callback, "로그아웃 되었습니다.", "다시 로그인해주세요.", "error", "로그인", null, null, null);
                    } else if (jqXHR.status === 403) {
                        alertFailed("권한이 없습니다.");
                    }
                }
            });
        })

        function osCheck() {
            var mobile = (/iphone|ipad|ipod|android/i.test(navigator.userAgent.toLowerCase()));
            if (mobile) {
                var userAgent = navigator.userAgent.toLowerCase();
                if (userAgent.search("android") > -1) {
                    return "android";
                } else if ((userAgent.search("iphone") > -1) || (userAgent.search("ipod") > -1) || (userAgent.search(
                    "ipad") > -1)) {
                    return "ios";
                } else {
                    return "otehr";
                }
            } else {
                return "other";
            }
        }

        function open_app_kakaomap(url) {
            var os = osCheck();
            if (os !== "pc") {
                if (os === "android") {
                    location.href = "intent://scan/#Intent;scheme=" + url + ";package=net.daum.android.map;end";
                } else {
                    location.href = url;
                }
            }
        }

        $(function(){
            $('body').addClass(getCookie('skin'));

            initSkin();
        })
    </script>

    <style>
        /*datetimepicker border 삭제*/
        .bootstrap-datetimepicker-widget .table thead th {
            border-bottom: none !important;
        }

        .bootstrap-datetimepicker-widget .table th, .bootstrap-datetimepicker-widget .table td {
            border-top: none !important;
        }

        [v-cloak] {
            display: none;
        }
    </style>

</head>
