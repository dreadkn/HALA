<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="./component/account-modal-component.jsp"/>

<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">계정 관리</h4>
                </div>
                <%--<div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">고객정보관리</li>
                        <li class="breadcrumb-item active">계정관리</li>
                    </ol>
                </div>--%>
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
                                    <div class="col-auto">
                                        <div class="form-group row">
                                            <div class="col-auto text-bold">계정상태</div>
                                            <div class="col">
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <input type="radio" id="enabled"
                                                           name="enabled" class="form-check-input" value="" ${empty search.enabled ? 'checked' : ''}>
                                                    <label class="form-check-label" for="enabled">전체</label>
                                                </div>

                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <input type="radio" id="enabled1"
                                                           name="enabled" class="form-check-input" value="true" ${!empty search.enabled && search.enabled ? 'checked' : ''}>
                                                    <label class="form-check-label" for="enabled1">정상</label>
                                                </div>
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <input type="radio" id="enabled2"
                                                           name="enabled" class="form-check-input" value="false" ${!empty search.enabled && !search.enabled ? 'checked' : ''}>
                                                    <label class="form-check-label" for="enabled2">차단</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-8">
                                        <div class="form-group row align-items-center">
                                            <div class="col-auto text-bold">검색어</div>
                                            <div class="col">
                                                <div class="input-group">
                                                    <div class="input-group col-md-8">
                                                        <%--<div class="input-group-prepend">
                                                            <select name="searchType" class="custom-select">
                                                                <option value="">전체</option>
                                                                <option value="userId">아이디</option>
                                                                <option value="name">회원명</option>
                                                                <option value="phone">연락처</option>
                                                                <option value="cardNo">카드번호</option>
                                                            </select>
                                                        </div>--%>
                                                        <input type="text" class="form-control" id="search"
                                                               name="keyword" value="${search.keyword}" autofocus
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
                                            <%@ include file="/WEB-INF/view/common/view-page-size.jsp" %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#accountModal">등록</button>
                                </div>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div id="vue-app" class="card-body p-0">
                            <div class="row">
                                <div class="col-md-12">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                        <tr role="row" class="text-center">
                                            <th style="width: 5%">#</th>
                                            <th>권한</th>
                                            <th>아이디</th>
                                            <th>이름</th>
                                            <th>이메일</th>
                                            <th>전화번호</th>
                                            <th>계정상태</th>
                                            <th>등록일</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${page.content}" var="item" varStatus="i">
                                            <tr id="${item.id}" class="text-center item-row" style="cursor: pointer" @click="selectRow('${item.userId}')">
                                                <td><tags:row-number sort="desc" pageNumber="${page.number}" pageSize="${page.size}" totalElements="${page.totalElements}" count="${i.count}"/></td>
                                                <td>${item.adminType.value}</td>
                                                <td>${item.userId}</td>
                                                <td>${item.name}</td>
                                                <td>${item.email}</td>
                                                <td><tags:format-phone value="${item.phone}"/></td>
                                                <td>${item.enabled ? '정상' : '차단'}</td>
                                                <td><javatime:format value="${item.createdDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty page.content}">
                                            <tr>
                                                <td colspan="8" class="text-center">데이터가 없습니다.</td>
                                            </tr>
                                        </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <modal-form-component ref="modal"></modal-form-component>
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
    // Root
    var vm = new Vue({
        el: '#vue-app',
        data: {
            message: 'msg'
        },
        mounted: function () {
        },
        methods: {
            selectRow: function (userId) {
                this.getDetail(userId);
            },
            getDetail: function (userId) {
                var self = this;
                jQuery.get(contextPath + "/admin/account/" + userId)
                .done(function (data) {
                    self.$refs.modal.openUserDetail(data);
                })
                .fail(function (data) {
                    errorToastr(userId + " 계정 조회에 실패하였습니다.");
                })
            },
            clearModalForm: function () {
                this.$refs.modal.clearModalForm();
            }

        }

    });
</script>
<script>
    $(function() {
        $('form').submit(function (event) {
            event.preventDefault();
            var uri = new URI(window.location);
            $('form').serializeArray().forEach(function (o) {
                uri.setSearch(o.name, o.value);
            })
            location.href = uri;
        });

        $('#viewPageSize').change(function () {
            var uri = new URI(window.location);
            uri.setSearch("size", $('#viewPageSize').val());
            location.href = uri;
        });

        $('#accountModal').on('hidden.bs.modal', function (e) {
            vm.clearModalForm();
        })
    })
</script>
