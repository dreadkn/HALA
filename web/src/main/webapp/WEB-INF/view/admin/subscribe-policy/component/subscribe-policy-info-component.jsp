<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="policy-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">구독 정책 정보</h3>
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
                    <div class="form-group col-md-6 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>적용 기간</label>
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
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label>기준기간</label>
                        <select class="form-select" v-model="policy.periodType">
                            <tags:enum-select code="PeriodType"></tags:enum-select>
                        </select>
                        <div id="periodTypeError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>콘텐츠 등록</label>
                        <input type="number" class="form-control" id="contentCount" v-model="policy.contentCount"   >
                        <div id="contentCountError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-6">
                        <label>광고 1개월 등록</label>
                        <input type="number" class="form-control" id="adCount" v-model="policy.adCount"   >
                        <div id="adCountError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>요금</label>
                        <input type="number" class="form-control" id="price" v-model="policy.price"   >
                        <div id="priceError" class="invalid-feedback"></div>
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
            let self = this;

            $('#startDate').datetimepicker({
                format:'Y-m-d',
                timepicker: false,
                onChangeDateTime:function(dp,$input){
                    self.startDate = $input.val();
                    self.policy.startDate = new Date($input.val() + ' 00:00:00');
                }
            });

            $('#endDate').datetimepicker({
                format:'Y-m-d',
                timepicker: false,
                onChangeDateTime:function(dp,$input){
                    self.endDate = $input.val();
                    self.policy.endDate = new Date($input.val() + ' 00:00:00');
                }
            });
        },
        watch: {
            policy: function(){
                this.policy.periodType = this.policy.periodType.code;
                this.startDate = dateFormat(this.policy.startDate, 'YYYY-MM-DD');
                this.endDate = dateFormat(this.policy.endDate, 'YYYY-MM-DD');
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
                    periodType: 'YEAR',
                    startDate: '',
                    endDate: '',
                    contentCount: '',
                    adCount: '',
                    price: 0,
                },
                startDate : '',
                endDate : '',
                acceptedFiles : 'image/*',
                isFirst : true,
                currentTab : 0,
                tabs : ['기본정보']
            }
        },
        methods: {
            save: function () {
                var self = this;

                this.policy.price = Number(this.policy.price);

                if(self.isNew)
                {
                    self.add();
                }
                else
                    self.update();
            },
            add : function(){
                var self = this;
                axios.post("/admin/subscribe-policy", this.policy).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/subscribe-policy';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update : function(){
                var self = this;
                axios.put("/admin/subscribe-policy/" + this.$parent.id, this.policy).then(function (res) {
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
                        axios.delete("/admin/subscribe-policy/" + this.$parent.id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/subscribe-policy';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/subscribe-policy";
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
