<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/main-personnel-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/obituary-container-component.jsp"/>

<div id="vue-app" class="main container">
    <div class="">
<%--        메인베너--%>
        <div class="main-banner mt-4">
            <div class="mainBannerSwiper swiper">
                <div class="swiper-wrapper">
                    <a href="/" class="swiper-slide d-block position-relative" v-for="news in newsList.slice(0,3)">
                        <img :src="getImage(news.fileId)" class="img-fluid w-100 " />
                        <div class="banner-info position-absolute left-0 top-0 w-100 h-100 d-flex justify-content-end flex-column pl-4 pb-3">
                            <span class="banner-title fw-bolder text-white w-100 text-truncate">{{news.title}}</span>
                            <p class="mt-2 d-none d-md-block color-white font-size-25 w-50 text-white word-wrap">{{getShortText(news.content, 60)}}</p>
                        </div>
                    </a>
                </div>
                <div class="main-swiper-pagination swiper-pagination text-end pr-4"></div>
            </div>
        </div>
        <hr />

<%--        뉴스--%>
        <div class="news">
            <div class="main-section-title d-flex justify-content-between align-items-center">
                <div class="fw-bold font-size-25">뉴스</div>
                <a href="/news" class="text-end font-size-20">더보기 +</a>
            </div>
            <div class="new-card-wrapper d-flex flex-wrap justify-content-between">
                <div class="d-flex position-relative" v-for="news in newsList.slice(3)">
                    <a href="/" class="news-info pr-3 d-block">
                        <div class="news-title fw-bolder">{{news.title}}</div>
                        <div class="news-content mt-2">{{getShortText(news.content,140)}}</div>
                    </a>
                    <div class="news-img">
                        <a href="/">
                            <img :src="getImage(news.fileId)" class="img-fluid w-100" />
                        </a>
                    </div>
                </div>
            </div>
            <%--        광고배너--%>
            <div class="banner-row-100">
                <a :href="adMain.url" class="d-block"><img :src="'/files/' + adMain.fileId" class="img-fluid w-100" /></a>
            </div>
        </div>
        <hr />
