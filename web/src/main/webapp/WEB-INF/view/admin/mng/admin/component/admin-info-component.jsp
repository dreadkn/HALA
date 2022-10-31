<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="admin-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">관리자 정보</h3>
            </div>
            <div class="tab-wrap">
                <ul class="nav nav-tabs">
                    <li class="nav-item" v-for="(tab, index) in tabs " >
                        <a class="nav-link " :class="{active:currentTab === index}" href="#" @click="currentTab = index" v-if="index == 0 || (index != 0 && isUpdate)">{{tab}}</a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="card-body" v-show="currentTab == 0">
            <form>

                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>관리자구분</label>
                            </div>
                            <div class="col-auto">
                                <select class="form-select" id="adminType" v-model="admin.adminType">
                                    <tags:enum-select code="AdminType"></tags:enum-select>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>아이디</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="text" class="form-control" id="userId" name="userId" v-model="admin.userId" required :readonly="isUpdate">
                                    <button class="btn btn-dark text-nowrap" type="button"  @click="checkOverlap" v-if="isNew">중복확인</button>
                                </div>
                                <div id="userIdError" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row" v-if="isNew">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>비밀번호</label>
                            </div>
                            <div class="col-auto">
                                <input type="password" class="form-control" id="password" v-model="admin.password"  required>
                                <div id="passwordError" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>관리자명</label>
                            </div>
                            <div class="col-auto">
                                <input type="text" class="form-control" id="name" v-model="admin.name"  required>
                                <div id="nameError" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>연락처</label>
                            </div>
                            <div class="col-auto">
                                <input type="text" class="form-control" id="phone" v-model="admin.phone"  required>
                                <div id="phoneError" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>이메일</label>
                            </div>
                            <div class="col-auto">
                                <input type="text" class="form-control" id="email" v-model="admin.email"  required>
                                <div id="emailError" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="zipCode"><small class="text-danger">*</small>주소</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <button class="btn btn-outline-secondary" type="button" id="button-addon1" @click="popupPostcode">주소 검색</button>
                            </div>
                            <input type="text" class="form-control" id="zipCode" name="zipCode" v-model="admin.zipCode" readonly>
                        </div>
                        <div id="zipCodeError" class="invalid-feedback"></div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="addressRoad">도로명 주소</label>
                        <input type="text" class="form-control" id="addressRoad" name="addressRoad" v-model="admin.addressRoad">
                        <div id="addressRoadError" class="invalid-feedback"></div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="addressJibun">지번 주소</label>
                        <input type="text" class="form-control" id="addressJibun" name="addressJibun" v-model="admin.addressJibun">
                        <div id="addressJibunError" class="invalid-feedback"></div>
                    </div>
                </div>
            </form>
        </div>
        <div class="card-footer" v-show="currentTab == 0">
            <div class="row ">
                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deleteAdmin">삭제</button></div>
                <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
            </div>
        </div>
    </div>
</script>

<script>

    var geocoder;

    var adminInfoComponent = {
        template: '#admin-info-component',
        mounted: function () {
            geocoder = new daum.maps.services.Geocoder();
        },
        watch: {
            admin : function(){
                this.admin.adminType = this.admin.adminType.code;
            }
        },
        computed: {
            isNew: function () {
                return this.$parent.id == null || this.$parent.id == '';
            },
            isUpdate: function () {
                return this.$parent.id != null && this.$parent.id != '';
            }
        },
        data: function () {
            return {
                admin: {
                    adminType: 'NORMAL',
                    userId: '',
                    password: '',
                    name: '',
                    phone: '',
                    email: '',
                    language1: 'ko',
                    language2: 'ko',
                    addressJibun: '',
                    addressRoad: '',
                    zipCode: ''
                },
                isOverlap: true,
                currentTab : 0,
                tabs : ['기본정보']
            }
        },
        methods: {
            checkOverlap : function(){
                var self = this;

                var admin = $.extend({}, self.admin);
                admin.adminType = self.admin.adminType.code;

                axios.post("/admin/mng/admin/check/overlap/" + admin.userId, {}).then(function (res) {
                    if (res.data)
                        errorToastr('사용 불가능한 아이디입니다.');
                    else
                        successToastr('사용 가능한 아이디입니다.');

                    self.isOverlap = res.data;

                }).catch(function (err) {
                    errorToastr('확인중 오류가 발생하였습니다.');
                });
            },
            popupPostcode: function () {
                var self = this;
                new daum.Postcode({
                    showMoreHName: false,
                    oncomplete: function(data) {
                        self.setSearchAddress(data);
                    }
                }).open();
            },
            setSearchAddress: function (data) {
                var self = this;
                self.admin.zipCode = data.zonecode;
                self.admin.addressRoad = data.roadAddress;
                self.admin.addressJibun = data.jibunAddress || data.autoJibunAddress;
            },
            save: function () {
                var self = this;



                if(self.isNew)
                {
                    if (self.isOverlap)
                    {
                        errorToastr('중복 확인을 해주세요.');
                        return false;
                    }
                    self.add();
                }
                else
                    self.update();
            },
            add : function(){
                var self = this;

                axios.post("/admin/mng/admin", this.admin).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/mng/admin';
                    },1500)
                }).catch(function (err) {
                });
            },
            update : function(){
                var self = this;

                axios.put("/admin/mng/admin/" + id, this.admin).then(function (res) {
                    alertUpdated();
                }).catch(function (err) {
                });
            },
            deleteAdmin : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/mng/admin/" + id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/mng/admin';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/mng/admin";
                back(backUrl);
            }

        }
    }
</script>
