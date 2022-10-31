<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/form-input-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/term-component.jsp"/>
<jsp:include page="/WEB-INF/view/common/user-dropzone.jsp"/>
<jsp:include page="/WEB-INF/view/common/user-second-dropzone.jsp"/>

<div id="vue-app" class="sub community report container">
    <div class="common-header pb-3">
        <div class="text-center py-5">
            <span class="font-size-45 fw-bold d-block mb-4">광고신청</span>
            광고에 대해서 문의할 점이 있다면 접수해주세요.
        </div>
    </div>
    <div class="community-form-contents form-contents my-5">
        <div class="border-top border-bottom border-1 border-dark px-4 py-4 mb-5">
            <div class="row">
                <label class="col-sm-2 col-form-label h-100 font-size-18">
                    <sup class="color-deep-blue" >*</sup>
                    광고구분
                </label>
                <div class="col-sm-10">
                    <div class="form-input-div pb-3">
                        <select v-model="formData.adType" class="form-select">
                            <tags:enum-select code="AdType"></tags:enum-select>
                        </select>
                    </div>
                    <div id="adTypeError" class="invalid-feedback"></div>
                </div>
            </div>
            <form-input-component :title="'업체명'" :placeholder="'업체명을 입력해 주세요'" :description="''" :length="30" :type="'input'" :data="formData.companyName" :field="'companyName'" @setdata="setData" required="true"></form-input-component>
            <form-input-component :title="'담당자'" :placeholder="'담당자를 입력해 주세요'" :description="''" :length="30" :type="'input'" :data="formData.charger" :field="'charger'" @setdata="setData" required="true"></form-input-component>
            <form-input-component :title="'연락처'" :placeholder="'연락처를 입력해 주세요'" :description="''" :length="30" :type="'input'" :data="formData.tel" :field="'tel'" @setdata="setData" required="true"></form-input-component>
            <form-input-component :title="'링크'" :placeholder="'링크를 입력해 주세요'" :description="''" :length="500" :type="'input'" :data="formData.url" :field="'url'" @setdata="setData" required="true"></form-input-component>
            <div class="row">
                <label class="col-sm-2 col-form-label h-100 font-size-18">
                    <sup class="color-deep-blue">*</sup>
                    광고 기간
                </label>
                <div class="col-sm-10">
                    <div class="form-input-div pb-3">
                        <select v-model="formData.periodType" class="form-select">
                            <tags:enum-select code="PeriodType"></tags:enum-select>
                        </select>
                    </div>
                    <div id="periodTypeError" class="invalid-feedback"></div>
                </div>
            </div>

            <dropzone-component ref="dropzone" :files="formData.files" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></dropzone-component>
            <second-dropzone-component ref="secondDropzone" :files="formData.mobileFiles" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></second-dropzone-component>

        </div>
    </div>
    <term-component :title="'개인정보 수집 및 활용 동의'" :term-contents="termContents" :term="term" @term="checkTerm"></term-component>
    <div class="form-btn-wrapper text-center mt-3">
        <button type="button" class="submit bg-deep-blue font-size-22 py-3" @click="submit">
            접수하기
        </button>
    </div>
</div>
<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'form-input-component': formInputComponent,
            'term-component': termComponent,
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
            this.fetchByContent();
        },
        data: {
            formData:{
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
            term: false,
            termContents:'',
            acceptedFiles : 'image/*'
        },
        computed: {

        },
        watch: {

        },
        updated: function(){

        },
        methods: {
            init: function(){
            },
            setData: function(field, data){
                this.formData[field] = data;
            },
            setFile: function($e){
                var files = $e.target.files;
                for(var i=0; i < files.length; i++){
                    this.formData.fileList.push(files[i]);
                }
            },
            btnFileUpload:function(){
                var self = this;
                self.$refs.inputFile.click();
            },
            checkTerm: function(){
                var self = this;
                self.term = !self.term;
            },
            fetchByContent: function () {
                var self = this;
                axios.get("/term/policy/POLICY_PRIVACY" , {data: {}}).then(function (data) {
                    self.termContents = data.data.contents;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            submit : function(){

                if (!this.term)
                {
                    alertWarning('개인정보 수집 및 활용에 동의해야 합니다.');
                    return false;
                }

                if (this.$refs.dropzone != null) {
                    this.formData.files = this.$refs.dropzone.getUploadFileIds();
                }

                if (this.$refs.secondDropzone != null) {
                    this.formData.mobileFiles = this.$refs.secondDropzone.getUploadFileIds();
                }

                var self = this;
                axios.post("/community/question/submit", this.formData).then(function (res) {
                    alertSuccess('신청 등록되었습니다.');
                    setTimeout(function(){
                        location.href = contextPath + '/';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
        }
    });

</script>