<%--        행사--%>
        <div class="event position-relative">
            <div class="main-section-title d-flex justify-content-between align-items-center">
                <div class="fw-bold font-size-25">행사</div>
                <a href="/event" class="text-end font-size-20">더보기 +</a>
            </div>
            <div class="mainEventSwiper swiper">
                <div class="swiper-wrapper">
                    <a href="/event" class="swiper-slide d-block" v-for="event in eventList">
                        <img :src="getImage(event.fileId)" class="img-fluid w-100" />
                        <span class="d-block text-center font-size-22 fw-bolder pt-4 pb-5">
                            {{event.title}}
                        </span>
                    </a>
                </div>
            </div>
            <div class="navigation-wrapper position-absolute">
                <button type="button" class="swiper-button event-swiper-button-prev d-flex justify-content-center align-items-center">
                    <img src="/resources/img/common/ico_prev_arrow_dark.png" />
                </button>
                <button type="button" class="swiper-button event-swiper-button-next d-flex justify-content-center align-items-center">
                    <img src="/resources/img/common/ico_next_arrow_dark.png" />
                </button>
            </div>
            <div class="event-swiper-scrollbar swiper-scrollbar p-0"></div>
        </div>
        <hr />
        <%--        광고배너--%>
        <div class="short-banner">
            <div class="d-grid">
                <a :href="ad.url" class="d-inline-block" v-for="ad in adBottoms">
                    <img :src="'/files/' + ad.fileId" class="img-fluid w-100" />
                </a>
            </div>
        </div>
        <hr />
    <%--        화촉--%>
        <div class="wedding">
            <div class="main-section-title d-flex justify-content-between align-items-center">
                <div class="fw-bold font-size-25">화촉</div>
                <a href="/familyEvent/wedding" class="text-end font-size-20">더보기 +</a>
            </div>
            <div class="d-grid">
                <a href="/" class="d-inline-block" v-for="wedding in weddingList">
                    <img :src="getImage(wedding.fileId)" class="img-fluid w-100" />
                    <span class="d-block font-size-20 fw-semibold text-center pt-3">신랑 {{wedding.groom}} 군 · 신부 {{wedding.bride}} 양</span>
                </a>
            </div>
        </div>
        <hr />
    <%--        부고--%>
        <div class="obituary">
            <div class="main-section-title d-flex justify-content-between align-items-center">
                <div class="fw-bold font-size-25">부고</div>
                <a href="/familyEvent/obituary" class="text-end font-size-20">더보기 +</a>
            </div>
            <div class="mainObituarySwiper swiper">
                <div class="swiper-wrapper">
                    <a href="/" class="swiper-slide border" v-for="obituary in obituaryList">
                        <obituary-container-component :obituary="obituary"></obituary-container-component>
                    </a>
                </div>
            </div>
            <div class="obituary-swiper-scrollbar swiper-scrollbar p-0"></div>
            <div class="banner-row-100">
                <a :href="adMain.url" class="d-block"><img :src="'/files/' + adMain.fileId" class="img-fluid w-100" /></a>
            </div>
        </div>
        <hr />
    <%--        인사--%>
        <div class="personnel">
            <div class="main-section-title d-flex justify-content-between align-items-center">
                <div class="fw-bold font-size-25">인사</div>
                <a href="/familyEvent/personnel" class="text-end font-size-20">더보기 +</a>
            </div>

            <div class="d-none d-md-flex flex-md-column">
                <div class="d-grid" >
                    <main-personnel-component :personnel="personnel" :name="i" v-for="personnel in personnelList.slice(0,3)"></main-personnel-component>
                </div>
                <template v-if="personnelList.length > 3">
                    <div class="d-grid" >
                        <main-personnel-component :personnel="personnel" :name="i" v-for="personnel in personnelList.slice(3)"></main-personnel-component>
                    </div>
                </template>
            </div>

            <div class="mainPersonnelSwiper swiper d-md-none">
                <div class="swiper-wrapper">
                    <div class="swiper-slide" >
                        <main-personnel-component :personnel="personnel" :name="i" v-for="personnel in personnelList.slice(0,3)"></main-personnel-component>
                    </div>
                    <template v-if="personnelList.length > 3">
                        <div class="swiper-slide" >
                            <main-personnel-component :personnel="personnel" :name="i" v-for="personnel in personnelList.slice(3)"></main-personnel-component>
                        </div>
                    </template>
                </div>
            </div>
            <div class="personnel-swiper-pagination swiper-pagination d-md-none"></div>
        </div>
        <hr class="mt-4"/>
    <%--        인명--%>
        <div class="peopleDictionary position-relative">
            <div class="main-section-title d-flex justify-content-between align-items-center">
                <div class="fw-bold font-size-25">인명</div>
                <a href="/peopleDictionary" class="text-end font-size-20">더보기 +</a>
            </div>
            <div class="mainPeopleDictionarySwiper swiper">
                <div class="swiper-wrapper">
                    <a href="/" class="swiper-slide d-flex align-items-center flex-column" v-for="human in humanList">
                        <img :src="getImage(human.fileId)" class="rounded-circle" />
                        <span class="d-block text-center font-size-22 fw-bold">
                            {{human.krName}}
                        </span>
                        <span class="d-block text-center font-size-18">
                            {{human.position}}
                        </span>
                    </a>
                </div>
            </div>
            <div class="navigation-wrapper position-absolute">
                <button type="button" class="swiper-button peopleDictionary-swiper-button-prev d-flex justify-content-center align-items-center">
                    <img src="/resources/img/common/ico_prev_arrow_dark.png" />
                </button>
                <button type="button" class="swiper-button peopleDictionary-swiper-button-next d-flex justify-content-center align-items-center">
                    <img src="/resources/img/common/ico_next_arrow_dark.png" />
                </button>
            </div>
        </div>
    </div>
