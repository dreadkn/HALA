<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/member-info-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/member-subscription-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/member-contents-component.jsp"/>

<div id="vue-app" class="sub term service container">
    <div class="common-header pb-3">
        <div class="text-center py-5">
            <span class="font-size-45 fw-bolder d-block mb-4">서비스 이용약관</span>
        </div>
    </div>
    <div class="term-contents my-5 mx-auto font-size-18 color-gray">
        <div v-html="termContents"></div>
    </div>
</div>
<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'member-info-component': memberInfoComponent,
            'member-subscription-component': memberSubscriptionComponent,
            'member-contents-component' : memberContentsComponent,
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
                axios.get("/term/policy/POLICY_USE" , {data: {}}).then(function (data) {
                    self.termContents = data.data.contents;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
        }
    });

</script>
