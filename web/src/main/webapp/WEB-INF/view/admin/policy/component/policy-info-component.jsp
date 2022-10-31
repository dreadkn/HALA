<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="policy-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">약관 정보</h3>
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
                                <label class="mw-1"><small class="text-danger">*</small>구분</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <select v-model="policy.policyType" class="form-select">
                                        <tags:enum-select code="PolicyType"></tags:enum-select>
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
                                <label class="mw-1"><small class="text-danger">*</small>버전</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    <input type="number" class="form-control" name="version" v-model="policy.version" required >
                                </div>
                                <div class="error-wrap">
                                    <div id="versionError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>내용</label>
                            </div>
                            <div class="col-8">
                                <div class="input-group-append">
                                    <textarea rows="10" class="form-control" id="content" name="contents" v-model="policy.contents" title="본문"></textarea>
                                </div>
                                <div class="error-wrap">
                                    <div id="contentsError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </form>
        </div>
        <div class="card-footer" v-show="currentTab == 0">
            <div class="row ">
                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletepolicy">삭제</button></div>
                <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
            </div>
        </div>
    </div>
</script>

<script>


    var policyInfoComponent = {
        template: '#policy-info-component',
        mounted: function () {
            if (this.isNew)
                this.enableEditor();
        },
        watch: {
            policy : function(){
                this.policy.policyType = this.policy.policyType.code;
                this.enableEditor();

                if (this.editor != null) {
                    this.editor.setContents(this.policy.contents);
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
                policy: {
                    policyType: 'POLICY_USE',
                    contents: '',
                    version: '1',
                },
                editor : {},
                acceptedFiles : null,
                currentTab : 0,
                tabs : ['기본정보']
            }
        },
        methods: {
            save: function () {
                var self = this;

                if (this.editor.getContents() != null) {
                    this.policy.contents = this.editor.getContents();
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
                axios.post("/admin/policy", this.policy).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/policy';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update : function(){
                var self = this;
                axios.put("/admin/policy/" + this.$parent.id, this.policy).then(function (res) {
                    alertUpdated();
                    setTimeout(function(){
                        self.back();
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            deletepolicy : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/policy/" + this.$parent.id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/policy';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/policy";
                back(backUrl);
            },
            stringToHtml : function(input){
                return this.lineToBr(this.htmlDecode(input));
            },
            htmlDecode : function (input) {
                var doc = new DOMParser().parseFromString(input, "text/html");
                return doc.documentElement.textContent;
            },
            lineToBr : function(html){
                html = html.replace(/\r\n/gi, '<br>');
                html = html.replace(/\\n/gi, '<br>');
                html = html.replace(/\n/gi, '<br>');
                return html
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

