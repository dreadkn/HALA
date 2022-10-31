<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="event-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">행사 정보</h3>
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
                                    <input type="radio" id="isPublicY" name="isPublic" :value="true" v-model="event.isPublic">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isPublicY" class="mr-5">공개</label>
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="isPublicN" name="isPublic" :value="false" v-model="event.isPublic">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isPublicN">비공개</label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>제목</label>
                        <input type="text" class="form-control" id="title" v-model="event.title"   >
                        <div id="titleError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>내용</label>
                        <textarea name="content" class="w-100" rows="10" v-model="event.content"></textarea>
                        <div id="contentError" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>홈페이지링크</label>
                        <input type="text" class="form-control" id="homepageUrl" v-model="event.homepageUrl"   >
                        <div id="homepageUrlError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-8">
                        <label>유튜브링크</label>
                        <input type="text" class="form-control" id="youtubeUrl" v-model="event.youtubeUrl"   >
                        <div id="youtubeUrlError" class="invalid-feedback"></div>
                    </div>
                </div>


                <div class="form-row">
                    <div class="form-group col-md-12">
                        <legend class="col-form-label pt-0 font-weight-bold">이미지</legend>
                        <div class="input-group mb-3">
                            <dropzone-component ref="dropzone" :files="event.files" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></dropzone-component>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="card-footer" v-show="currentTab == 0">
            <div class="row ">
                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deleteevent">삭제</button></div>
                <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
            </div>
        </div>
    </div>
</script>

<script>


    var eventInfoComponent = {
        template: '#event-info-component',
        mounted: function () {

        },
        watch: {
            event: function(){

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
                event: {
                    isPublic: true,
                    title: '',
                    content: '',
                    homepageUrl: '',
                    youtubeUrl: '',
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
                    this.event.files = this.$refs.dropzone.getUploadFileIds();
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
                axios.post("/admin/event", this.event).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/event';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update : function(){
                var self = this;
                axios.put("/admin/event/" + this.$parent.id, this.event).then(function (res) {
                    alertUpdated();
                    setTimeout(function(){
                        self.back();
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            deleteevent : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/event/" + this.$parent.id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/event';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/event";
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
