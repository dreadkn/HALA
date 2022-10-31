<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/search-article-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/people-dictionary-article-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/tab-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/search-news-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/search-event-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/search-people-dictionary-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/search-family-event-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/search-boards-component.jsp"/>

<div id="vue-app" class="sub search container">
    <div class="common-header pt-5 pb-4 d-flex flex-column flex-sm-row justify-content-start align-items-baseline">
        <%--<select class="search-range border mr-3 color-border-gray mb-3 mb-sm-0">
            <option value="1">최근 1개월</option>
        </select>
        <select class="search-category border mr-3 color-border-gray mb-3 mb-sm-0">
            <option value="total">통합검색</option>
        </select>--%>
        <div class="d-flex w-100">
            <input type="text" placeholder="검색" class="search-word border border-right-0 w-100" v-model="keyword" @keyup.enter="fetch"/>
            <button type="button" class="border border-left-0" @click="fetch"><img src="/resources/img/sub/ico_list_search.png"/></button>
        </div>
    </div>
    <div class="contents-list">
        <ul class="tab-list nav nav-tabs border-bottom-0" role="tablist">
            <tab-component :tab-name="'total'" :tab-title="'통합검색'" :active="true"></tab-component>
            <tab-component :tab-name="'news'" :tab-title="'뉴스'" :active="false"></tab-component>
            <tab-component :tab-name="'event'" :tab-title="'행사'" :active="false"></tab-component>
            <tab-component :tab-name="'familyEvent'" :tab-title="'경조사'" :active="false"></tab-component>
            <tab-component :tab-name="'peopleDictionary'" :tab-title="'제주인명'" :active="false"></tab-component>
            <tab-component :tab-name="'community'" :tab-title="'커뮤니티'" :active="false"></tab-component>
        </ul>
        <div class="tab-content">
            <div class="tab-search tab-total tab-pane fade show active" id="total" role="tabpanel" aria-labelledby="total-tab">
                <search-news-component :news-list="newsList"></search-news-component>
                <search-event-component :event-list="eventList"></search-event-component>
                <search-family-event-component :wedding-list="weddingList" :obituary-list="obituaryList" :personnel-list="personnelList" ></search-family-event-component>
                <search-people-dictionary-component :people-dictionary-list="peopleDictionaryList"></search-people-dictionary-component>
                <search-boards-component :notice-list="noticeList" :faq-list="faqList"></search-boards-component>
            </div>
            <div class="tab-search tab-news tab-pane fade" id="news" role="tabpanel" aria-labelledby="news-tab">
                <search-news-component :news-list="newsList"></search-news-component>
            </div>
            <div class="tab-search tab-event tab-pane fade" id="event" role="tabpanel" aria-labelledby="event-tab">
                <search-event-component :event-list="eventList"></search-event-component>
            </div>
            <div class="tab-search tab-familyEvent tab-pane fade" id="familyEvent" role="tabpanel" aria-labelledby="familyEvent-tab">
                <search-family-event-component :wedding-list="weddingList" :obituary-list="obituaryList" :personnel-list="personnelList" ></search-family-event-component>
            </div>
            <div class="tab-search tab-peopleDictionary tab-pane fade" id="peopleDictionary" role="tabpanel" aria-labelledby="peopleDictionary-tab">
                <search-people-dictionary-component :people-dictionary-list="peopleDictionaryList"></search-people-dictionary-component>
            </div>
            <div class="tab-search tab-community tab-pane fade" id="community" role="tabpanel" aria-labelledby="community-tab">
                <search-boards-component :notice-list="noticeList" :faq-list="faqList"></search-boards-component>
            </div>
        </div>
    </div>
</div>
<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'search-article-component': searchArticleComponent,
            'tab-component': TabComponent,
            'search-news-component': searchNewsComponent,
            'search-event-component': searchEventComponent,
            'search-people-dictionary-component': searchPeopleDictionaryComponent,
            'search-family-event-component': searchFamilyEventComponent,
            'search-boards-component': searchBoardsComponent
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            newsList:[],
            eventList:[],
            peopleDictionaryList:[],
            weddingList:[],
            obituaryList:[],
            personnelList:[],
            faqList:[],
            noticeList: [],
            size : 7,
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

            },
            fetch : function(){
                this.fetchByNews(0);
                this.fetchByEvent(0);
                this.fetchByHuman(0);
                this.fetchByWedding(0);
                this.fetchByDeath(0);
                this.fetchByPerson(0);
                this.fetchByFaq(0);
                this.fetchByNotice(0);
            },
            fetchByNews: function (page) {
                var self = this;
                axios.get("/news/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.newsList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByEvent: function (page) {
                var self = this;
                axios.get("/event/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.eventList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByHuman: function (page) {
                var self = this;
                axios.get("/peopleDictionary/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.peopleDictionaryList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByWedding: function (page) {
                var self = this;
                axios.get("/familyEvent/wedding/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.weddingList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByDeath: function (page) {
                var self = this;
                axios.get("/familyEvent/death/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.obituaryList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByPerson: function (page) {
                var self = this;
                axios.get("/familyEvent/person/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.personnelList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByFaq: function (page) {
                var self = this;
                axios.get("/boards/faq/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.faqList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByNotice: function (page) {
                var self = this;
                axios.get("/boards/notice/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.noticeList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            getParam : function(page){
                if(page === undefined)
                    page = 0;

                return '?page=' + page + '&size=' + Number(this.size) + '&keyword=' + this.keyword;
            }
        }
    });

</script>
