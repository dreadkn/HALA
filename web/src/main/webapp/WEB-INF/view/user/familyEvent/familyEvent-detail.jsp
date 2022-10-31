<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/floating-news-component.jsp"/>

<div id="vue-app" class="sub event container">
    <div class="detail-header border-bottom border-2 pb-3">
        <span class="detail-category fw-bold font-size-20 color-deep-blue d-block mb-3">경조사</span>
        <span class="detail-title d-block fw-bold font-size-30 mb-2">신랑 {{wedding.groom}}군 ♥ 신부 {{wedding.bride}}양</span>
        <div class="d-flex justify-content-between align-items-end">
            <span class="created-date d-flex align-items-center color-border-gray">
                <span class="separator-right d-flex align-items-center">2022. 08.03(수) 08:56</span>홍길동
            </span>
            <div class="">
                <button type="button" class="rounded-circle"><img src="/resources/img/sub/ico_share.png"/></button>
                <button type="button" class="rounded-circle"><img src="/resources/img/sub/ico_print_circle.png"/></button>
            </div>
        </div>
    </div>
    <div class="detail-contents d-flex flex-column justify-content-md-between flex-md-row">
        <div class="detail-main mt-5 text-center">
            <a href="https://www.youtube.com" class="youtube bg-red font-size-18 d-inline-flex justify-content-center align-items-center py-2 px-5" target="_blank">
                <img src="/resources/img/sub/ico_youtube.png" class="mr-4" />
                유튜브 영상 확인하기
            </a>
            <div class="text-start mt-5 p-2">
                피로연 안내
                <br />
                <ul class="wedding-groom">
                    <li>신랑 : {{wedding.groom}} 군{{wedding.groomJob.length > 0 ? '('+wedding.groomJob+')' : ''}}</li>
                    <li v-if="wedding.groomFather">신랑 부 : {{wedding.groomFather}}{{wedding.groomFatherJob.length > 0 ? '('+wedding.groomFatherJob+')' : ''}}</li>
                    <li v-if="wedding.groomMother">신랑 모 : {{wedding.groomMother}}{{wedding.groomMotherJob.length > 0 ? '('+wedding.groomMotherJob+')' : ''}}</li>
                </ul>
                <ul class="wedding-bride">
                    <li>신부 : {{wedding.bride}} 군{{wedding.brideJob.length > 0 ? '('+wedding.brideJob+')' : ''}}</li>
                    <li v-if="wedding.brideFather">신부 부 : {{wedding.brideFather}}{{wedding.brideFatherJob.length > 0 ? '('+wedding.brideFatherJob+')' : ''}}</li>
                    <li v-if="wedding.brideMother">신부 모 : {{wedding.brideMother}}{{wedding.brideMotherJob.length > 0 ? '('+wedding.brideMotherJob+')' : ''}}</li>
                </ul>
                <br />
                <div class="wedding-reception wedding-reception-ymd">
                    <span class="d-block">피로연 일시</span>
                    <span>{{wedding.receptionTime}}</span>
                </div>
                <div class="wedding-reception wedding-reception-location mt-3">
                    <span class="d-block">피로연 장소</span>
                    <span>{{wedding.receptionLocation}}</span>
                </div>
                <br />
                <ul class="wedding-location mt-5">
                    <li>■ 일시 : {{wedding.weddingTime}}</li>
                    <li>■ 장소 : {{wedding.weddingLocation}}</li>
                </ul>
            </div>

            <div class="detailSwiper swiper position-relative">
                <div class="swiper-wrapper">
                    <div class="swiper-slide" v-for="n in 4">
                        <img src="/resources/img/sub/familyEvent_detail_sample.png" class="img-fluid w-100" />
                    </div>
                </div>
                <div class="navigation-wrapper position-absolute d-flex justify-content-between align-items-center">
                    <button type="button" class="swiper-button detail-swiper-button-prev d-flex justify-content-center align-items-center">
                        <img src="/resources/img/sub/ico_prev_arrow_white.png" />
                    </button>
                    <button type="button" class="swiper-button detail-swiper-button-next d-flex justify-content-center align-items-center">
                        <img src="/resources/img/sub/ico_next_arrow_white.png" />
                    </button>
                </div>
            </div>
            <div class="border-bottom">
                <a href="http://www.ihalla.com/" class="ihalla bg-deep-blue font-size-18 d-inline-flex justify-content-center align-items-center py-2 px-5 my-5" target="_blank">
                    <img src="/resources/img/sub/ico_link.png" class="mr-4" />
                    모바일 청첩장 바로가기
                </a>
            </div>
        </div>
        <floating-news-component :news-list="newsList"></floating-news-component>
    </div>
</div>
<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'floating-news-component': floatingNewsComponent
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            wedding: {
                id: 1,
                groom: "홍길동",
                groomJob: "하나은행 본점 리스크 관리부",
                groomFather: "신랑 아버지",
                groomFatherJob:"JDC 이사장/제주대 명예교수",
                groomMother: "신랑 어머니",
                groomMotherJob:"前 중등교사",

                bride: "송혜교",
                brideJob: "서울소재 초등교사",
                brideFather: "신부 아버지",
                brideFatherJob:"(주)양지유통 대표, 前 농업회사법인 한라양계 대표",
                brideMother: "신부 어머니",
                brideMotherJob:"",

                weddingTime:"2022년 6월 19일(일) 오전 11시",
                weddingLocation: "라마다프라자 제주호텔 2층 라마다볼룸",

                receptionTime: "2022년 6월 19일(일/당일) 오전 11시 ~ 오후 5시",
                receptionLocation: "라마다프라자 제주호텔 2층 라마다볼룸"
            },
            detailSwiper: null,
            newsList: [

            ]
        },
        computed: {

        },
        watch: {

        },
        updated: function(){

        },
        methods: {
            init: function(){
                var detailOption = {
                    navigation: {
                        nextEl: ".detail-swiper-button-next",
                        prevEl: ".detail-swiper-button-prev",
                    },
                }
                self.detailSwiper = new Swiper('.detailSwiper', detailOption);
            },
        }
    });

</script>
