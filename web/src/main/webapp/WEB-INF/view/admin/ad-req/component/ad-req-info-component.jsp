<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>
<%@ include file="/WEB-INF/view/common/dropzone-second.jsp" %>

<script type="text/x-template" id="ad-info-component">
    <div>
        <div class="card card-light">
            <div class="card-header card-header-tab py-3">
                <div class="d-flex justify-content-between">
                    <h3 class="card-title text-bold">광고 신청 정보</h3>
                </div>
            </div>

            <div class="card-body" >

                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>광고구분</label>
                        <select class="form-select" v-model="ad.adType" >
                            <tags:enum-select code="AdType"></tags:enum-select>
                        </select>
                        <div id="adTypeError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-12">
                                <label class="mw-2"><small class="text-danger">*</small>공개여부</label>
                            </div>
                            <div class="col-12">
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="isPublicY" name="isPublic" :value="true" v-model="ad.isPublic">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isPublicY" class="mr-5">공개</label>
                                <label class="radio-button-wrap mx-3">
                                    <input type="radio" id="isPublicN" name="isPublic" :value="false" v-model="ad.isPublic">
                                    <span class="radio-button"></span>
                                </label>
                                <label for="isPublicN">비공개</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>업체명</label>
                        <input type="text" class="form-control" name="companyName" v-model="ad.companyName"   >
                        <div id="companyNameError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>담당자</label>
                        <input type="text" class="form-control" name="charger" v-model="ad.charger"   >
                        <div id="chargerError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>연락처</label>
                        <input type="text" class="form-control" name="tel" v-model="ad.tel"   >
                        <div id="telError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-8">
                        <label>링크</label>
                        <input type="text" class="form-control" name="url" v-model="ad.url"   >
                        <div id="urlError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>기간구분</label>
                        <select class="form-select" v-model="ad.periodType" >
                            <tags:enum-select code="PeriodType"></tags:enum-select>
                        </select>
                        <div id="periodTypeError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1"><small class="text-danger">*</small>광고 기간</label>
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
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <legend class="col-form-label pt-0 font-weight-bold">이미지</legend>
                        <div class="input-group mb-3">
                            <dropzone-component ref="dropzone" :files="ad.files" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></dropzone-component>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <legend class="col-form-label pt-0 font-weight-bold">모바일 이미지</legend>
                        <div class="input-group mb-3">
                            <dropzone-second-component ref="secondDropzone" :files="ad.mobileFiles" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></dropzone-second-component>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer" >
                <div class="row ">
                    <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                    <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletead">삭제</button></div>
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
                        <input type="text" class="form-control" id="approveNumber" v-model="ad.payment.approveNumber" >
                        <div id="approveNumberError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>비용</label>
                        <input type="text" class="form-control" id="price" v-model="ad.payment.price" >
                        <div id="priceError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>결제상태</label>
                        <select class="form-select" v-model="ad.payment.paymentStatus" >
                            <tags:enum-select code="PaymentStatus"></tags:enum-select>
                        </select>
                        <div id="paymentStatusError" class="invalid-feedback"></div>
                    </div>
                </div>
            </div>
            <div class="card-footer" >
                <div class="row ">
                    <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                    <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletead">삭제</button></div>
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
                        <input type="text" class="form-control" id="name" v-model="ad.inspection.inspectionUser.name" readonly  >
                        <div id="nameError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>검수일시</label>
                        <input type="text" class="form-control" id="inspectionDate" v-model="ad.inspection.inspectionDate" >
                        <div id="inspectionDateError" class="invalid-feedback"></div>
                    </div>
                    <div class="form-group col-md-4">
                        <label>검수상태</label>
                        <select class="form-select" v-model="ad.inspection.inspectionStatus" >
                            <tags:enum-select code="InspectionStatus"></tags:enum-select>
                        </select>
                        <div id="inspectionStatusError" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <label>의견</label>
                        <textarea name="inspectionOpinion" class="w-100" rows="10" v-model="ad.inspection.inspectionOpinion" ></textarea>
                        <div id="inspectionOpinionError" class="invalid-feedback"></div>
                    </div>
                </div>
            </div>
            <div class="card-footer" >
                <div class="row ">
                    <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                    <div class="col-auto" v-if="isUpdate"><button type="button" class="btn btn-danger" @click="deletead">삭제</button></div>
                    <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}</button></div>
                </div>
            </div>
        </div>
    </div>
</script>

<script>


    var adInfoComponent = {
        template: '#ad-info-component',
        mounted: function () {
            let self = this;

            $('#startDate').datetimepicker({
                format:'Y-m-d',
                timepicker: false,
                onChangeDateTime:function(dp,$input){
                    self.startDate = $input.val();
                    self.ad.startDate = new Date($input.val() + ' 00:00:00');
                }
            });

            $('#endDate').datetimepicker({
                format:'Y-m-d',
                timepicker: false,
                onChangeDateTime:function(dp,$input){
                    self.endDate = $input.val();
                    self.ad.endDate = new Date($input.val() + ' 00:00:00');
                }
            });
        },
        watch: {
            ad: function(){
                this.ad.adType = this.ad.adType.code;
                this.startDate = dateFormat(this.ad.startDate, 'YYYY-MM-DD');
                this.endDate = dateFormat(this.ad.endDate, 'YYYY-MM-DD');
                this.ad.inspection.inspectionDate = this.ad.inspection.inspectionDate != null ? dateFormat(this.ad.inspection.inspectionDate,'YYYY-MM-DD HH:mm') : '';
                this.ad.payment.paymentStatus = this.ad.payment.paymentStatus.code;
                this.ad.inspection.inspectionStatus = this.ad.inspection.inspectionStatus.code;
                this.ad.inspection.inspectionUser.adminType = this.ad.inspection.inspectionUser.adminType.code;
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
                ad: {
                    isPublic: true,
                    adType: 'MAIN_BANNER',
                    periodType: 'MONTH',
                    companyName: '',
                    charger: '',
                    tel: '',
                    url: '',
                    startDate: '',
                    endDate: '',
                    readCount: 0,
                    payment: {
                        paymentStatus : 'WAIT',
                        price : 0,
                    },
                    inspection: {
                        inspectionUser : {},
                        inspectionStatus : 'WAIT',
                    },
                    files: [],
                    mobileFiles: [],
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

                if (this.$refs.dropzone != null) {
                    this.ad.files = this.$refs.dropzone.getUploadFileIds();
                }

                if (this.$refs.dropzone != null) {
                    this.ad.mobileFiles = this.$refs.secondDropzone.getUploadFileIds();
                }

                this.ad.payment.price = Number(this.ad.payment.price);

                if(self.isNew)
                {
                    self.add();
                }
                else
                    self.update();
            },
            add : function(){
                var self = this;
                axios.post("/admin/ad-req", this.ad).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/admin/ad-req';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update : function(){
                var self = this;
                axios.put("/admin/ad-req/" + this.$parent.id, this.ad).then(function (res) {
                    alertUpdated();
                    setTimeout(function(){
                        self.back();
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            deletead : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/ad-req/" + this.$parent.id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/ad-req';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/ad-req";
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
