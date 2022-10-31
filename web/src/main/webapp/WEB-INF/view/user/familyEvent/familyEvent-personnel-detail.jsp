<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/floating-news-component.jsp"/>

<div id="vue-app" class="sub event container">
    <div class="detail-header border-bottom border-2 pb-3">
        <span class="detail-category fw-bold font-size-20 color-deep-blue d-block mb-3">경조사</span>
        <span class="detail-title d-block fw-bold font-size-30 mb-2">{{personnel.title}}</span>
        <div class="d-flex justify-content-between align-items-end">
            <span class="created-date d-flex align-items-center color-border-gray">
                <span class="separator-right d-flex align-items-center">{{dateFormat(personnel.createdDate)}}({{getDay(personnel.createdDate)}}) {{timeFormat(personnel.createdDate)}}</span>{{personnel.createdName}}
            </span>
            <div class="">
                <button type="button" class="rounded-circle"><img src="/resources/img/sub/ico_share.png"/></button>
                <button type="button" class="rounded-circle"><img src="/resources/img/sub/ico_print_circle.png"/></button>
            </div>
        </div>
    </div>
    <div class="detail-contents d-flex flex-column justify-content-md-between flex-md-row">
        <div class="detail-main mt-5 text-center">
            <a :href="personnel.youtubeUrl" class="youtube bg-red font-size-18 d-inline-flex justify-content-center align-items-center py-2 px-5" target="_blank">
                <img src="/resources/img/sub/ico_youtube.png" class="mr-4" />
                유튜브 영상 확인하기
            </a>
            <div class="text-start mt-5 p-2" v-html="personnel.content">
            </div>

            <div class="detailSwiper swiper position-relative">
                <div class="swiper-wrapper">
                    <div class="swiper-slide" v-for="file in personnel.files">
                        <img :src="'/files/' + file.id" class="img-fluid w-100" />
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
                <a :href="personnel.homepageUrl" class="ihalla bg-deep-blue font-size-18 d-inline-flex justify-content-center align-items-center py-2 px-5 my-5" target="_blank">
                    <img src="/resources/img/sub/ico_link.png" class="mr-4" />
                    모바일 바로가기
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
            personnel:{
                id: 1,
                content: "",
                youtubeUrl: "",
                homepageUrl: "",
                files: [],
            },
            detailSwiper: null,
            newsList: [

            ],
            id : '${id}',
        },
        computed: {

        },
        watch: {
            personnel : function(){
                this.personnel.content = this.lineToBr(this.personnel.content);
            }
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
                this.detailSwiper = new Swiper('.detailSwiper', detailOption);
                this.fetch();
                this.fetchByNews();
            },
            fetch: function (page) {
                var self = this;
                axios.get("/familyEvent/detail/" + this.id, {data: {}}).then(function (data) {
                    self.personnel = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByNews: function (page) {
                var self = this;
                axios.get("/news/list?page=0&size=5" , {data: {}}).then(function (data) {
                    self.newsList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            lineToBr : function(html){
                html = html.replace(/\r\n/gi, '<br>');
                html = html.replace(/\\n/gi, '<br>');
                html = html.replace(/\n/gi, '<br>');
                return html
            },
            dateFormat : function(date){
                return dateFormat(date, 'YYYY. MM.DD');
            },
            timeFormat : function(date){
                return dateFormat(date, 'HH:mm');
            },
            getDay : function(date){
                return getDay(date);
            }
        }
    });

</script>
