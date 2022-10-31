<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/page-navigation-component.jsp"/>

<div id="vue-app" class="sub boards notice container">
    <div class="contents-list border-top border-2 border-dark">
        <div class="board-header border-bottom border-2 pb-3">
            <div class="text-center py-5">
                <span class="font-size-45 fw-bold d-block mb-4">공지사항</span>
                굿모닝제주의 새로운 소식과 공지를 확인해보세요!
            </div>
            <div class="d-flex flex-column flex-sm-row justify-content-between align-items-baseline">
                <span class="pl-0 pl-sm-3 pb-3 pb-sm-0">Total <span class="color-deep-blue">{{page.totalCount.toLocaleString('ko-KR')}}</span></span>
                <div class="search-wrapper d-flex w-100">
                    <select class="search-type border mr-3 color-border-gray" v-model="searchType">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
                    <div class="d-flex w-100">
                        <input type="text" placeholder="검색" class="search-word border border-right-0 w-100" v-model="keyword" @keyup.enter="fetch(0)"/>
                        <button type="button" class="border border-left-0" @click="fetch(0)"><img src="/resources/img/sub/ico_list_search.png"/></button>
                    </div>
                </div>
            </div>
        </div>
        <div class="board-list">
            <ul class="">
                <li v-for="(notice, idx) in noticeList">
                    <a :href="'/boards/notice/' + notice.id" class="d-flex align-items-center border-bottom p-4">
                        <div class="created-date">
                            <span class="color-border-gray">
                                {{getYear(notice.createdDate)}}
                            </span>
                            <span class="d-block font-size-35">{{getMonthDay(notice.createdDate)}}</span>
                        </div>
                        <div>
                            <span class="title font-size-25">{{notice.title}}</span>
                            <div class="d-none d-md-block mt-4 font-size-15 color-gray">
                                {{getShortText(htmlDecode(notice.content), 80)}}
                            </div>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <page-navigation-component :page="page" :page-item-number="10"></page-navigation-component>
</div>
<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'page-navigation-component': pageNavigationComponent
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            noticeList: [

            ],
            page:{
                first: true,
                last:false,
                totalPages: 31,
                totalCount: 314,
                number: 4,
                locationHost: 'boards/notice',
            },
            size : 7,
            searchType : 'title',
            keyword : '',
        },
        computed: {

        },
        watch: {

        },
        updated: function(){

        },
        methods: {
            init: function(){
                this.fetch();
            },
            fetch: function (page) {
                var self = this;
                axios.get("/boards/notice/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.setPage(data.data);
                    self.noticeList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            setPage : function(page){
                this.page = {
                    first: page.first,
                    last:page.last,
                    totalPages: page.totalPages,
                    totalCount: page.totalElements,
                    number: page.number,
                    locationHost: 'news',
                }
            },
            getYear : function(date){
                return dateFormat(date, 'YYYY');
            },
            getMonthDay : function(date){
                return dateFormat(date, 'MM.DD');
            },
            getShortText : function(text, maxLength){
                return text.length > maxLength ? text.substr(0, maxLength) + '...' : text;
            },
            htmlDecode : function (input) {
                var doc = new DOMParser().parseFromString(input, "text/html");
                return doc.documentElement.textContent;
            },
            getParam : function(page){
                if(page === undefined)
                    page = 0;

                return '?page=' + page + '&size=' + Number(this.size) + '&searchType=' + this.searchType + '&keyword=' + this.keyword;
            }
        }
    });

</script>
