<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>
<jsp:include page="event-info-component.jsp"/>
<jsp:include page="human-info-component.jsp"/>
<jsp:include page="news-info-component.jsp"/>
<jsp:include page="wedding-info-component.jsp"/>

<script type="text/x-template" id="check-info-component">
    <div>
        <div class="card card-light">
            <div class="card-header card-header-tab py-3">
                <div class="d-flex justify-content-between">
                    <h3 class="card-title text-bold">콘텐츠 정보</h3>
                </div>
            </div>

            <div class="card-body" >

                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>구분</label>
                        <select class="form-select" v-model="check.contentType" disabled>
                            <tags:enum-select code="ContentType"></tags:enum-select>
                        </select>
                        <div id="titleError" class="invalid-feedback"></div>
                    </div>
                </div>

                <event-info-component ref="content" :id="check.contentId" v-if="check.contentType == 'EVENT'" ></event-info-component>
                <human-info-component ref="content" :id="check.contentId" v-if="check.contentType == 'HUMAN'"></human-info-component>
                <news-info-component ref="content" :id="check.contentId" v-if="check.contentType == 'NEWS'"></news-info-component>
                <wedding-info-component ref="content" :id="check.contentId" v-if="check.contentType == 'CONGRATULATIONS'"></wedding-info-component>
            </div>
            <div class="card-footer" >
                <div class="row ">
                    <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                    <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletecheck">삭제</button></div>
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
                        <input type="text" class="form-control" id="approveNumber" v-model="check.payment.approveNumber" >
                        <div id="approveNumberError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>비용</label>
                        <input type="text" class="form-control" id="price" v-model="check.payment.price" readonly>
                        <div id="priceError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>결제상태</label>
                        <select class="form-select" v-model="check.payment.paymentStatus" >
                            <tags:enum-select code="PaymentStatus"></tags:enum-select>
                        </select>
                        <div id="paymentStatusError" class="invalid-feedback"></div>
                    </div>
                </div>
            </div>
            <div class="card-footer" >
                <div class="row ">
                    <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                    <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletecheck">삭제</button></div>
                    <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
                </div>
            </div>
        </div>
        <div class="card card-light">
            <div class="card-header card-header-tab py-3">
                <div class="d-flex justify-content-between">
                    <h3 class="card-title text-bold">검수 정보</h3>
                </div>
            </div>

            <div class="card-body" >
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>검수자</label>
                        <input type="text" class="form-control" id="name" v-model="check.inspection.inspectionUser.name" readonly  >
                        <div id="nameError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>검수일시</label>
                        <input type="text" class="form-control" id="inspectionDate" v-model="check.inspection.inspectionDate" >
                        <div id="inspectionDateError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>검수상태</label>
                        <select class="form-select" v-model="check.inspection.inspectionStatus" >
                            <tags:enum-select code="InspectionStatus"></tags:enum-select>
                        </select>
                        <div id="inspectionStatusError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <label>의견</label>
                        <textarea name="inspectionOpinion" class="w-100" rows="10" v-model="check.inspection.inspectionOpinion" ></textarea>
                        <div id="inspectionOpinionError" class="invalid-feedback"></div>
                    </div>
                </div>
            </div>
            <div class="card-footer" >
                <div class="row ">
                    <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                    <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletecheck">삭제</button></div>
                    <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
                </div>
            </div>
        </div>
    </div>
</script>

<script>


    var checkInfoComponent = {
        template: '#check-info-component',
        components: {
            'event-info-component': eventInfoComponent,
            'human-info-component': humanInfoComponent,
            'news-info-component': newsInfoComponent,
            'wedding-info-component': weddingInfoComponent,
        },
        mounted: function () {

            var self = this;


            $('#inspectionDate').datetimepicker({
                format:'Y-m-d H:i',
                onChangeDateTime:function(dp,$input){
                    self.check.inspection.inspectionDate = $input.val() ;
                }
            });

        },
        watch: {
            check: function(){
                if (this.isFirst)
                {
                    this.check.contentType = this.check.contentType.code;
                    this.check.payment.paymentStatus = this.check.payment.paymentStatus.code;
                    this.check.inspection.inspectionDate = this.check.inspection.inspectionDate != null ? dateFormat(this.check.inspection.inspectionDate,'YYYY-MM-DD HH:mm') : '';
                    this.check.inspection.inspectionStatus = this.check.inspection.inspectionStatus.code;

                    if(this.check.inspection.inspectionUser == null)
                        this.check.inspection.inspectionUser = {};
                    else
                        this.check.inspection.inspectionUser.adminType = this.check.inspection.inspectionUser.adminType.code;

                    this.isFirst = false;
                }
            },
        },
        computed: {
            isNew: function () {
                return this.$parent.id == null || this.$parent.id == '';
            },
            isUpdate: function () {
                return this.$parent.id != null && this.$parent.id != '';
            },
            contentType : function(){
                return this.check.contentType;
            }
        },
        data: function () {
            return {
                check: {
                    contentType: 'NEWS',
                    contentId: '',
                    payment: {
                        paymentStatus : 'WAIT',
                        price : 0,
                    },
                    inspection: {
                        inspectionUser : {},
                        inspectionStatus : 'WAIT',
                    },
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
                    this.check.files = this.$refs.dropzone.getUploadFileIds();
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
                axios.post("/admin/check", this.check).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/check';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update : function(){
                var self = this;
                axios.put("/admin/check/" + this.$parent.id, this.check).then(function (res) {
                    alertUpdated();
                    setTimeout(function(){
                        self.back();
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            deletecheck : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/check/" + this.$parent.id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/check';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/check";
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
