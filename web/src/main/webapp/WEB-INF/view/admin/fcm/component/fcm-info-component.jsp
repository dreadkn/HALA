<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="fcm-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">FCM알림 정보</h3>
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
                        <label>알림 구분</label>
                        <select class="form-select" v-model="fcm.alarmTarget">
                            <tags:enum-select code="AlarmTarget"></tags:enum-select>
                        </select>
                        <div id="alarmTargetError" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row" v-if="isUpdate">
                    <div class="form-group col-md-4">
                        <label>발송자</label>
                        <input type="text" class="form-control" id="sender" v-model="fcm.sender"   >
                        <div id="senderError" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row" v-if="isUpdate">
                    <div class="form-group col-md-4">
                        <label>발송일</label>
                        <input type="text" class="form-control" id="sendDate" v-model="fcm.sendDate"   >
                        <div id="sendDateError" class="invalid-feedback"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>알림명</label>
                        <input type="text" class="form-control" id="title" v-model="fcm.title" name="title" >
                        <div id="titleError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>내용</label>
                        <textarea name="content" class="w-100" rows="10" v-model="fcm.content"></textarea>
                        <div id="contentError" class="invalid-feedback"></div>
                    </div>
                </div>

            </form>
        </div>
        <div class="card-footer" v-show="currentTab == 0">
            <div class="row ">
                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                <div class="col-auto"><button type="button" class="btn btn-primary" @click="send" v-if="isNew">발송</button></div>
            </div>
        </div>
    </div>
</script>

<script>


    var fcmInfoComponent = {
        template: '#fcm-info-component',
        mounted: function () {

        },
        watch: {
            fcm: function(){
                this.fcm.sendDate = dateFormat(this.fcm.sendDate, 'YYYY-MM-DD');
                this.fcm.alarmTarget = this.fcm.alarmTarget.code;
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
                fcm: {
                    alarmType: 'FCM',
                    alarmTarget: 'ALL',
                    sender: '',
                    sendDate: '',
                    title: '',
                    content: '',
                    receiversCount: '',
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
            send : function(){
                var self = this;
                axios.post("/admin/fcm", this.fcm).then(function (res) {
                    alertSuccess('발송되었습니다.');
                    setTimeout(function(){
                        location.href = contextPath + '/admin/fcm';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            back: function () {
                var backUrl = "/admin/fcm";
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
