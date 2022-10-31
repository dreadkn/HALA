<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/common/vue-pagination.jsp"/>

<script type="text/x-template" id="user-new-search-component">
    <div class="modal fade" id="userNewSearchModal" data-backdrop="static" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalFormLabel">주소 그룹</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid address-wrap">
                        <form onsubmit="return false;">
                            <div class="form-row">
                                <div class="col-12">
                                    <div class="card card-light">
                                        <div class="card-header">
                                            <h3 class="card-title">회원 검색</h3>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-minus"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body pt-2 pb-1">
                                            <div class="row align-items-center">
                                                <div class="col-auto">
                                                    <div class="form-group row align-items-center">
                                                        <div class="col-auto text-bold">회원구분</div>
                                                        <div class="col">
                                                            <div class="custom-control custom-radio custom-control-inline">
                                                                <input type="radio" id="grade" name="grade" class="form-check-input" value="" v-model="grade">
                                                                <label class="form-check-label" for="grade">전체</label>
                                                            </div>
                                                            <tags:enum-code code="MemberClassType"/>
                                                            <c:forEach items="${enumCode}" var="option" varStatus="i">
                                                                <div class="custom-control custom-radio custom-control-inline">
                                                                    <input type="radio" id="grade${i.count}" name="grade" class="form-check-input" value="${option.code}" v-model="grade">
                                                                    <label class="form-check-label" for="grade${i.count}">${option.value}</label>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <div class="form-group row align-items-center">
                                                        <div class="col-auto text-bold">회원검색 그룹</div>
                                                        <div class="col">
                                                            <div class="custom-control custom-radio custom-control-inline">
                                                                <input type="radio" id="searchCode" name="searchCode" class="form-check-input" value="" v-model="searchCode">
                                                                <label class="form-check-label" for="searchCode">전체</label>
                                                            </div>
                                                            <div class="custom-control custom-radio custom-control-inline" v-for="(item, idx) in codeList.searchCodes">
                                                                <input type="radio" :id="'searchCode' + idx" name="searchCode" class="form-check-input" :value="item.name" v-model="searchCode">
                                                                <label class="form-check-label" :for="'searchCode' + idx">{{item.name}}</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <div class="form-group row align-items-center">
                                                        <div class="col-auto text-bold">시도</div>
                                                        <div class="col-auto">
                                                            <select class="custom-select" name="sido" @change="fetchSigugun" v-model="sido">
                                                                <option value="" selected>전체</option>
                                                                <option v-for="item in sidoList" :value="item">{{item}}</option>
                                                            </select>
                                                        </div>
                                                        <template v-if="sido != '세종특별자치시'">
                                                            <div class="col-auto text-bold">시군구</div>
                                                            <div class="col-auto">
                                                                <select class="custom-select" name="sigugun" @change="fetchDongmyun" v-model="sigugun">
                                                                    <option value="" selected>전체</option>
                                                                    <option v-for="item in sigugunList" :value="item">{{item}}</option>
                                                                </select>
                                                            </div>
                                                        </template>
                                                        <div class="col-auto text-bold">읍면동</div>
                                                        <div class="col-auto">
                                                            <select class="custom-select" name="dongmyun" v-model="dongmyun">
                                                                <option value="" selected>전체</option>
                                                                <option v-for='item in dongmyunList' :value="item">{{item}}</option>
                                                            </select>
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
                                                                <div class="input-group-prepend">
                                                                    <select name="searchType" class="custom-select">
                                                                        <option value="">전체</option>
                                                                        <option value="id">DB ID</option>
                                                                        <option value="userId">아이디</option>
                                                                        <option value="name">회원명</option>
                                                                        <option value="phone">연락처</option>
                                                                    </select>
                                                                </div>
                                                                <input class="form-control w-75" id="f-1" name="keyword">
                                                                <div class="input-group-append">
                                                                    <button type="button" class="btn btn-outline-secondary" @click="fetch()">검색</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div class="row ">
                            <div class="col-6 overflow-auto">
                                <div class="card card-light">
                                    <div class="card-header p-1">
                                        <div class="row justify-content-between">
                                            <h3 class="card-title align-self-center pl-4">회원 검색 결과</h3>
                                            <div class="col-auto">
                                                <div class="form-inline">
                                                    <div class="form-group" v-if="searchMembers.length > 0">
                                                        <button type="button" class="btn btn-outline-primary" @click="allSelect">전체선택</button>
                                                        <button type="button" class="btn btn-outline-danger" @click="allSelectCancel">선택해제</button>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="w-100 mb-0">
                                                            <label for="size" class="sr-only">Show</label>
                                                            <select class="form-control custom-select w-100" id="size" v-model="size" @change="sizeChange">
                                                                <option value="50">50개씩 보기</option>
                                                                <option value="100">100개씩 보기</option>
                                                                <option value="200">200개씩 보기</option>
                                                                <option value="500">500개씩 보기</option>
                                                                <option value="1000">1000개씩 보기</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body p-0">
                                        <ul class="list-group person-list">
                                            <li class="list-group-item">
                                                <div class="form-group d-flex align-items-baseline" v-for="(item, idx) in searchMembers">
                                                    <input type="checkbox" class="mr-1" name="userId" :id="'member' + item.id" value="item.id" :disabled="item.disable" v-model="item.chk">
                                                    <label :for="'member' + item.id">{{item.name}} {{item.gradeObj.value}} {{item.phone}}</label>
                                                </div>
                                            </li>
                                            <li class="list-group-item" v-if="searchMembers.length == 0">
                                                <p>조회 결과가 없습니다.</p>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="card-footer d-flex">
                                        <div class="col-sm-2 d-sm-block d-none align-self-center">
                                            {{pageView(page.number, page.size, page.numberOfElements, page.totalElements)}}
                                        </div>
                                        <ul class="col-12 col-sm-8 pagination justify-content-center m-0">
                                            <pagination-component :page="page" :page-item-number="3" v-on:fetch="fetch"></pagination-component>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-1 d-flex align-items-center justify-content-center">
                                <button type="button" class="btn btn-outline-primary row-detail text-nowrap" @click="moveUser">추가 ></button>
                            </div>
                            <div class="col-5">
                                <div class="card card-light">
                                    <div class="card-header p-1 align-middle">
                                        <div class="row justify-content-between">
                                            <h3 class="card-title align-self-center pl-4">선택 회원 목록 ({{receivers.length}} 명)</h3>
                                            <div class="col-auto">
                                                <div class="form-inline">
                                                    <div class="form-group">
                                                        <button type="button" class="btn btn-outline-danger" @click="clearUser">전체삭제</button>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="card-tools">
                                                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                                <i class="fas fa-minus"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body p-0">
                                        <ul class="list-group person-list">
                                            <li class="list-group-item" v-for="item in receivers">
                                                <i class="far fa-times-circle" @click="deleteUser(item.id)"></i>
                                                <span>{{item.name}}</span>
                                                <span>{{item.gradeObj.value}}</span>
                                                <span>{{item.phone}}</span>
                                            </li>
                                            <li class="list-group-item" v-if="receivers.length == 0">
                                                <p>조회 결과가 없습니다.</p>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <div class="col-auto ml-auto">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" @click="addUser">확인</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>

