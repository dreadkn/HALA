<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="popup-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">팝업 정보</h3>
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
                                <label class="mw-1"><small class="text-danger">*</small>팝업분류</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <select v-model="popup.popupType" class="form-select">
                                        <tags:enum-select code="PopupType"></tags:enum-select>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>팝업명</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="text" class="form-control" name="title" v-model="popup.title" required >
                                </div>
                                <div class="error-wrap">
                                    <div id="titleError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>링크</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="text" class="form-control" name="url" v-model="popup.url" required >
                                </div>
                                <div class="error-wrap">
                                    <div id="urlError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>팝업기간</label>
                            </div>
                            <div class="col-auto">
                                <div class="d-flex align-items-center">
                                    <div class="">
                                        <div class="input-group"  data-target-input="nearest">
                                            <input type="text" class="form-control " id="startDate" name="startDate" v-model="startDate"/>
                                            <div class="input-group-append"  >
                                                <div class="input-group-text"><i class="far fa-calendar-alt"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    ~
                                    <div class="">
                                        <div class="input-group" data-target-input="nearest">
                                            <input type="text" class="form-control " id="endDate" name="endDate" v-model="endDate"/>
                                            <div class="input-group-append" >
                                                <div class="input-group-text"><i class="far fa-calendar-alt"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="error-wrap">
                                    <div id="startDateError" class="invalid-feedback"></div>
                                    <div id="endDateError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-4 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>x 좌표</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="number" class="form-control" name="x" v-model="popup.x" required >
                                </div>
                                <div class="error-wrap">
                                    <div id="xError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-4 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>y 좌표</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="number" class="form-control" name="y" v-model="popup.y" required >
                                </div>
                                <div class="error-wrap">
                                    <div id="yError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-4 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>가로사이즈</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="number" class="form-control" name="width" v-model="popup.width" required >
                                </div>
                                <div class="error-wrap">
                                    <div id="widthError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-4 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>세로사이즈</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="number" class="form-control" name="height" v-model="popup.height" required >
                                </div>
                                <div class="error-wrap">
                                    <div id="heightError" class="invalid-feedback"></div>
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
                            <div class="col-12">
                                <div class="input-group-append">
                                    <textarea rows="10" class="form-control" id="content" name="content" v-model="popup.content" aria-label="본문"></textarea>
                                </div>
                                <div class="error-wrap">
                                    <div id="contentError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group col-4">
                    <legend class="col-form-label font-weight-bold">사용 여부</legend>
                    <div class="form-check-inline">
                        <input class="form-check-input" type="radio" name="isUse" id="isUseY"
                               :value="true" v-model.boolean="popup.isUse">
                        <label class="form-check-label" for="isUseY">사용</label>
                    </div>
                    <div class="form-check-inline">
                        <input class="form-check-input" type="radio" name="isUse" id="isUseN"
                               :value="false" v-model.boolean="popup.isUse">
                        <label class="form-check-label" for="isUseN">사용안함</label>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-12">
                        <legend class="col-form-label pt-0 font-weight-bold">파일</legend>
                        <div class="input-group mb-3">
                            <dropzone-component ref="dropzone" :files="popup.files" :delete="false" :max-files="10"></dropzone-component>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="card-footer" v-show="currentTab == 0">
            <div class="row ">
                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletepopup">삭제</button></div>
                <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
            </div>
        </div>
    </div>
</script>

<script>


    var popupInfoComponent = {
        template: '#popup-info-component',
        mounted: function () {
            var self = this;


            $('#startDate').datetimepicker({
                format:'Y-m-d',
                timepicker: false,
                onChangeDateTime:function(dp,$input){
                    self.startDate = $input.val();
                    self.popup.startDate = new Date($input.val() + ' 00:00:00');
                }
            });

            $('#endDate').datetimepicker({
                format:'Y-m-d',
                timepicker: false,
                onChangeDateTime:function(dp,$input){
                    self.endDate = $input.val();
                    self.popup.endDate = new Date($input.val() + ' 00:00:00');
                }
            });

            if(this.isNew)
                this.enableEditor();
        },
        watch: {
            popup : function(){
                if (this.isFirst)
                {
                    this.popup.popupType = this.popup.popupType.code;
                    this.startDate = dateFormat(this.popup.startDate, 'YYYY-MM-DD');
                    this.endDate = dateFormat(this.popup.endDate, 'YYYY-MM-DD');
                    this.isFirst = false;

                    if(this.isUpdate)
                        this.enableEditor();

                    if (this.editor != null) {
                        this.editor.setContents(this.popup.content);
                    }
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
                popup: {
                    popupType: 'NORMAL',
                    title: '',
                    startDate: '',
                    endDate: '',
                    isUse: true,
                    x: '100',
                    y: '100',
                    width: '100',
                    height: '100',
                    url: '',
                    content: '',
                },
                startDate : '',
                endDate : '',
                editor : {},
                isFirst: true,
                currentTab : 0,
                tabs : ['기본정보']
            }
        },
        methods: {
            save: function () {
                var self = this;

                if (this.$refs.dropzone != null) {
                    this.popup.files = this.$refs.dropzone.getUploadFileIds();
                }

                if (this.editor.getContents() != null) {
                    this.popup.content = this.editor.getContents();
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
                axios.post("/admin/module/popup", this.popup).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/module/popup';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update : function(){
                var self = this;
                axios.put("/admin/module/popup/" + id, this.popup).then(function (res) {
                    alertUpdated();
                    setTimeout(function(){
                        self.back();
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            deletepopup : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/module/popup/" + id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/module/popup';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/module/popup";
                back(backUrl);
            },
            enableEditor : function(){

                this.editor = SUNEDITOR.create((document.getElementById('content') || 'content'), $.extend(true, sunEditorConfig, {
                        imageUploadHeader: {
                            'X-Requested-With': 'XMLHttpRequest',
                            'x-csrf-token': document.querySelectorAll('meta[name=X-CSRF-TOKEN]')[0].getAttributeNode('content').value
                        },
                    })
                );
            }

        }
    }
</script>
