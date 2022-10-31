<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/sub-header-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/term-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/family-event-wedding-form-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/family-event-obituary-form-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/family-event-personnel-form-component.jsp"/>

<div id="vue-app" class="sub familyEvent container">
    <sub-header-component :sub-header-info="subHeaderInfo"></sub-header-component>
    <div class="form-contents">
        <span class="form-title d-block fw-bolder font-size-30">우리지역 경조사를 전하고 싶으신가요? 등록하신 콘텐츠는 검수 후 등록됩니다.</span>
        <span class="form-sub-title d-block font-size-18 my-3">내용을 입력하신 후 등록하기 버튼을 클릭하세요.</span>
        <div class="border-top border-bottom border-1 border-dark px-4 py-4 mb-5">
            <div class="row">
                <label class="col-sm-2 col-form-label h-100">경조사 구분</label>
                <div class="col-sm-10">
                    <div class="form-input-div pb-3">
                        <button type="button" class="btn-outline-circle-common" :class="{active : type === 'wedding'}" @click="setType('wedding')">화촉</button>
                        <button type="button" class="btn-outline-circle-common" :class="{active : type === 'obituary'}" @click="setType('obituary')">부고</button>
                        <button type="button" class="btn-outline-circle-common" :class="{active : type === 'personnel'}" @click="setType('personnel')">인사</button>
                    </div>
                </div>
            </div>
            <family-event-wedding-form-component @setformdata="setFormData" v-if="type === 'wedding'"></family-event-wedding-form-component>
            <family-event-obituary-form-component @setformdata="setFormData" v-if="type === 'obituary'"></family-event-obituary-form-component>
            <family-event-personnel-form-component @setformdata="setFormData" v-if="type === 'personnel'"></family-event-personnel-form-component>

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
            'term-component': termComponent,
            'family-event-wedding-form-component': familyEventWeddingFormComponent,
            'family-event-obituary-form-component': familyEventObituaryFormComponent,
            'family-event-personnel-form-component': familyEventPersonnelFormComponent,
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            formData:{
            },
            type: 'wedding',
            subHeaderInfo:{
                title:"우리지역 경조사 소식",
                category: '경조사',
                formYn: true,
                writeFormUrl: '/familyEvent/form'
            },
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
            fetchByPrice: function () {
                var self = this;
                axios.get("/familyEvent/price" , {data: {}}).then(function (data) {
                    self.contentPolicy = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            setFormData: function(formData){
                var self = this;
                self.formData = {...formData};
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
            setType(type){
                this.type = type;
            },
            submit : function(){

                if (this.$refs.dropzone != null) {
                    this.formData.files = this.$refs.dropzone.getUploadFileIds();
                }

                var self = this;
                axios.post("/familyEvent", this.formData).then(function (res) {
                    alertSuccess('등록 요청되었습니다.');
                    setTimeout(function(){
                        location.href = contextPath + '/familyEvent';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
        }
    });

</script>
