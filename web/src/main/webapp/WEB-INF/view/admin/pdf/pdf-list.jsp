<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/common/vue-datatable-pagination.jsp"/>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">PDF Sample</h4>
                </div>
                <div class="d-none col-sm-6 d-md-block">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">PDF Sample</li>
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
                    <div class="row mt-5 mb-3">
                        <div class="col-auto">
                            <button type="button" class="btn btn-primary " @click="makePdf">PDF 생성</button>
                            <button type="button" class="btn btn-primary " @click="makePdfImage">PDF > 이미지 테스트</button>
                        </div>
                    </div>
                    <div class="row mt-5 mb-3">
                        <div class="col-auto">
                            storePath/config/ 경로 내 'NanumGothic.ttf', 'NanumMyeongjo.ttf' 필수
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
                                        <th class="align-middle">pdf명</th>
                                        <th class="px-1">등록일</th>
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

        },
        data: {
            allChecked: false,
            page: {},
            pageNumber: 0,
            selected: [],
            selectAll: false
        },
        watch: {
        },
        computed: {

        },
        methods: {
            makePdf: function () {
                var self = this;
                axios.get("/admin/mng/pdf/make", {data: {}}).then(function (res) {

                    console.log(res);
                    setTimeout(function () {
                        successToastr('PDF 생성이 완료되었습니다.')
                        location.reload();
                        // location.href = '/files/' + res.data.id;
                    }, 1500);
                }).catch(function (err) {
                    errorToastr('오류가 발생하였습니다.');
                });
            },
            makePdfImage: function () {
                axios.get("/admin/mng/pdf/make/image", {data: {}}).then(function (res) {

                    console.log(res);
                    setTimeout(function () {
                        successToastr('완료되었습니다.')

                    }, 1500);
                }).catch(function (err) {
                    errorToastr('오류가 발생하였습니다.');
                });
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

                deleteConfirm(function (result) {
                    if (result) {
                        var chkLength = self.selected.length;
                        var chkCnt = 0;
                        self.selected.forEach(function (id) {
                            axios.delete("/admin/mng/admin/" + id, {data: {}}).then(function (res) {
                                if (++chkCnt >= chkLength) {
                                    alertDeleted();
                                    setTimeout(function () {
                                        location.reload();
                                    }, 1500);
                                }
                            }).catch(function (err) {
                                errorToastr('삭제중 오류가 발생하였습니다.');
                            });
                        });
                    }
                });
            }
        }
    });

</script>
<script>
    $(function () {
        dataTable = $('#dataTable').DataTable($.extend(true, dataTableOption, {
            dom: "<'row'<'col-sm-12'tr>>",
            ajax: {url: '/admin/mng/pdf/list'},
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
                {data: 'name', className: 'text-center'},
                {data: 'createdDate', className: 'text-center', render(data){
                        return dateFormat(data);
                    }},
                {data: null, className: 'text-center', orderable: false, render: function (data, type, row) {
                        var url = contextPath + "/admin/mng/pdf/" + row.id;
                        return "<button class='btn btn-sm btn-outline-primary row-detail mr-1 text-nowrap' onclick='location.href=\""+url+"\"'>상세</button>"
                            + "<button class='btn btn-sm btn-outline-primary row-detail-window text-nowrap' onclick='window.open(\"/files/"+row.file.id+"\")'>다운로드</button>";
                    }}
            ]
        }));

        dataTable.on('xhr', function (val) {
            vm.setPagination(dataTable.ajax.json().page);
        })
    })

</script>
