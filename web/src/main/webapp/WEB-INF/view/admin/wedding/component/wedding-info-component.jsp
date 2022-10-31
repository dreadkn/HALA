<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>
<jsp:include page="death-info-component.jsp"/>
<jsp:include page="person-info-component.jsp"/>

<script type="text/x-template" id="wedding-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">경조사 정보</h3>
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
            <div class="form-row">
                <div class="form-group col-md-12 ">
                    <div class="row align-items-center">
                        <div class="col-12">
                            <label class="mw-2"><small class="text-danger">*</small>공개여부</label>
                        </div>
                        <div class="col-12">
                            <label class="radio-button-wrap mx-3">
                                <input type="radio" id="isPublicY" name="isPublic" :value="true" v-model="wedding.isPublic">
                                <span class="radio-button"></span>
                            </label>
                            <label for="isPublicY" class="mr-5">공개</label>
                            <label class="radio-button-wrap mx-3">
                                <input type="radio" id="isPublicN" name="isPublic" :value="false" v-model="wedding.isPublic">
                                <span class="radio-button"></span>
                            </label>
                            <label for="isPublicN">비공개</label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-4">
                    <label>구분</label>
                    <select class="form-select" v-model="wedding.dtype">
                        <tags:enum-select code="CongratulationsType"></tags:enum-select>
                    </select>
                    <div id="dtypeError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>제목</label>
                    <input type="text" class="form-control" id="title" name="title" v-model="wedding.title"   >
                    <div id="titleError" class="invalid-feedback"></div>
                </div>
            </div>
            <form v-if="wedding.dtype == 'WEDDING'">
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>신랑</label>
                        <input type="text" class="form-control" name="groom" v-model="wedding.groom"   >
                        <div id="groomError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>신랑 직업</label>
                        <input type="text" class="form-control" name="groomJob" v-model="wedding.groomJob"   >
                        <div id="groomJobError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>신랑 부</label>
                        <input type="text" class="form-control" name="groomFather" v-model="wedding.groomFather"   >
                        <div id="groomFatherError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>신랑 모</label>
                        <input type="text" class="form-control" name="groomMother" v-model="wedding.groomMother"   >
                        <div id="groomMotherError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>신부</label>
                        <input type="text" class="form-control" name="bride" v-model="wedding.bride"   >
                        <div id="brideError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>신부 직업</label>
                        <input type="text" class="form-control" name="brideJob" v-model="wedding.brideJob"   >
                        <div id="brideJobError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>신부 부</label>
                        <input type="text" class="form-control" name="brideFather" v-model="wedding.brideFather"   >
                        <div id="brideFatherError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>신부 모</label>
                        <input type="text" class="form-control" id="brideMother" name="brideMother" v-model="wedding.brideMother"   >
                        <div id="brideMotherError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>일시</label>
                        <input type="text" class="form-control" name="weddingDate" v-model="wedding.weddingDate"   >
                        <div id="weddingDateError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>장소</label>
                        <input type="text" class="form-control" name="place" v-model="wedding.place"   >
                        <div id="placeError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>피로연 일시</label>
                        <input type="text" class="form-control" name="partyDate" v-model="wedding.partyDate"   >
                        <div id="partyDateError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>피로연 장소</label>
                        <input type="text" class="form-control" name="partyPlace" v-model="wedding.partyPlace"   >
                        <div id="partyPlaceError" class="invalid-feedback"></div>
                    </div>
                </div>
            </form>

            <death-info-component ref="deathContent" :wedding="wedding" v-show="wedding.dtype == 'DEATH'" ></death-info-component>
            <person-info-component ref="personContent" :wedding="wedding" v-show="wedding.dtype == 'PERSON'" ></person-info-component>

            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>홈페이지링크</label>
                    <input type="text" class="form-control" id="homepageUrl" name="homepageUrl" v-model="wedding.homepageUrl"   >
                    <div id="homepageUrlError" class="invalid-feedback"></div>
                </div>
                <div class="form-group col-md-8">
                    <label>유튜브링크</label>
                    <input type="text" class="form-control" id="youtubeUrl" name="youtubeUrl" v-model="wedding.youtubeUrl"   >
                    <div id="youtubeUrlError" class="invalid-feedback"></div>
                </div>
            </div>


            <div class="form-row">
                <div class="form-group col-md-12">
                    <legend class="col-form-label pt-0 font-weight-bold">이미지</legend>
                    <div class="input-group mb-3">
                        <dropzone-component ref="dropzone" :files="wedding.files" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></dropzone-component>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-footer" v-show="currentTab == 0">
            <div class="row ">
                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletewedding">삭제</button></div>
                <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
            </div>
        </div>
    </div>
</script>

<script>


    var weddingInfoComponent = {
        template: '#wedding-info-component',
        components: {
            'person-info-component': personInfoComponent,
            'death-info-component': deathInfoComponent,
        },
        mounted: function () {

        },
        watch: {
            wedding: function(){
                if(this.isFirst)
                {
                    console.log('first')
                    this.wedding.dtype = this.wedding.dtype.code;
                    this.isFirst = false;
                }
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
                wedding: {
                    isPublic: true,
                    title: '',
                    dtype: 'WEDDING',
                    content: '',
                    homepageUrl: '',
                    youtubeUrl: '',
                    readCount: 0,
                    files: [],
                    deceased: '',
                    deceasedJob: '',
                    illpho: '',
                    outDate: '',
                    cemetery: '',
                    groom: '',
                    groomJob: '',
                    groomFather: '',
                    groomMother: '',
                    bride: '',
                    brideJob: '',
                    brideFather: '',
                    brideMother: '',
                    weddingDate: '',
                    place: '',
                    partyDate: '',
                    partyPlace: '',
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
                    this.wedding.files = this.$refs.dropzone.getUploadFileIds();
                }

                this.setContent();

                if(self.isNew)
                {
                    self.add();
                }
                else
                    self.update();
            },
            add : function(){
                var self = this;
                axios.post("/admin/wedding", this.wedding).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/wedding';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update : function(){
                var self = this;
                axios.put("/admin/wedding/" + this.$parent.id, this.wedding).then(function (res) {
                    alertUpdated();
                    setTimeout(function(){
                        self.back();
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            deletewedding : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/wedding/" + this.$parent.id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/wedding';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/wedding";
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
            setContent: function(){
                switch(this.wedding.dtype)
                {
                    case 'DEATH':
                        this.wedding.deceased = this.$refs.deathContent.death.deceased;
                        this.wedding.deceasedJob = this.$refs.deathContent.death.deceasedJob;
                        this.wedding.illpho = this.$refs.deathContent.death.illpho;
                        this.wedding.outDate = this.$refs.deathContent.death.outDate;
                        this.wedding.place = this.$refs.deathContent.death.place;
                        this.wedding.cemetery = this.$refs.deathContent.death.cemetery;
                        this.wedding.content = this.$refs.deathContent.death.content;
                        break;
                    case 'PERSON':
                        this.wedding.content = this.$refs.personContent.person.content;
                        break;
                }

            }

        }
    }
</script>
