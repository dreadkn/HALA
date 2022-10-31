<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="version-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">모바일앱 버전 정보</h3>
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
                    <div class="form-group col-md-4">
                        <label>OS</label>
                        <select class="form-select" v-model="version.appType">
                            <tags:enum-select code="AppType"></tags:enum-select>
                        </select>
                        <div id="titleError" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>버전</label>
                        <input type="text" class="form-control" id="version" v-model="version.version"   >
                        <div id="versionError" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-12">
                                <label class="mw-2"><small class="text-danger">*</small>필수 업데이트구분</label>
                            </div>
                            <div class="col-12">
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="isEssentialUpdateY" name="isEssentialUpdate" :value="true" v-model="version.isEssentialUpdate">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isEssentialUpdateY" class="mr-5">필수</label>
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="isEssentialUpdateN" name="isEssentialUpdate" :value="false" v-model="version.isEssentialUpdate">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isEssentialUpdateN">해당없음</label>
                            </div>
                        </div>
                    </div>
                </div>

            </form>
        </div>
        <div class="card-footer" v-show="currentTab == 0">
            <div class="row ">
                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deleteversion">삭제</button></div>
                <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
            </div>
        </div>
    </div>
</script>

<script>


    var versionInfoComponent = {
        template: '#version-info-component',
        mounted: function () {

        },
        watch: {
            version: function(){
                this.version.appType = this.version.appType.code;
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
                version: {
                    appType: 'ANDROID',
                    version: '',
                    isEssentialUpdate: false,
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

                if(self.isNew)
                {
                    self.add();
                }
                else
                    self.update();
            },
            add : function(){
                var self = this;
                axios.post("/admin/version", this.version).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/version';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update : function(){
                var self = this;
                axios.put("/admin/version/" + this.$parent.id, this.version).then(function (res) {
                    alertUpdated();
                    setTimeout(function(){
                        self.back();
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            deleteversion : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/version/" + this.$parent.id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/version';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/version";
                back(backUrl);
            },

        }
    }
</script>
