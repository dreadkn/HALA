<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/common/vue-datatable-pagination.jsp"/>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">제주인명 목록</h4>
                </div>
                <div class="d-none col-sm-6 d-md-block">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">제주인명 관리</li>
                        <li class="breadcrumb-item active">제주인명 관리</li>
                        <li class="breadcrumb-item active">제주인명 목록</li>
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
                                                            <img src="/resources/img/admin/ic_search.png" type="submit" >
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
                            <button class="btn btn-outline-danger" @click="deleteByChecked"><i class="far fa-trash-alt"></i> 선택 삭제</button>
                            <button type="button" class="btn btn-primary " @click="write">제주인명 등록</button>
                            <div class="d-inline-block">
                                <div class="d-flex align-items-center ">
                                    <button class="btn btn-success " @click="isUploadVisible = !isUploadVisible">엑셀등록</button>
                                    <div v-show="isUploadVisible">
                                        <div class="row justify-content-end " >
                                            <form id="write-form" action="/admin/human/upload/excel" method="post"  enctype="multipart/form-data">
                                                <div class="d-flex align-items-center">
                                                    <input type="file" id="excelFile" class="w95" name="excelFile" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" required>
                                                    <button class="btn btn-outline-dark"  >업로드</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
                                            <th class="align-middle">
                                                <label class="checkbox-wrap mx-3">
                                                    <input type="checkbox" v-model="selectAll" @click="selectionAll">
                                                    <span class="checkmark"></span>
                                                </label>
                                            </th>
                                            <th class="align-middle">#</th>
                                            <th class="align-middle">이름(국문)</th>
                                            <th class="align-middle">공개여부</th>
                                            <th class="align-middle">등록자</th>
                                            <th class="align-middle">등록일</th>
                                            <th class="align-middle">조회수</th>
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
            $('#write-form').ajaxFormData({
                success: function(msg){
                    if (msg.result == 'fail')
                        errorToastr(msg.message);
                    else
                    {
                        successToastr('등록되었습니다.');
                        setTimeout(function(){
                            location.reload();
                        },1500);
                    }
                }
            });
        },
        data: {
            allChecked: false,
            page: {},
            pageNumber: 0,
            selected: [],
            selectAll: false,
            isUploadVisible: false,
        },
        watch: {
        },
        computed: {

        },
        methods: {
            write: function () {
                location.href = contextPath + "/admin/human/form";
            },
            addCheck: function (id) {
                var self = this;
                alertConfirm(function(result){
                    if (result)
                    {
                        axios.get(contextPath + "/admin/human/check/" + id, {data: {}}).then(function (data) {
                            alertSuccess('검수 추가 되었습니다.');
                        }).catch(function (err) {
                            errorToastr("검수 추가중 오류가 발생하였습니다.");
                        });
                    }
                },'검수 추가', '검수 추가 하시겠습니까?', '추가', '취소');

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
                            axios.delete("/admin/human/" + id, {data: {}}).then(function (res) {
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
        }
    });

</script>
<script>
    $(function () {
        dataTable = $('#dataTable').DataTable($.extend(true, dataTableOption, {
            dom: "<'row'<'col-sm-12'tr>>",
            ajax: {url: '/admin/human/list'},
            order: [[1, "desc"]],
            columns: [
                {
                    data: 'id',
                    searchable: false,
                    orderable: false,
                    width: '2%',
                    className: 'text-center',
                    render: function (data){
                        return '<label class="checkbox-wrap mx-3">'
                            + '<input type="checkbox" value="'+data+'" onClick="vm.check(this)" name="chk">'
                            + '<span class="checkmark"></span></label>';
                    }
                },
                {data: 'id', className: 'text-center'},
                {data: 'krName', className: 'text-center'},
                {data: 'isPublic', className: 'text-center', render(data){
                    return data ? '공개' : '비공개';
                    }},
                {data: 'name', className: 'text-center'},
                {data: 'createdDate', className: 'text-center', render(data){
                        return dateFormat(data);
                    }},
                {data: 'readCount', className: 'text-center'},
                {data: null, className: 'text-center', orderable: false, render: function (data, type, row) {
                    var url = contextPath + "/admin/human/" + row.id;
                    return "<button class='btn btn-sm btn-outline-primary row-detail mr-1 text-nowrap' onclick='location.href=\""+url+"\"'>상세</button>"
                        + "<button class='btn btn-sm btn-outline-primary row-detail-window mr-1 text-nowrap' onclick='window.open(\""+url+"\")'>새창</button>"
                        + "<button class='btn btn-sm btn-outline-primary row-detail-window text-nowrap' onclick='vm.addCheck(\""+row.id+"\")'>검수추가</button>";
                }}
            ]
        }));

        dataTable.on('xhr', function (val) {
            vm.setPagination(dataTable.ajax.json().page);
        })

        $('form').submit(function (event) {
            event.preventDefault();
            dataTable.ajax.url(contextPath + '/admin/human/list' + getSearch()).load();
        });

    })

</script>