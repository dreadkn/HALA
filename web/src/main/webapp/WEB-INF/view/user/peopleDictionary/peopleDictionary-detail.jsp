<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/floating-news-component.jsp"/>

<div id="vue-app" class="sub peopleDictionary container">
    <div class="detail-header border-bottom border-2 pb-3">
        <span class="detail-category fw-bold font-size-20 color-deep-blue d-block mb-3">제주인명</span>
        <div class="d-flex flex-column flex-sm-row justify-content-between align-items-end">
            <div class="d-flex align-items-baseline align-self-start">
                <span class="detail-title fw-bold font-size-30 mr-3">{{peopleDictionary.krName}}</span>
                <span class="mr-3">{{peopleDictionary.cnName}}</span>
                <span class="color-border-gray pb-2">{{peopleDictionary.enName}}</span>
            </div>
            <div class="">
                <button type="button" class="rounded-circle"><img src="/resources/img/sub/ico_share.png"/></button>
                <button type="button" class="rounded-circle"><img src="/resources/img/sub/ico_print_circle.png"/></button>
            </div>
        </div>
    </div>
    <div class="detail-contents d-flex flex-column justify-content-md-between flex-md-row">
        <div class="detail-main mt-5 text-center">
            <div class="text-start p-2 d-flex flex-column flex-sm-row justify-content-start align-items-start">
                <div class="peopleDictionary-image-wrapper text-center">
                    <template v-if="peopleDictionary.files.length > 0">
                        <img :src="'/files/' + peopleDictionary.files[0].id" class="img-fluid" />
                    </template>
                </div>
                <div>
                    <table>
                        <tr>
                            <th class="align-top pr-3 pb-2 fw-bolder">년생</th>
                            <td class="color-border-gray pb-2">
                                {{peopleDictionary.birthYear}}
                            </td>
                        </tr>
                        <tr>
                            <th class="align-top pr-3 pb-2 fw-bolder">직위</th>
                            <td class="color-border-gray pb-2">
                                {{peopleDictionary.position}}
                            </td>
                        </tr>
                        <tr>
                            <th class="align-top pr-3 pb-2 fw-bolder">학력사항</th>
                            <td class="color-border-gray pb-2">
                                <ul>
                                    <li v-for="(school, idx) in peopleDictionary.education">
                                        {{school}}
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th class="align-top pr-3 pb-2 fw-bolder">경력사항</th>
                            <td class="color-border-gray pb-2">
                                <ul>
                                    <li v-for="(career, idx) in peopleDictionary.career">
                                        {{career}}
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr v-if="peopleDictionary.writing.length > 0">
                            <th class="align-top pr-3 pb-2 fw-bolder">저작권</th>
                            <td class="color-border-gray pb-2">
                                <ul>
                                    <li v-for="(copyright, idx) in peopleDictionary.writing">
                                        {{copyright}}
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr v-if="peopleDictionary.paper.length > 0">
                            <th class="align-top pr-3 pb-2 fw-bolder">논문</th>
                            <td class="color-border-gray pb-2">
                                <ul>
                                    <li v-for="(thesis, idx) in peopleDictionary.paper">
                                        {{thesis}}
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr v-if="peopleDictionary.awards.length > 0">
                            <th class="align-top pr-3 pb-2 fw-bolder">수상</th>
                            <td class="color-border-gray pb-2">
                                <ul>
                                    <li v-for="(awards, idx) in peopleDictionary.awards">
                                        {{awards}}
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr v-if="peopleDictionary.etc1.length > 0">
                            <th class="align-top pr-3 pb-2 fw-bolder">기타1</th>
                            <td class="color-border-gray pb-2">
                                <ul>
                                    <li v-for="(etc, idx) in peopleDictionary.etc1">
                                        {{etc}}
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr v-if="peopleDictionary.etc2.length > 0">
                            <th class="align-top pr-3 pb-2 fw-bolder">기타2</th>
                            <td class="color-border-gray pb-2">
                                <ul>
                                    <li v-for="(etc, idx) in peopleDictionary.etc2">
                                        {{etc}}
                                    </li>
                                </ul>
                            </td>
                        </tr>

                    </table>
                </div>
            </div>
            <div class="border-bottom">
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
            newsList:[],
            peopleDictionary:{},
            id : '${id}',
        },
        computed: {

        },
        watch: {
            peopleDictionary : function(){
                this.peopleDictionary.education = this.getStringToArray(this.peopleDictionary.education);
                this.peopleDictionary.career = this.getStringToArray(this.peopleDictionary.career);
                this.peopleDictionary.writing = this.getStringToArray(this.peopleDictionary.writing);
                this.peopleDictionary.paper = this.getStringToArray(this.peopleDictionary.paper);
                this.peopleDictionary.awards = this.getStringToArray(this.peopleDictionary.awards);
                this.peopleDictionary.etc1 = this.getStringToArray(this.peopleDictionary.etc1);
                this.peopleDictionary.etc2 = this.getStringToArray(this.peopleDictionary.etc2);
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
            fetch: function () {
                var self = this;
                axios.get(contextPath + "/peopleDictionary/detail/" + self.id, {data: {}}).then(function (data) {
                    self.peopleDictionary = data.data;
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
            },
            getStringToArray : function(str){
                if (str == '')
                    return [];
                str = this.lineToComma(str);
                return str.split(',');
            },
            lineToComma : function(html){
                html = html.replace(/\r\n/gi, ',');
                html = html.replace(/\\n/gi, ',');
                html = html.replace(/\n/gi, ',');
                return html
            },
        }
    });

</script>
