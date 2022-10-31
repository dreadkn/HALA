<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/form-input-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/term-component.jsp"/>

<div id="vue-app" class="sub member join container">
    <div class="login-contents my-5">
        <term-component :title="'서비스 이용약관'" :term-contents="termServiceContents" :term="termService" @term="checkServiceTerm"></term-component>
        <term-component :title="'개인정보 처리방침'" :term-contents="termPrivateContents" :term="termPrivate" @term="checkPrivateTerm"></term-component>
        <div class="form-contents">
            <div class="color-deep-blue text-end">
                * 필수 입력사항
            </div>
            <div class="border-top border-bottom border-1 border-dark px-4 py-4 mb-5">
                <form-input-component :title="'아이디'" :required="true" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.userId" :field="'userId'" @setdata="setData"></form-input-component>
                <form-input-component :title="'비밀번호'" :required="true" :placeholder="'8~20자의 영문 대/소문자,숫자,특수문자 한개 이상을 사용해주세요 '" :description="''" :length="0" :type="'input'" :data="formData.password" :field="'password'" @setdata="setData" :text-type="'password'"></form-input-component>
                <form-input-component :title="'비밀번호 확인'" :required="true" :placeholder="'비밀번호를 다시 한 번 입력해주세요'" :description="''" :length="0" :type="'input'" :data="formData.passwordConfirm" :field="'passwordConfirm'" @setdata="setData" :text-type="'password'"></form-input-component>
                <form-input-component :title="'이름'" :required="true" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.name" :field="'name'" @setdata="setData"></form-input-component>
                <form-input-component :title="'연락처'" :required="true" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.phone" :field="'phone'" @setdata="setData"></form-input-component>
                <form-input-component :title="'이메일'" :required="true" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.email" :field="'email'" @setdata="setData"></form-input-component>
                <div class="border-top pt-4">
                    <div class="row pt-3">
                        <label class="col-sm-2 col-form-label h-100 font-size-18">알림설정</label>
                        <div class="col-sm-10">
                            <div class="form-input-div pb-3">
                                <span role="button" @click="notificationPush = !notificationPush">
                                    <img src="/resources/img/sub/ico_uncheck.png" class="ico-check-img" v-if="!notificationPush" />
                                    <img src="/resources/img/sub/ico_check.png" class="ico-check-img" v-if="notificationPush" />
                                    정보 및  광고성 PUSH 알림 허용
                                </span>
                            </div>
                            <div class="form-input-div pb-3">
                                <span role="button" @click="notificationEmail = !notificationEmail">
                                    <img src="/resources/img/sub/ico_uncheck.png" class="ico-check-img" v-if="!notificationEmail" />
                                    <img src="/resources/img/sub/ico_check.png" class="ico-check-img" v-if="notificationEmail" />
                                    정보 및  광고성 이메일 알림 허용
                                </span>
                            </div>
                            <div class="form-input-div pb-3">
                                PUSH, 이메일 알림을 차단하여도 서비스 운영상 필요한 필수 알림은 발송될 수 있습니다
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-btn-wrapper text-center mt-5">
            <button type="button" class="submit bg-deep-blue font-size-22 py-3" @click="signup">
                회원가입
            </button>
        </div>
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
        },
        data: {
            formData:{
                adminType: 'USER',
                userId: '',
                password: '',
                passwordConfirm: '',
                name: '',
                phone: '',
                email: '',
                language1: 'ko',
                language2: 'ko',
                addressJibun: '',
                addressRoad: '',
                zipCode: '',
                contentCount: 0,
                adCount: 0,
                isSubscribe: false,
                lastLoginDate: '',
                subscribeUpdateCount: '',
                isWithdrawal: false,
                enabled: true,
                isPushAlarm: true,
                isEmailAlarm: true,
                withdrawalDate: '',
            },
            termService: false,
            termServiceContents: '',
            termPrivate: false,
            termPrivateContents: '',
            notificationPush: false,
            notificationEmail: false
        },
        computed: {

        },
        watch: {
            notificationPush : function(data){
                this.formData.isPushAlarm = data;
            },
            notificationEmail : function(data){
                this.formData.isEmailAlarm = data;
            },

        },
        updated: function(){

        },
        methods: {
            init: function(){
                this.fetchByUse();
                this.fetchByPrivacy();
            },
            fetchByUse: function () {
                var self = this;
                axios.get("/term/policy/POLICY_USE" , {data: {}}).then(function (data) {
                    self.termServiceContents = data.data.contents;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByPrivacy: function () {
                var self = this;
                axios.get("/term/policy/POLICY_PRIVACY" , {data: {}}).then(function (data) {
                    self.termPrivateContents = data.data.contents;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            setData: function(field, data){
                this.formData[field] = data;
            },
            checkServiceTerm: function(){
                var self = this;
                self.termService = !self.termService;
            },
            checkPrivateTerm: function(){
                var self = this;
                self.termPrivate = !self.termPrivate;
            },
            signup : function(){
                var self = this;
                axios.post("/member/signup", this.formData).then(function (res) {
                    alertRegistered();
                    setTimeout(function(){
                        location.href = contextPath + '/member/login';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },

        }
    });

</script>
