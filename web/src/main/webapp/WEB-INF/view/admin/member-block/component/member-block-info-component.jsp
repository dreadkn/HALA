<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="member-block-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">차단 회원 정보</h3>
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
                                <label class="mw-1"><small class="text-danger">*</small>아이디</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="text" class="form-control" id="userId" name="userId" v-model="member.userId" required :readonly="isUpdate">
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
                                <input type="password" class="form-control" id="password" v-model="member.password"  required>
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
                                <input type="text" class="form-control" id="name" v-model="member.name"  required>
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
                                <input type="text" class="form-control" id="phone" v-model="member.phone"  required>
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
                                <input type="text" class="form-control" id="email" v-model="member.email"  required>
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
                                <button class="btn btn-outline-secondary" type="button" id="button-addon1" >주소 검색</button>
                            </div>
                            <input type="text" class="form-control" id="zipCode" name="zipCode" v-model="member.zipCode" readonly>
                        </div>
                        <div id="zipCodeError" class="invalid-feedback"></div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="addressRoad">도로명 주소</label>
                        <input type="text" class="form-control" id="addressRoad" name="addressRoad" v-model="member.addressRoad">
                        <div id="addressRoadError" class="invalid-feedback"></div>
                    </div>

                    <div class="form-group col-md-6">
                        <label for="addressJibun">지번 주소</label>
                        <input type="text" class="form-control" id="addressJibun" name="addressJibun" v-model="member.addressJibun">
                        <div id="addressJibunError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-12">
                                <label class="mw-2"><small class="text-danger">*</small>차단 회원상태</label>
                            </div>
                            <div class="col-12">
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="enabledY" name="enabled" :value="true" v-model="member.enabled">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="enabledY" class="mr-5">정상</label>
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="enabledN" name="enabled" :value="false" v-model="member.enabled">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="enabledN">차단</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>콘텐츠등록건수</label>
                        <input type="text" class="form-control" id="contentCount" v-model="member.contentCount"   >
                        <div id="contentCountError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>광고등록건수</label>
                        <input type="text" class="form-control" id="adCount" v-model="member.adCount"   >
                        <div id="adCountError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>가입일</label>
                        <input type="text" class="form-control" id="createdDate" v-model="member.createdDate"   >
                        <div id="createdDateError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>마직막로그인</label>
                        <input type="text" class="form-control" id="lastLoginDate" v-model="member.lastLoginDate"   >
                        <div id="lastLoginDateError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-12">
                                <label class="mw-2"><small class="text-danger">*</small>구독여부</label>
                            </div>
                            <div class="col-12">
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="isSubscribeY" name="isSubscribe" :value="true" v-model="member.isSubscribe">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isSubscribeY" class="mr-5">구독</label>
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="isSubscribeN" name="isSubscribe" :value="false" v-model="member.isSubscribe">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isSubscribeN">구독안함</label>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="card-footer" v-show="currentTab == 0">
            <div class="row ">
                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-warning" @click="unblockMember">차단해제</button></div>
            </div>
        </div>
    </div>
</script>

<script>

    var geocoder;

    var memberBlockInfoComponent = {
        template: '#member-block-info-component',
        mounted: function () {
            geocoder = new daum.maps.services.Geocoder();
        },
        watch: {
            member: function(){
                this.member.adminType = this.member.adminType.code;
                this.member.createdDate = dateFormat(this.member.createdDate, 'YYYY-MM-DD');
                this.member.lastLoginDate = dateFormat(this.member.lastLoginDate, 'YYYY-MM-DD');
                this.member.withdrawalDate = dateFormat(this.member.withdrawalDate, 'YYYY-MM-DD');
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
                member: {
                    adminType: 'USER',
                    userId: '',
                    password: '',
                    name: '',
                    phone: '',
                    email: '',
                    language1: 'ko',
                    language2: 'ko',
                    addressJibun: '',
                    addressRoad: '',
                    zipCode: '',
                    contentCount: 0,
                    adCount: 0,
                    isSubscribe: false,
                    lastLoginDate: '',
                    subscribeUpdateCount: '',
                    isWithdrawal: false,
                    enabled: true,
                    withdrawalDate: '',
                },
                isOverlap: true,
                currentTab : 0,
                tabs : ['기본정보']
            }
        },
        methods: {
            unblockMember : function(){
                var self = this;

                alertConfirm(function(result)
                {
                    if (result)
                    {
                        axios.post("/admin/member-block/unblock/" + self.$parent.id, {data: {}}).then(function (res) {
                            alertSuccess('차단 해제 되었습니다.');
                            setTimeout(function () {
                                location.href = contextPath + '/admin/member-block';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('차단 해제 중 오류가 발생하였습니다.');
                        });
                    }
                }, '차단해제', '차단 해제 하시겠습니까?', '차단', '취소');
            },
            back: function () {
                var backUrl = "/admin/member-block";
                back(backUrl);
            },
            enableEditor : function(){
                CKEDITOR.replace('content', $.extend(true, ckEditorConfigs, {
                        fileTools_requestHeaders: {
                            'X-Requested-With': 'XMLHttpRequest',
                            'x-csrf-token': document.querySelectorAll('meta[name=X-CSRF-TOKEN]')[0].getAttributeNode('content').value
                        }
                    })
                );
            },

        }
    }
</script>
