<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/common/vue-datatable-pagination.jsp"/>

<style>
    .dataTable th.sorting, .dataTable th.sorting_asc, .dataTable th.sorting_desc {
        padding-right: 20px !important;
    }
    .dataTable th.sorting_disabled {
        padding-right: .3rem; !important;
    }
    .dataTable th::before, .dataTable th::after {
        /*bottom: auto !important;*/
        /*display: inline !important;*/
    }
</style>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">문자 발송 내역</h4>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">회원 관리</li>
                        <li class="breadcrumb-item active">문자 발송 내역</li>
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

                    <%-- 검색필터 --%>
                    <div class="card card-light <%--collapsed-card--%>">
                        <div class="card-header">
                            <h3 class="card-title">검색 필터</h3>

                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body pt-2 pb-1">
                            <form>
                            	<div class="row align-items-center">
                                    <div class="col-md-auto">
                                        <div class="form-group row align-items-center">
                                            <div class="col-auto text-bold">일자</div>
                                            <div class="d-flex align-items-center">
                                                <div class="col">
                                                    <div class="input-group" id="startDate" data-target-input="nearest">
                                                        <input type="text" class="form-control datetimepicker-input" name="startDate" data-target="#startDate" data-toggle="datetimepicker" autocomplete="off"/>
                                                        <div class="input-group-append" data-target="#startDate" data-toggle="datetimepicker">
                                                            <div class="input-group-text"><i class="far fa-calendar-alt"></i></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                ~
                                                <div class="col">
                                                    <div class="input-group" id="endDate" data-target-input="nearest">
                                                        <input type="text" class="form-control datetimepicker-input" name="endDate" data-target="#endDate" data-toggle="datetimepicker" autocomplete="off"/>
                                                        <div class="input-group-append" data-target="#endDate" data-toggle="datetimepicker">
                                                            <div class="input-group-text"><i class="far fa-calendar-alt"></i></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                            <label class="btn btn-outline-primary font-weight-normal active">
                                                <input type="radio" value="3" onclick="setRange(3)"> 3개월
                                            </label>
                                            <label class="btn btn-outline-primary font-weight-normal">
                                                <input type="radio" value="6" onclick="setRange(6)"> 6개월
                                            </label>
                                            <label class="btn btn-outline-primary font-weight-normal">
                                                <input type="radio" value="9" onclick="setRange(9)"> 9개월
                                            </label>
                                            <label class="btn btn-outline-primary font-weight-normal">
                                                <input type="radio" value="12" onclick="setRange(12)"> 1년
                                            </label>
                                            <label class="btn btn-outline-primary font-weight-normal">
                                                <input type="radio" value="12" onclick="setRange(0)" checked> 전체
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row align-items-center">
                                    <div class="col-md-4">
                                        <div class="form-group row">
                                            <div class="col-auto text-bold">발송구분</div>
                                            <div class="col">
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <input type="radio" id="smsType"
                                                           name="smsType" class="form-check-input" value="" ${empty search.smsType ? 'checked' : ''}>
                                                    <label class="form-check-label" for="smsType">전체</label>
                                                </div>

                                                <tags:enum-code code="SmsType"/>
                                                <c:forEach items="${enumCode}" var="option" varStatus="i">
                                                    <div class="custom-control custom-radio custom-control-inline" >
                                                        <input type="radio" id="smsType${i.count}"
                                                               name="smsType" class="form-check-input" value="${option.code}"
                                                            ${option.code eq search.smsType.code ? 'checked' : ''}>
                                                        <label class="form-check-label"
                                                               for="smsType${i.count}">${option.value}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <div class="col-auto text-bold">발송상태</div>
                                            <div class="col">
                                                <%--                                                <c:set var="options" value="${enumCode}"/>--%>
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <input type="radio" id="smsStatus"
                                                           name="smsStatus" class="form-check-input" value="" ${empty search.smsStatus ? 'checked' : ''}>
                                                    <label class="form-check-label" for="smsStatus">전체</label>
                                                </div>
                                                <tags:enum-code code="SmsStatus"/>
                                                <c:forEach items="${enumCode}" var="option" varStatus="i">
                                                    <div class="custom-control custom-radio custom-control-inline" >
                                                        <input type="radio" id="smsStatus${i.count}"
                                                               name="smsStatus" class="form-check-input" value="${option.code}"
                                                            ${option.code eq search.grade.code ? 'checked' : ''}>
                                                        <label class="form-check-label"
                                                               for="smsStatus${i.count}">${option.value}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-8">
                                        <div class="form-group row align-items-center">
                                            <div class="col-auto text-bold">검색어</div>
                                            <div class="col">
                                                <div class="input-group">
                                                    <div class="input-group col-md-8 px-0">
                                                        <div class="input-group-prepend">
                                                            <select name="searchType" class="custom-select">
                                                                <option value="" ${empty search.searchType ? 'selected' : ''}>전체</option>
                                                                <option value="to" ${search.searchType eq 'to' ? 'selected' : ''}>수신번호</option>
                                                                <option value="name" ${search.searchType eq 'name' ? 'selected' : ''}>이름</option>
                                                                <option value="message" ${search.searchType eq 'message' ? 'selected' : ''}>메시지</option>
                                                            </select>
                                                        </div>
                                                        <input type="text" class="form-control" id="f-1"
                                                               name="keyword" value="${search.keyword}"
                                                               placeholder="검색어를 입력하세요.">
                                                        <div class="input-group-append">
                                                            <button class="btn btn-outline-secondary"
                                                                    type="submit">검색
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </form>
                        </div>
                    </div>
                    <%-- // 검색필터 --%>
                    <div class="card card-light">
                        <div class="card-header border-transparent py-2">
                            <div class="row">
                                <div class="col-auto mr-auto">
                                    <div class="form-inline">
                                        <div class="form-group w-100 mb-0">
                                            <%@ include file="/WEB-INF/view/common/view-datatable-page-size.jsp" %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table id="dataTable" class="table table-sm table-bordered table-striped m-0" style="border-collapse: collapse !important;">
                                    <thead>
                                    <tr class="text-center text-nowrap">
                                        <th>#</th>
                                        <th>발송구분</th>
                                        <th>발신번호</th>
                                        <th>수신자</th>
                                        <th>수신번호</th>
                                        <th>메시지</th>
                                        <th>상태</th>
                                        <th>발송일</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer d-flex">
                            <div class="col-sm-2 d-sm-block d-none align-self-center">
                                {{pageView(page.number, page.size, page.numberOfElements, page.totalElements)}}
                            </div>
                            <ul class="col-12 col-sm-8 pagination justify-content-center m-0">
                                <datatable-pagination-component class="d-none d-sm-flex" :page="page" :page-item-number="9" v-on:fetch="paging"></datatable-pagination-component>
                                <datatable-pagination-component class="d-sm-none d-flex" :page="page" :page-item-number="5" v-on:fetch="paging"></datatable-pagination-component>
                            </ul>
                        </div>
                    </div>
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
        data: {
            page: {},
            number: 0
        },
        methods: {
            setPagination: function (page) {
                this.page = page;
                this.number = page.number;
            },
            paging: function (pageNumber) {
                dataTable.page(pageNumber).draw('page');
            }
        }
    });

