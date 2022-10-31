<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="banner-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">배너 정보</h3>
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
                                <label class="mw-1"><small class="text-danger">*</small>배너링크제목</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="text" class="form-control" v-model="banner.urlTitle" required >
                                </div>
                                <div class="error-wrap">
                                    <div id="urlTitleError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>배너링크</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="text" class="form-control" v-model="banner.url" required >
                                </div>
                                <div class="error-wrap">
                                    <div id="urlError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>설명</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <textarea rows="10" class="form-control" id="content" name="content" v-html="banner.content" title="본문"></textarea>
                                </div>
                                <div class="error-wrap">
                                    <div id="contentError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>정렬</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="number" class="form-control" v-model="banner.sort" required >
                                </div>
                                <div class="error-wrap">
                                    <div id="sortError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-2"><small class="text-danger">*</small>사용여부</label>
                            </div>
                            <div class="col-auto">
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="isUseY" name="isUse" value="1" v-model="banner.isUse">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isUseY" class="mr-5">사용</label>
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="isUseN" name="isUse" value="0" v-model="banner.isUse">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isUseN">사용안함</label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-12">
                        <legend class="col-form-label pt-0 font-weight-bold">파일</legend>
                        <div class="input-group mb-3">
                            <dropzone-component ref="dropzone" :files="banner.files" :delete="false" :max-files="10"></dropzone-component>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="card-footer" v-show="currentTab == 0">
            <div class="row ">
                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletebanner">삭제</button></div>
                <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
            </div>
        </div>
    </div>
</script>

<script>


    var bannerInfoComponent = {
        template: '#banner-info-component',
        mounted: function () {
            CKEDITOR.replace('content', $.extend(true, ckEditorConfigs, {
                    fileTools_requestHeaders: {
                        'X-Requested-With': 'XMLHttpRequest',
                        'x-csrf-token': document.querySelectorAll('meta[name=X-CSRF-TOKEN]')[0].getAttributeNode('content').value
                    }
                })
            );
        },
        watch: {
            banner: function(){
                if (this.isFirst)
                {
                    this.banner.bannerType = this.banner.bannerType.code;
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
                banner: {
                    bannerType: 'BANNER',
                    url: '',
                    urlTitle: '',
                    sort: '1',
                    content: '',
                    isUse: 1,
                },
                isFirst : true,
                currentTab : 0,
                tabs : ['기본정보']
            }
        },
        methods: {
            save: function () {
                var self = this;

                if (this.$refs.dropzone != null) {
                    this.banner.files = this.$refs.dropzone.getUploadFileIds();
                }

                if (CKEDITOR.instances.content != null) {
                    this.banner.content = CKEDITOR.instances.content.getData();
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
                axios.post("/admin/module/banner", this.banner).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/module/banner';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update : function(){
                var self = this;
                axios.put("/admin/module/banner/" + id, this.banner).then(function (res) {
                    self.back();
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            deletebanner : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/module/banner/" + id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/module/banner';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/module/banner";
                back(backUrl);
            }

        }
    }
</script>
