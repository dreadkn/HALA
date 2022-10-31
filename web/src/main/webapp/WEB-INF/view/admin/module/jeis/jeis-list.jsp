<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/common/vue-datatable-pagination.jsp"/>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">팝업 목록</h4>
                </div>
                <div class="d-none col-sm-6 d-md-block">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">팝업 관리</li>
                        <li class="breadcrumb-item active">팝업 관리</li>
                        <li class="breadcrumb-item active">팝업 목록</li>
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
                        <div class="card-header card-header-line">
                            <h3 class="card-title">검색 필터</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body pt-2 pb-1">
                            <form>
                                <div class="row align-items-center">

                                    <div class="col-md-8">
                                        <div class="form-group row align-items-center">
                                            <div class="col-auto text-bold">검색어</div>
                                            <div class="col">
                                                <div class="input-group">
                                                    <div class="input-group col-md-8">
                                                        <div class="input-search">
                                                            <input type="text" class="form-control" id="f-1" name="keyword" value="" placeholder="검색어를 입력하세요.">
                                                            <img src="/resources/img/ic_search.png" type="submit" >
                                                        </div>
                                                        <div class="input-group-append">
                                                            <button class="btn btn-dark" type="submit">검색 </button>
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

                    <%--action bar--%>
                    <div class="row mt-5 mb-3">
                        <div class="col-auto mr-auto">
                            <div class="form-inline">
                                <div class="form-group w-100 mb-0">
                                    <%@ include file="/WEB-INF/view/common/view-datatable-page-size.jsp" %>
                                </div>
                            </div>
                        </div>
                        <div class="col-auto">
                        </div>
                    </div>

                    <%--data table--%>
                    <div class="card card-light">
                        <div class="card-header card-header-line p-0"></div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table id="dataTable" class="table table-sm table-bordered table-striped m-0" >
                                    <thead>
                                        <tr class="text-center text-nowrap">
                                            <th class="align-middle">#</th>
                                            <th class="align-middle">분류</th>
                                            <th class="align-middle">공고명</th>
                                            <th class="align-middle">접수시작일</th>
                                            <th class="align-middle">접수종료일</th>
                                            <th class="align-middle">접수여부</th>
                                            <th class="align-middle"></th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer d-flex">
                            <div class="col-sm-2 d-sm-block d-none align-self-center">
                                {{pageView(page.number, page.size, page.numberOfElements, page.totalElements)}}
                            </div>
                            <ul class="col-12 col-sm-8 pagination justify-content-center m-0">
                                <datatable-pagination-component :page="page" :page-item-number="9" v-on:fetch="paging"></datatable-pagination-component>
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
        mounted: function () {
            this.fetchCateogry();
        },
        data: {
            allChecked: false,
            page: {},
            pageNumber: 0,
            selected: [],
            selectAll: false,
            categories: [],
            cate : '',
        },
        watch: {
            cate : function() {
                $('title').text('JTP-기업지원정보 ' + this.cate);
            },
            categories: function(){

            }
        },
        computed: {

        },
        methods: {
            write: function () {
                location.href = contextPath + "/admin/module/jeis/form";
            },
            setPagination: function (page) {
                this.page = page;
                this.number = page.number;
            },
            paging: function (pageNumber) {
                dataTable.page(pageNumber).draw('page');
            },
            selectionAll: function() {
                var self = this;
                this.selected = [];
                if (!this.selectAll) {
                    $(this.page.content).each(function(){
                        self.selected.push(this.id);
                        var targetId = this.id;
                        $('[name=chk]').each(function(){
                            if (this.value == targetId)
                                $(this).prop('checked', true);
                        });
                    });
                }
                else
                {
                    $('[name=chk]').each(function(){
                        $(this).prop('checked', false);
                    });
                }
            },
            check : function(el) {
                if ($(el).is(':checked'))
                {
                    this.selected.push(el.value);
                }
                else
                {
                    this.selected.splice($.inArray(el.value, this.selected),1);
                }
            },
            deleteByChecked : function() {
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        var chkLength = self.selected.length;
                        var chkCnt = 0;
                        self.selected.forEach(function(id){
                            axios.delete("/admin/module/popup/" + id, {data: {}}).then(function (res) {
                                if (++chkCnt >= chkLength)
                                {
                                    alertDeleted();
                                    setTimeout(function () {
                                        location.reload();
                                    },1500);
                                }
                            }).catch(function (err) {
                                errorToastr('삭제중 오류가 발생하였습니다.');
                            });
                        });
                    }
                });
            },
            getPageItemNumber : function(){
                return window.outerWidth < 768 ? 3 : 9
            },
            fetchCateogry: function(){
                var self = this;
                axios.get(contextPath + "/admin/module/jeis/category", {data: {}}).then(function (data) {
                    var list = data.data;
                    list.forEach(function(item){
                        item.isActive = false;
                        item.cate = self.htmlDecode(item.cate);
                    });

                    self.categories = list;
                    self.categories.unshift({
                        cate : '전체',
                        code : '',
                        isActive : true
                    });
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            htmlDecode : function (input) {
                var doc = new DOMParser().parseFromString(input, "text/html");
                return doc.documentElement.textContent;
            },
            dateDiffOfToday : function(date) {

                var targetDate = new Date(dateFormat(date, 'YYYY-MM-DD HH:mm'));

                var today = new Date();
                var diff = targetDate.getTime() - today.getTime();

                diff = Math.ceil(diff / (1000 * 3600 * 24));

                return diff;
            },
            getCategoryName: function(code){
                let cate = this.categories.filter(function(cate){ return cate.code == code});
                return cate.length > 0 ? cate[0].cate : '';
            },
            getCategoryCode: function(name){
                let cate = this.categories.filter(function(cate){ return cate.cate == name});
                return cate.length > 0 ? cate[0].code : '';
            },
            dateFormat: function (date) {
                return dateFormat(date, 'YYYY-MM-DD');
            },
            datetimeFormat: function (date) {
                return dateFormat(date, 'YYYY-MM-DD HH:mm');
            },
            getTimeToHM : function(time, defTime){
                if (time == null)
                    return defTime;

                time = String(time);

                if (time.length == 3)
                    time = '0' + time;

                return time.substr(0,2) + ':' + time.substr(2);
            },
            memorizeSearch : function(){
                setCookie('page', this.pageNumber, 1);
                setCookie('cate', this.htmlDecode(this.cate), 1);
                setCookie('keyword', this.keyword, 1);
            },
            restoreSearch : function(){
                this.pageNumber = getCookie('page');
                this.cate = getCookie('cate');
                this.keyword = getCookie('keyword');
                $('[name=keyword]').val(getCookie('keyword'));
            },
            openDetail: function (id) {
                location.href = 'admin/module/jeis/detail/' + id
            },
            isNew : function(date){
                let diff = this.dateDiffOfToday(date);
                return Math.abs(diff) < 8 ? true : false;
            },
            isHit : function(){
                /**
                 * todo : read count after
                 */

            },
            isHot : function(){
                /**
                 * todo : read count after
                 */

            },
        }
    });

