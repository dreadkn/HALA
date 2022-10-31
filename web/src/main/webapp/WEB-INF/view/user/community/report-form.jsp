<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/form-input-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/term-component.jsp"/>
<jsp:include page="/WEB-INF/view/common/user-dropzone.jsp"/>

<div id="vue-app" class="sub community report container">
    <div class="common-header pb-3">
        <div class="text-center py-5">
            <span class="font-size-45 fw-bold d-block mb-4">불편신고</span>
            서비스 이용 도중 불편하셨던 점이 있다면 접수해주세요.
        </div>
    </div>
    <div class="community-form-contents form-contents my-5">
        <div class="border-top border-bottom border-1 border-dark px-4 py-4 mb-5">
            <div class="row">
                <label class="col-sm-2 col-form-label h-100 font-size-18">
                    <sup class="color-deep-blue" v-if="required">*</sup>
                    구분
                </label>
                <div class="col-sm-10">
                    <div class="form-input-div pb-3">
                        <select v-model="formData.brokenType" class="form-select">
                            <tags:enum-select code="BrokenType"></tags:enum-select>
                        </select>
                    </div>
                    <div id="brokenTypeError" class="invalid-feedback"></div>
                </div>
            </div>
            <form-input-component :title="'제목'" :placeholder="'제목을 입력해 주세요'" :description="''" :length="30" :type="'input'" :data="formData.title" :field="'title'" @setdata="setData"></form-input-component>
            <form-input-component :title="'내용'" :placeholder="'내용을 입력해 주세요'" :description="''" :length="1000" :type="'textarea'" :data="formData.content" :field="'content'" @setdata="setData"></form-input-component>
            <form-input-component :title="'이메일'" :placeholder="'이메일을 입력해 주세요'" :description="''" :type="'input'" :data="formData.email" :field="'email'" @setdata="setData"></form-input-component>

            <dropzone-component ref="dropzone" :files="formData.files" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></dropzone-component>

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
                brokenType:'NORMAL',
                title:'',
                content:'',
                email:'',
                files: []
            },
            term: false,
            termContents:'',
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

                var self = this;
                axios.post("/community/report/submit", this.formData).then(function (res) {
                    alertSuccess('신고 등록되었습니다.');
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
