<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="subscribe-info-component">
    <div>
        <div class="card card-light">
            <div class="card-header card-header-tab py-3">
                <div class="d-flex justify-content-between">
                    <h3 class="card-title text-bold">구독자 정보</h3>
                </div>
            </div>

            <div class="card-body" v-show="currentTab == 0">
                <form>
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label>회원</label>
                            <input type="text" class="form-control" id="name" v-model="subscribe.member.name"  name="name" readonly >
                            <div id="nameError" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group col-md-4">
                            <label>가입일자</label>
                            <input type="text" class="form-control" id="createdDate" v-model="subscribe.member.createdDate" name="createdDate" readonly>
                            <div id="createdDateError" class="invalid-feedback"></div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label>구독기간</label>
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
                            <div id="titleError" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group col-md-4">
                            <label>갱신횟수</label>
                            <input type="text" class="form-control" id="subscribeUpdateCount" v-model="subscribe.member.subscribeUpdateCount"  readonly >
                            <div id="subscribeUpdateCountError" class="invalid-feedback"></div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label>담당자</label>
                            <input type="text" class="form-control" id="charger" v-model="subscribe.charger"   >
                            <div id="chargerError" class="invalid-feedback"></div>
                        </div>
                        <div class="form-group col-md-4">
                            <label>연락처</label>
                            <input type="text" class="form-control" id="tel" v-model="subscribe.tel"   >
                            <div id="telError" class="invalid-feedback"></div>
                        </div>
                    </div>

                </form>
            </div>
            <div class="card-footer" v-show="currentTab == 0">
                <div class="row ">
                    <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                    <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletesubscribe">삭제</button></div>
                    <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
                </div>
            </div>
        </div>
        <div class="card card-light">
            <div class="card-header card-header-tab py-3">
                <div class="d-flex justify-content-between">
                    <h3 class="card-title text-bold">결제 정보</h3>
                </div>
            </div>

            <div class="card-body" >
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>승인번호</label>
                        <input type="text" class="form-control" id="approveNumber" v-model="subscribe.payment.approveNumber" >
                        <div id="approveNumberError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>비용</label>
                        <input type="text" class="form-control" id="price" v-model="subscribe.payment.price" readonly>
                        <div id="priceError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>결제상태</label>
                        <select class="form-select" v-model="subscribe.payment.paymentStatus" >
                            <tags:enum-select code="PaymentStatus"></tags:enum-select>
                        </select>
                        <div id="paymentStatusError" class="invalid-feedback"></div>
                    </div>
                </div>
            </div>
            <div class="card-footer" >
                <div class="row ">
                    <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                    <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletesubscribe">삭제</button></div>
                    <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
                </div>
            </div>
        </div>
        <div class="card card-light">
            <div class="card-header card-header-tab py-3">
                <div class="d-flex justify-content-between">
                    <h3 class="card-title text-bold">구독자 혜택</h3>
                </div>
            </div>

            <div class="card-body" >
                <table class="table">
                    <colgroup>
                        <col width="33%">
                        <col width="33%">
                        <col width="33%">
                    </colgroup>
                    <thead>
                    <tr class="text-center">
                        <th>혜택</th>
                        <th>제공횟수</th>
                        <th>잔여횟수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="text-center">
                        <td class="text-start">콘텐츠 등록</td>
                        <td >{{subscribe.subscribeBenefit.contentCount}}</td>
                        <td>{{subscribe.contentLeftCount}}</td>
                    </tr>
                    <tr class="text-center">
                        <td class="text-start">광고 1개월 등록</td>
                        <td>{{subscribe.subscribeBenefit.adCount}}</td>
                        <td>{{subscribe.adLeftCount}}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="card-footer" >
                <div class="row ">
                    <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                    <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletesubscribe">삭제</button></div>
                    <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
                </div>
            </div>
        </div>
    </div>

</script>

<script>


    var subscribeInfoComponent = {
        template: '#subscribe-info-component',
        mounted: function () {

            let self = this;

            $('#startDate').datetimepicker({
                format:'Y-m-d',
                timepicker: false,
                onChangeDateTime:function(dp,$input){
                    self.startDate = $input.val();
                    self.subscribe.startDate = new Date($input.val() + ' 00:00:00');
                }
            });

            $('#endDate').datetimepicker({
                format:'Y-m-d',
                timepicker: false,
                onChangeDateTime:function(dp,$input){
                    self.endDate = $input.val();
                    self.subscribe.endDate = new Date($input.val() + ' 00:00:00');
                }
            });

        },
        watch: {
            subscribe: function(){
                this.startDate = dateFormat(this.subscribe.startDate, 'YYYY-MM-DD');
                this.endDate = dateFormat(this.subscribe.endDate, 'YYYY-MM-DD');
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
                subscribe: {
                    member: {},
                    startDate: '',
                    endDate: '',
                    charger: '',
                    tel: '',
                    contentLeftCount: '',
                    adLeftCount: '',
                    payment: {},
                    subscribeBenefit: {},
                },
                startDate: '',
                endDate: '',
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
                axios.post("/admin/subscribe", this.subscribe).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/subscribe';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update : function(){
                var self = this;
                axios.put("/admin/subscribe/" + this.$parent.id, this.subscribe).then(function (res) {
                    alertUpdated();
                    setTimeout(function(){
                        self.back();
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            deletesubscribe : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/subscribe/" + this.$parent.id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/subscribe';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/subscribe";
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