</script>
<script>
    $(function () {
        dataTable = $('#dataTable').DataTable($.extend(true, dataTableOption, {
            dom: "<'row'<'col-sm-12'tr>>",
            ajax: {url: '/admin/module/jeis/list'},
            order: [[1, "desc"]],
            columns: [
                {data: 'anno_id', className: 'text-center'},
                {data: 'business_div_name', className: 'text-center', render(data){
                    return vm.htmlDecode(data);
                    }},
                {data: 'anno_name', className: 'text-center', render(data){
                        return vm.htmlDecode(data);
                    }},
                {data: 'receipt_s_date', className: 'text-center', render(data){
                        return vm.dateFormat(data);
                    }},
                {data: 'receipt_e_date', className: 'text-center', render(data, type, row){
                        return vm.datetimeFormat(data + ' ' + row.receipt_e_hour + ':' + row.receipt_e_minute);
                    }},
                {data: 'receipt_e_date', className: 'text-center', render(data, type, row){
                        return vm.dateDiffOfToday(data +' '+ vm.getTimeToHM(row.receipt_e_time, '18:00')) > 0 ? '신청가능' : '신청마감';
                    }},
                {data: null, className: 'text-center', orderable: false, render: function (data, type, row) {
                    var url = contextPath + "/admin/module/jeis/detail/" + row.anno_id;
                    return "<button class='btn btn-sm btn-outline-primary row-detail mr-1 text-nowrap' onclick='location.href=\""+url+"\"'>상세</button>"
                        + "<button class='btn btn-sm btn-outline-primary row-detail-window text-nowrap' onclick='window.open(\""+url+"\")'>새창</button>";
                }}
            ]
        }));

        dataTable.on('xhr', function (val) {
            vm.setPagination(dataTable.ajax.json().page);
        })

        $('form').submit(function (event) {
            event.preventDefault();
            dataTable.ajax.url(contextPath + '/admin/module/jeis/list' + getSearch()).load();
        });

    })

</script>