</script>
<script>
    $(function () {
        dataTable = $('#dataTable').DataTable($.extend(true, dataTableOption, {
            ajax: {url: '/admin/module/sms-history/list' + getSearch()},
            order: [[0, "desc"]],
            columns: [
                {data: 'id', className: 'text-center'},
                {data: 'type', className: 'text-center', render: function (data) { return data.value }},
                {data: 'from', className: 'text-center', render: function (data) { return data }},
                {data: 'name', className: 'text-center', render: function (data) { return data }},
                {data: 'to', className: 'text-center', render: function (data) { return data }},
                {data: 'message', className: 'text-center', render: function (data) { return data }},
                {data: 'status', className: 'text-center', render: function (data) { return data.value }},
                {data: 'createdDate', className: 'text-center', render: function (data) { return dateFormat(data) }}
            ]
        }));

        dataTable.on('xhr', function (val) {
            vm.setPagination(dataTable.ajax.json().page);
        })

        $('form').submit(function (event) {
            event.preventDefault();
            dataTable.ajax.url(contextPath + '/admin/module/sms-history/list' + getSearch()).load();
        });

        initDatePicker();

    })

    function initDatePicker() {
        $('#startDate').datetimepicker($.extend(true, dateTimePickerGlobalConfig,
            {format: 'YYYY-MM-DD', useCurrent: false}));
        $("#startDate").on("change.datetimepicker", function (e) {
            $('#endDate').datetimepicker('minDate', e.date);
        });

        $('#endDate').datetimepicker($.extend(true, dateTimePickerGlobalConfig,
            {format: 'YYYY-MM-DD', useCurrent: false}));
        $("#endDate").on("change.datetimepicker", function (e) {
            $('#startDate').datetimepicker('maxDate', e.date);
        });
    }

    function setRange(value) {
        if (value === 0) {
            setFrom('');
            setTo('');
        } else {
            setFrom(moment().subtract(value, 'month').format('YYYY-MM-DD'));
            setTo(moment().format('YYYY-MM-DD'));
        }
    }

    function setFrom(val) {
        $('input[name="startDate"]').val(val);
    }

    function setTo(val) {
        $('input[name="endDate"]').val(val);
    }
</script>