</div>
<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'main-personnel-component': mainPersonnelComponent,
            'obituary-container-component': obituaryContainerComponent
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            mainBannerSwiper: null,
            mainEventSwiper : null,
            mainObituarySwiper: null,
            mainPersonnelSwiper: null,
            mainPeopleDictionarySwiper: null,
            personnel: {
                dept: '2022 제주도 OOO 정기인사',
                name: '제주시 부시장 안우진',
                profile: '/resources/img/main/main_profile_sample.png',
                link: '1'
            },
            newsList: [],
            eventList: [],
            weddingList: [],
            personnelList: [],
            obituaryList:[],
            humanList:[],
            adMain:{},
            adBottoms:[],
        },
        computed: {

        },
        watch: {

        },
        updated: function(){

        },
        methods: {
            init: function(){
                var mainOption = {
                    pagination: {
                        el: ".main-swiper-pagination",
                    },
                }
                var eventOption = {
                    navigation: {
                        nextEl: ".event-swiper-button-next",
                        prevEl: ".event-swiper-button-prev",
                    },
                    scrollbar: {
                        el: ".event-swiper-scrollbar",
                    },
                    breakpoints: {
                        0:{
                            slidesPerView: 1,
                            spaceBetween: 0
                        },
                        320: {
                            slidesPerView: 2,
                            spaceBetween: 10
                        },
                        768: {
                            slidesPerView: 3,
                            spaceBetween: 20
                        },
                        992: {
                            slidesPerView: 4,
                            spaceBetween: 40
                        },
                    }
                }
                var obituaryOption = {
                    scrollbar: {
                        el: ".obituary-swiper-scrollbar",
                    },
                    breakpoints: {
                        0:{
                            slidesPerView: 1,
                            spaceBetween: 0
                        },
                        551: {
                            slidesPerView: 2,
                            spaceBetween: 10
                        },
                        769: {
                            slidesPerView: 3,
                            spaceBetween: 18
                        },
                    }
                }
                var personnelOption= {
                    slidesPerView: 2,
                    pagination: {
                        el: ".personnel-swiper-pagination",
                        clickable: false,
                    },
                    breakpoints: {
                        0: {
                            slidesPerView: 1,
                            spaceBetween: 10
                        },
                        768: {
                            slidesPerView: 2,
                            spaceBetween: 10
                        },
                    }
                }
                var peopleDictionaryOption = {
                    navigation: {
                        nextEl: ".peopleDictionary-swiper-button-next",
                        prevEl: ".peopleDictionary-swiper-button-prev",
                    },
                    breakpoints: {
                        0:{
                            slidesPerView: 2,
                            spaceBetween: 0
                        },
                        450: {
                            slidesPerView: 3,
                            spaceBetween: 0
                        },
                        768: {
                            slidesPerView: 4,
                            spaceBetween: 0
                        },
                        992: {
                            slidesPerView: 5,
                            spaceBetween: 0
                        },
                        1080: {
                            slidesPerView: 6,
                            spaceBetween: 0
                        },
                    }
                }

                self.mainBannerSwiper = new Swiper('.mainBannerSwiper', mainOption);
                self.mainEventswiper = new Swiper('.mainEventSwiper', eventOption);
                self.mainObituarySwiper = new Swiper('.mainObituarySwiper', obituaryOption);
                self.mainPersonnelSwiper = new Swiper('.mainPersonnelSwiper', personnelOption);
                self.mainPeopleDictionarySwiper = new Swiper('.mainPeopleDictionarySwiper', peopleDictionaryOption);

                this.fetchByNews();
                this.fetchByEvent();
                this.fetchByWedding();
                this.fetchByDeath();
                this.fetchByPerson();
                this.fetchByHuman();
                this.fetchByAdMain();
                this.fetchByAdBottom();

            },
            fetchByNews: function (page) {
                var self = this;
                axios.get("/main/news/list" , {data: {}}).then(function (data) {
                    self.newsList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByEvent: function (page) {
                var self = this;
                axios.get("/main/event/list" , {data: {}}).then(function (data) {
                    self.eventList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByWedding: function (page) {
                var self = this;
                axios.get("/main/wedding/list" , {data: {}}).then(function (data) {
                    self.weddingList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByDeath: function (page) {
                var self = this;
                axios.get("/main/death/list" , {data: {}}).then(function (data) {
                    self.obituaryList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByPerson: function (page) {
                var self = this;
                axios.get("/main/person/list" , {data: {}}).then(function (data) {
                    self.personnelList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByHuman: function (page) {
                var self = this;
                axios.get("/main/human/list" , {data: {}}).then(function (data) {
                    self.humanList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByAdMain: function (page) {
                var self = this;
                axios.get("/banner/main" , {data: {}}).then(function (data) {
                    self.adMain = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByAdBottom: function (page) {
                var self = this;
                axios.get("/banner/bottom" , {data: {}}).then(function (data) {
                    self.adBottoms = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            getImage : function(id){
                return id == null ? '/resources/img/common/no-image.png' : '/files/' + id;
            },
            getShortText : function(text, maxLength){
                return text.length > maxLength ? text.substr(0, maxLength) + '...' : text;
            }
        }
    });

</script>
