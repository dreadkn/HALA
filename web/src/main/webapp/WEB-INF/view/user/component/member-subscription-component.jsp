<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/19
  Time: 16:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="member-subscription-component">
    <div v-if="!subscriptionFlag">
        <div class="member-subscription-wrapper text-center mx-auto">
            <span class="font-size-20 d-block my-5 py-5">굿모닝제주 플랫폼을 구독하시면 콘텐츠, 광고 등록 혜택이 제공됩니다.</span>
            <div class="form-terms pb-5">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <div>
                        <span class="color-deep-blue">[필수]</span> 굿모닝제주 플랫폼 구독 약관
                    </div>
                    <span role="button" @click="checkTerm">
                <img src="/resources/img/sub/ico_uncheck.png" class="ico-check-img" v-if="!term" />
                <img src="/resources/img/sub/ico_check.png" class="ico-check-img" v-if="term" />
                동의합니다.
            </span>
                </div>
                <div class="terms-contents p-4 text-start">
                    굿모닝제주 플랫폼 구독자 이용 약관입니다.<br/>
                    - 구독시 콘텐츠 등록 10건, 광고 등록 3건의 혜택을 제공합니다.<br/>
                    - 제공되는 혜택은 구독기간내 사용 가능하며 기간내 미사용한 경우 자동 소멸됩니다.<br/>
                    1회 구독시 구독기간은 1년이며 만료 전 자동 연장됩니다.
                </div>
            </div>
        </div>
        <div class="text-center d-flex flex-column flex-sm-row justify-content-center mt-5 pt-4">
            <button type="button" class="submit bg-deep-blue font-size-22 fw-bolder py-3 mb-3 w-100" @click="subscribeView">구독하기</button>
        </div>
    </div>
    <div class="member-subscription-wrapper mx-auto mt-5 my-5" v-else>
        <div class="member-subscription-range d-flex flex-column flex-sm-row justify-content-between align-items-start">
            <div class="">
                <span class="d-block font-size-30 fw-bolder mb-3">구독기간</span>
                <span class="d-block color-border-gray font-size-20 fw-lighter mb-3">{{dateFormat(policy.startDate)}} ~ {{dateFormat(policy.endDate)}}</span>
            </div>
            <span class="color-border-gray pb-3 pb-sm-0">콘텐츠 등록 {{policy.contentCount}}개, 광고 1개월 {{policy.adCount}}건 제공</span>
        </div>
        <div class="member-subscription-info d-flex p-3 border">
            <div class="d-flex flex-column justify-content-center border-right pr-5">
                <span class="d-block font-size-20"><span class="fw-bolder font-size-25">{{member.name}}</span>님</span>
                <span class="ont-size-20">구독혜택</span>
            </div>
            <ul>
                <li class="font-size-20"><img src="/resources/img/sub/ico_bullet.png" class="mr-3"/>콘텐츠 등록 <span class="color-deep-blue font-size-35">{{policy.contentLeftCount}}</span> / {{policy.contentCount}}</li>
                <li class="font-size-20"><img src="/resources/img/sub/ico_bullet.png" class="mr-3"/>광고 1개월 <span class="color-deep-blue font-size-35">{{policy.adLeftCount}}</span> / {{policy.adCount}}</li>
            </ul>
        </div>
        <div class="text-end color-border-gray py-3 px-2">
            · 굿모닝제주 플랫폼 구독 기간은 1년이며 만료 전 자동 연장됩니다.<br>
            · 구독 갱신 시 구독 혜택은 변경될 수 있습니다.
        </div>
        <button type="button" class="bg-border-gray font-size-22 fw-bolder py-3 mb-3 w-100" v-if="isSubscribe" @click="unsubscribe">구독해제</button>
        <button type="button" class="bg-border-gray font-size-22 fw-bolder py-3 mb-3 w-100" v-if="!isSubscribe" @click="subscribe">구독하기({{policy.price}}원)</button>
    </div>
</script>


<script>
    var memberSubscriptionComponent = {
        template: '#member-subscription-component',
        mounted: function () {
            this.fetch();
            this.fetchByPolicy();
            this.fetchBySubscriber();
        },
        watch: {
            member : function(){
                this.member.adminType = this.member.adminType.code;
                this.subscriptionFlag = this.member.isSubscribe;
            },
            subscriber : function(){
                if(this.isSubscribe)
                {
                    this.policy.startDate = this.subscriber.startDate;
                    this.policy.endDate = this.subscriber.endDate;
                    this.policy.adLeftCount = this.subscriber.adLeftCount;
                    this.policy.contentLeftCount = this.subscriber.contentLeftCount;
                    this.policy.adCount = this.subscriber.subscribeBenefit.adCount;
                    this.policy.contentCount = this.subscriber.subscribeBenefit.contentCount;
                }
                else {
                    this.subscriber = {
                        member: this.member,
                        startDate: this.policy.startDate,
                        endDate: this.policy.endDate,
                        charger: '',
                        tel: '',
                        contentLeftCount: this.policy.contentLeftCount,
                        adLeftCount: this.policy.adLeftCount,
                        payment: {},
                        subscribeBenefit: {},
                    }
                }
            },
            policy : function(){
                this.policy.adLeftCount = this.policy.adCount;
                this.policy.contentLeftCount = this.policy.contentCount;
            }
        },
        computed: {
            isSubscribe : function(){
                return this.member.isSubscribe;
            }
        },
        props: [],
        data: function () {
            return {
                subscriptionFlag : false,
                term: false,
                member : {},
                subscriber : {
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
                policy : {},
            }
        },
        methods: {
            fetch: function () {
                var self = this;
                axios.get("/member/info", {data: {}}).then(function (data) {
                    self.member = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByPolicy: function () {
                var self = this;
                axios.get("/member/subscribe/policy", {data: {}}).then(function (data) {
                    self.policy = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchBySubscriber: function () {
                var self = this;
                axios.get("/member/subscribe", {data: {}}).then(function (data) {
                    self.subscriber = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            checkTerm: function(){
                var self = this;
                self.term = !self.term;
            },
            dateFormat: function(date){
                return dateFormat(date, 'YYYY~MM~DD');
            },
            subscribeView : function(){
                if (!this.term)
                {
                    alertWarning('구독 약관에 동의해야 합니다.');
                    return false;
                }

                this.subscriptionFlag = true;
            },
            subscribe : function(){
                var self = this;
                alertConfirm(function(result){
                    axios.post("/member/subscribe", self.subscriber).then(function (res) {
                        alertSuccess("구독자가 되었습니다.");
                        setTimeout(function(){
                            location.reload();
                        },1500)
                    }).catch(function (err) {
                        displayErrors(err);
                    });
                }, '구독하시겠습니까?');

            },
            unsubscribe : function(){
                var self = this;
                alertConfirm(function(result){

                    axios.post("/member/unsubscribe", {data:{}}).then(function (res) {
                        alertSuccess("구독 해제되었습니다.");
                        setTimeout(function(){
                            location.reload();
                        },1500)
                    }).catch(function (err) {
                        displayErrors(err);
                    });
                }, '구독 해제 하시겠습니까?');
            },

        }
    }
</script>
