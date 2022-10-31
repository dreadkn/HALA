<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/member-info-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/member-subscription-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/member-contents-component.jsp"/>

<div id="vue-app" class="sub member mypage container">
    <div class="common-header pb-3">
        <div class="text-center py-5">
            <span class="font-size-45 fw-bolder d-block mb-4">마이페이지</span>
        </div>
    </div>
    <div class="mypage-contents my-5 mx-auto text-center">
        <ul class="nav nav-tabs border-bottom-0" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link w-100 active" id="myInfo-tab" data-bs-toggle="tab" data-bs-target="#myInfo" type="button" role="tab" aria-controls="myInfo" aria-selected="true">내정보</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link w-100" id="subscription-tab" data-bs-toggle="tab" data-bs-target="#subscription" type="button" role="tab" aria-controls="subscription" aria-selected="false">구독관리</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link w-100" id="contents-tab" data-bs-toggle="tab" data-bs-target="#contents" type="button" role="tab" aria-controls="contents" aria-selected="false">컨텐츠</button>
            </li>
        </ul>
        <div class="tab-content text-start">
            <div class="tab-myInfo tab-pane fade show active" id="myInfo" role="tabpanel" aria-labelledby="myInfo-tab">
                <member-info-component></member-info-component>
            </div>
            <div class="tab-subscription tab-pane fade" id="subscription" role="tabpanel" aria-labelledby="profile-tab">
                <member-subscription-component></member-subscription-component>
            </div>
            <div class="tab-contents tab-pane fade" id="contents" role="tabpanel" aria-labelledby="contact-tab">
                <member-contents-component></member-contents-component>
            </div>
        </div>
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
        },
        data: {
            formData:{
            },
            term: false
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

        }
    });

</script>