<script>
    var userNewSearchComponent = {
        template: '#user-new-search-component',
        mounted: function () {
            this.fetchSido();
        },
        data: function () {
            return {
                searchMembers: [],
                receivers: [],
                grade: '',
                searchCode: '',
                rank: '',
                searchType: '',
                keyword: '',
                page: {},
                size: '50',
                number: 0,
                codeList: {},
                sidoList: [],
                sigugunList: [],
                dongmyunList: [],
                sido: '',
                sigugun: '',
                dongmyun: '',
            }
        },
        methods: {
            fetchSido: function () {
                var self = this;
                axios.get("/admin/members/region/sido", {data: {}}).then(function (res) {
                    self.sidoList = res.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchSigugun: function () {
                var self = this;
                self.sigugun = '';
                self.dongmyun = '';
                if (self.sido != '세종특별자치시') {
                    axios.get("/admin/members/region/sigugun?sido=" + self.sido, {data: {}}).then(function (res) {
                        self.sigugunList = res.data;
                    }).catch(function (err) {
                        errorToastr("조회중 오류가 발생하였습니다.");
                    });
                } else {
                    this.fetchDongmyun();
                }
            },
            fetchDongmyun: function () {
                var self = this;
                self.dongmyun = '';
                axios.get("/admin/members/region/dongmyun?sido=" + self.sido + "&sigugun=" + self.sigugun, {data: {}}).then(function (res) {
                    self.dongmyunList = res.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchCodeList: function () {
                var self = this;
                axios.get(contextPath + "/admin/sms/member/code", {data: {}}).then(function (res) {
                    self.codeList = res.data;
                }).catch(function (err) {
                    console.log(err);
                });
            },
            fetch: function (pageNumber) {
                var self = this;
                pageNumber = pageNumber == null ? this.page.number : pageNumber;
                var search = "?size=" + self.size + "&page=" + pageNumber + getSearch().replace("?", "&");
                axios.get(contextPath + "/admin/sms/member" + search, {data: {}}).then(function (res) {
                    self.page = res.data;
                    res.data.content = res.data.content.map(m => {
                        m.chk = self.receivers.some(value => m.id === value.id);
                        m.disable = false;
                        return m;
                    });
                    self.searchMembers = res.data.content;
                }).catch(function (err) {
                    errorToastr(err);
                });
            },
            open: function (selectedMembers) {
                this.fetchCodeList();
                var self = this;
                $('#userNewSearchModal').modal('show');
                var select = selectedMembers;
                self.receivers = select;
            },
            addUser: function () {
                var self = this;
                vm.addUserList(self.receivers);
                $('#userNewSearchModal').modal('hide');
            },
            allSelect: function () {
                var self = this;
                self.searchMembers = self.searchMembers.map(m => {
                    m.chk = true;
                    return m;
                })
            },
            clearUser: function () {
                var self = this;
                self.receivers = [];
                self.searchMembers = self.searchMembers.map(m => {
                    m.chk = self.receivers.some(value => m.id === value.id);
                    return m;
                })
            },
            allSelectCancel: function () {
                var self = this;
                self.searchMembers = self.searchMembers.map(m => {
                    m.chk = false;
                    return m;
                })
            },
            deleteUser: function (memberId) {
                var self = this;
                self.receivers = self.receivers.filter(function (member) {
                    return member.id != memberId;
                });

                self.searchMembers = self.searchMembers.map(m => {
                    m.chk = self.receivers.some(value => m.id === value.id);
                    return m;
                })
            },
            moveUser: function () {
                var self = this;
                var filter = self.searchMembers.filter(function (member) {
                    return member.chk === true && member.disable === false;
                });
                if (filter.length > 0) {
                    filter = filter.filter(function (member) {
                        var is = true;
                        $(self.receivers).each(function () {
                            if (member.id === this.id) {
                                is = false;
                            }
                        })
                        return is;
                    });
                    self.receivers = $.merge(self.receivers, filter);
                    self.receivers.push();
                }
            },
            clear: function () {
                this.searchMembers = [];
                this.receivers = [];
                this.grade = '';
                this.rank = '';
                this.searchType = '';
                this.keyword = '';
                this.page = {};
                this.size = '50';
                this.number = 0;
            },
            setPagination: function (page) {
                this.page = page;
                this.number = page.number;
            },
            paging: function () {
                this.fetch();
            },
            sizeChange: function (event) {
                this.size = event.target.value;
                this.fetch();
            }
        }
    }

    $(function () {
        $('#userNewSearchModal').on('hidden.bs.modal', function (e) {
            vm.$refs.userSearchModal.clear();
        })
    })
</script>
