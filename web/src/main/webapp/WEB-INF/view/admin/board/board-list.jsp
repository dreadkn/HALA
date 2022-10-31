<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="./component/board-modal-component.jsp"/>

<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">게시판 관리</h4>
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
                                    <div class="col">
                                        <div class="form-group row">
                                            <div class="col-auto text-bold">게시판 유형</div>
                                            <div class="col">
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <input type="radio" id="grade"
                                                           name="grade" class="form-check-input"
                                                           value="" ${empty search.grade ? 'checked' : ''}>
                                                    <label class="form-check-label" for="grade">전체</label>
                                                </div>

                                                <tags:enum-code code="BoardType"/>
                                                <c:forEach items="${enumCode}" var="option" varStatus="i">
                                                    <div class="custom-control custom-radio custom-control-inline">
                                                        <input type="radio" id="boardType${i.count}"
                                                               name="boardType" class="form-check-input"
                                                               value="${option.code}"
                                                            ${option.code eq search.boardType.code ? 'checked' : ''}>
                                                        <label class="form-check-label"
                                                               for="boardType${i.count}">${option.value}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row align-items-center">
                                    <div class="col-md-6">
                                        <div class="form-group row align-items-center">
                                            <div class="col-auto text-bold">검색어</div>
                                            <div class="col">
                                                <div class="input-group">
                                                    <div class="input-group col-md-8">
                                                        <input type="text" class="form-control" id="search"
                                                               name="keyword" value="${search.keyword}" autofocus
                                                               placeholder="검색어를 입력하세요.">
                                                        <div class="input-group-append">
                                                            <button class="btn btn-primary"
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
                                            <%@ include file="/WEB-INF/view/common/view-page-size.jsp" %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <auth:authorize method="c">
                                    <button type="button" class="btn btn-primary" data-toggle="modal"
                                            data-target="#boardModal">등록
                                    </button>
                                    </auth:authorize>
                                </div>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div id="vue-app" class="card-body p-0">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                            <tr role="row" class="text-center" style="word-break: keep-all">
                                                <th style="width: 5%">#</th>
                                                <th>타입</th>
                                                <th>게시판명</th>
                                                <th>비밀글 사용여부</th>
                                                <th>답변 사용여부</th>
                                                <th>댓글 사용여부</th>
                                                <th>익명 쓰기 가능여부</th>
                                                <th>에디터 사용 여부</th>
                                                <th>파일업로드 여부</th>
                                                <th>파일업로드 갯수</th>
                                                <th>활성화 여부</th>
                                                <th>등록일</th>
                                                <th></th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${page.content}" var="item" varStatus="i">
                                                <tr id="${item.id}" class="text-center item-row" style="cursor: pointer"
                                                    @click="selectRow($event, '${item.id}')">
                                                    <td><tags:row-number sort="desc" pageNumber="${page.number}"
                                                                         pageSize="${page.size}"
                                                                         totalElements="${page.totalElements}"
                                                                         count="${i.count}"/></td>
                                                    <td>${item.type.value}</td>
                                                    <td>${item.name}</td>
                                                    <td>${item.enableSecret ? 'Y' : 'N'}</td>
                                                    <td>${item.enableReply ? 'Y' : 'N'}</td>
                                                    <td>${item.enableComment ? 'Y' : 'N'}</td>
                                                    <td>${item.enableWriteAnonymousUser ? 'Y' : 'N'}</td>
                                                    <td>${item.enableEditor ? 'Y' : 'N'}</td>
                                                    <td>${item.enableFileUpload ? 'Y' : 'N'}</td>
                                                    <td>${item.uploadableNumberOfFiles}</td>
                                                    <td>${item.enable ? 'Y' : 'N'}</td>
                                                    <td><javatime:format value="${item.createdDate}"
                                                                         pattern="yyyy-MM-dd HH:mm"/></td>
                                                    <td class="py-2"><button type="button" class="btn btn-sm btn-outline-primary" @click="goArticles(${item.id})">게시판 바로 가기</button></td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty page.content}">
                                                <tr>
                                                    <td colspan="12" class="text-center">데이터가 없습니다.</td>
                                                </tr>
                                            </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <board-modal-form-component ref="modal" :type="boardTypes"></board-modal-form-component>
                        </div>
                        <div class="card-footer">
                            <ul class="pagination justify-content-center m-0">
                                <tags:pagination pageViewCount="9" number="${page.number}" totalPages="${page.totalPages}"/>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    <tags:enum-code code="BoardType"/>
    var boardTypes = ${enumJson};
    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'board-modal-form-component': boardModalFormComponent
        },
        data: {
            boardTypes: boardTypes,
            message: 'msg'
        },
        mounted: function () {
        },
        methods: {
            selectRow: function (event, id) {
                if (event.target.type !== 'button') {
                    this.getDetail(id);
                }
            },
            getDetail: function (id) {
                var self = this;
                $.ajax(contextPath + "/admin/boards/" + id, {
                    type: 'get',
                    contentType: 'application/json'
                })
                .done(function (data) {
                    self.$refs.modal.openDetail(data);
                })
                .fail(function (data) {
                    errorToastr("게시판 조회에 실패하였습니다.");
                })
            },
            clearModalForm: function () {
                this.$refs.modal.clearModalForm();
            },
            goArticles: function (boardId) {
                location.href='/admin/boards/' + boardId;
            }
        }

    });
</script>
<script>
    $(function () {
        $('form').submit(function (event) {
            event.preventDefault();
            var uri = new URI(window.location);
            $('form').serializeArray().forEach(function (o) {
                uri.setSearch(o.name, o.value);
            })
            location.href = uri;
        });

        $('#boardModal').on('hidden.bs.modal', function (e) {
            vm.clearModalForm();
        })
    })
</script>
