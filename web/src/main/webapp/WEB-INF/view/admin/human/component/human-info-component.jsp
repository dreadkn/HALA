<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="human-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">제주인명 정보</h3>
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
                            <div class="col-12">
                                <label class="mw-2"><small class="text-danger">*</small>공개여부</label>
                            </div>
                            <div class="col-12">
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="isPublicY" name="isPublic" :value="true" v-model="human.isPublic">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isPublicY" class="mr-5">공개</label>
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="isPublicN" name="isPublic" :value="false" v-model="human.isPublic">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isPublicN">비공개</label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>이름(국문)</label>
                        <input type="text" class="form-control" id="krName" v-model="human.krName"   >
                        <div id="krNameError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>이름(한문)</label>
                        <input type="text" class="form-control" id="cnName" v-model="human.cnName"   >
                        <div id="cnNameError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>이름(영문)</label>
                        <input type="text" class="form-control" id="enName" v-model="human.enName"   >
                        <div id="enNameError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>직위</label>
                        <input type="text" class="form-control" id="position" v-model="human.position"   >
                        <div id="positionError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>생년</label>
                        <input type="text" class="form-control" id="birthYear" v-model="human.birthYear"   >
                        <div id="birthYearError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>이메일</label>
                        <input type="text" class="form-control" id="email" v-model="human.email"   >
                        <div id="emailError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>주소</label>
                        <input type="text" class="form-control" id="address" v-model="human.address"   >
                        <div id="addressError" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>학력</label>
                        <textarea name="education" class="w-100" rows="10" v-model="human.education"></textarea>
                        <div id="educationError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>경력사항</label>
                        <textarea name="career" class="w-100" rows="10" v-model="human.career"></textarea>
                        <div id="careerError" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>저작</label>
                        <textarea name="writing" class="w-100" rows="10" v-model="human.writing"></textarea>
                        <div id="writingError" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>논문</label>
                        <textarea name="paper" class="w-100" rows="10" v-model="human.paper"></textarea>
                        <div id="paperError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>수상</label>
                        <textarea name="awards" class="w-100" rows="10" v-model="human.awards"></textarea>
                        <div id="awardsError" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>기타1</label>
                        <textarea name="etc1" class="w-100" rows="10" v-model="human.etc1"></textarea>
                        <div id="etc1Error" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>기타2</label>
                        <textarea name="etc2" class="w-100" rows="10" v-model="human.etc2"></textarea>
                        <div id="etc2Error" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-12">
                        <legend class="col-form-label pt-0 font-weight-bold">이미지</legend>
                        <div class="input-group mb-3">
                            <dropzone-component ref="dropzone" :files="human.files" :delete="false" :max-files="1" :accepted-files="acceptedFiles"></dropzone-component>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="card-footer" v-show="currentTab == 0">
            <div class="row ">
                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletehuman">삭제</button></div>
                <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
            </div>
        </div>
    </div>
</script>

<script>


    var humanInfoComponent = {
        template: '#human-info-component',
        mounted: function () {

        },
        watch: {
            human: function(){

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
                human: {
                    isPublic: true,
                    krName: '',
                    cnName: '',
                    enName: '',
                    position: '',
                    birthYear: '',
                    address: '',
                    email: '',
                    education: '',
                    career: '',
                    writing: '',
                    paper: '',
                    awards: '',
                    etc1: '',
                    etc2: '',
                    readCount: 0,
                    files: [],
                },
                acceptedFiles : 'image/*',
                isFirst : true,
                currentTab : 0,
                tabs : ['기본정보']
            }
        },
        methods: {
            save: function () {
                var self = this;

                if (this.$refs.dropzone != null) {
                    this.human.files = this.$refs.dropzone.getUploadFileIds();
                }

                if(self.isNew)
                {
                    self.add();
                }
                else
                    self.update();
            },
            add : function(){
                var self = this;
                axios.post("/admin/human", this.human).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/human';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update : function(){
                var self = this;
                axios.put("/admin/human/" + this.$parent.id, this.human).then(function (res) {
                    alertUpdated();
                    setTimeout(function(){
                        self.back();
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            deletehuman : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/human/" + this.$parent.id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/human';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/human";
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
