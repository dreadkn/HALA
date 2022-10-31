<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/sub-header-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-input-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-image-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-link-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/term-component.jsp"/>
<jsp:include page="/WEB-INF/view/common/user-dropzone.jsp"/>

<div id="vue-app" class="sub news container">
    <sub-header-component :sub-header-info="subHeaderInfo"></sub-header-component>
    <div class="form-contents">
        <span class="form-title d-block fw-bolder font-size-30">우리지역 뉴스를 전하고 싶으신가요? 등록하신 콘텐츠는 검수 후 등록됩니다.</span>
        <span class="form-sub-title d-block font-size-18 my-3">내용을 입력하신 후 등록하기 버튼을 클릭하세요.</span>
        <div class="border-top border-bottom border-1 border-dark px-4 py-4 mb-5">
            <form-input-component :title="'제목'" :placeholder="'제목을 입력해 주세요'" :description="''" :length="30" :type="'input'" :data="formData.title" :field="'title'" @setdata="setData"></form-input-component>
            <form-input-component :title="'내용'" :placeholder="'내용을 입력해 주세요'" :description="''" :length="10000" :type="'textarea'" :data="formData.content" :field="'content'" @setdata="setData"></form-input-component>
            <dropzone-component ref="dropzone" :files="formData.files" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></dropzone-component>
            <form-link-component :type="'homepage'" :url-data="formData.homepageUrl" :url-field="'homepageUrl'" :title-data="formData.homepageUrl" :title-field="'homepageUrl'" @setdata="setData"></form-link-component>
            <form-link-component :type="'youtube'" :url-data="formData.youtubeUrl" :url-field="'youtubeUrl'" @setdata="setData"></form-link-component>
        </div>
    </div>
    <term-component :title="'콘텐츠 수집 및 이용 안내'" :term-contents="termContents" :term="term" @term="checkTerm"></term-component>
    <div class="form-btn-wrapper text-center mt-3">
        <button type="button" class="submit bg-deep-blue font-size-22 py-3" @click="submit">
            등록하기
            <span class="amount d-block font-size-18">{{contentPolicy.price}}원 결제</span>
        </button>
    </div>
</div>
<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'sub-header-component': subHeaderComponent,
            'form-input-component': formInputComponent,
            'form-image-component': formImageComponent,
            'form-link-component': formLinkComponent,
            'term-component': termComponent,
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            formData:{
                isPublic: false,
                title: '',
                content: '',
                homepageUrl: '',
                youtubeUrl: '',
                readCount: 0,
                files: [],
            },
            subHeaderInfo:{
                title:"내가 만드는 우리지역 뉴스",
                category: '뉴스',
                formYn: true,
                writeFormUrl: '/news/form'
            },
            acceptedFiles : 'image/*',
            term: false,
            termContents:'',
            contentPolicy:{},
        },
        computed: {

        },
        watch: {

        },
        updated: function(){

        },
        methods: {
            init: function(){
                this.fetchByContent();
                this.fetchByPrice();
            },
            setData: function(field, data){
                this.formData[field] = data;
            },
            checkTerm: function(){
                var self = this;
                self.term = !self.term;
            },
            fetchByContent: function () {
                var self = this;
                axios.get("/term/policy/POLICY_CONTENT" , {data: {}}).then(function (data) {
                    self.termContents = data.data.contents;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByPrice: function () {
                var self = this;
                axios.get("/news/price" , {data: {}}).then(function (data) {
                    self.contentPolicy = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            submit : function(){

                if (this.$refs.dropzone != null) {
                    this.formData.files = this.$refs.dropzone.getUploadFileIds();
                }

                var self = this;
                axios.post("/news", this.formData).then(function (res) {
                    alertSuccess('등록 요청되었습니다.');
                    setTimeout(function(){
                        location.href = contextPath + '/news';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
        }
    });

</script>
