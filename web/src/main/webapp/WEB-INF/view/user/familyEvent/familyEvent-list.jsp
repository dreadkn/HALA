<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/sub-header-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/list-article-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/page-navigation-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/obituary-container-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/wedding-container-component.jsp"/>


<div id="vue-app" class="sub familyEvent container">
    <sub-header-component :sub-header-info="subHeaderInfo"></sub-header-component>
    <div class="contents-list">
        <ul class="nav nav-tabs border-bottom-0" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link w-100" :class="{'active' : '${type}' == 'wedding' || '${type}' == ''}" id="wedding-tab" data-bs-toggle="tab" data-bs-target="#wedding" type="button" role="tab" aria-controls="wedding" aria-selected="true">화촉</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link w-100" :class="{'active' : '${type}' == 'obituary'}" id="obituary-tab" data-bs-toggle="tab" data-bs-target="#obituary" type="button" role="tab" aria-controls="obituary" aria-selected="false">부고</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link w-100" :class="{'active' : '${type}' == 'personnel'}" id="personnel-tab" data-bs-toggle="tab" data-bs-target="#personnel" type="button" role="tab" aria-controls="personnel" aria-selected="false">인사</button>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-wedding tab-pane fade" :class="{' show active' : '${type}' == 'wedding' || '${type}' == ''}" id="wedding" role="tabpanel" aria-labelledby="wedding-tab">
                <div class="wedding-article-wrapper d-flex flex-wrap flex-column flex-md-row justify-content-around align-items-center">
                    <template v-for="(wedding, idx) in weddingList">
                        <div class="banner w-100" v-if="idx == 2">
                            <img :src="'/files/' + ad.fileId" class="w-100" />
                        </div>
                        <wedding-container-component :wedding="wedding"></wedding-container-component>
                        <div class="w-100" v-if="weddingList.length < 3 && weddingList.length - 1 == idx">
                            <img :src="'/files/' + ad.fileId" class="w-100" />
                        </div>
                    </template>
                </div>
                <page-navigation-component :page="weddingPage" :page-item-number="10" :fetch-method="weddingPaging" v-on:fetch="weddingPaging"></page-navigation-component>
            </div>
            <div class="tab-obituary tab-pane fade" :class="{' show active' : '${type}' == 'obituary'}" id="obituary" role="tabpanel" aria-labelledby="profile-tab">
                <div class="d-flex flex-wrap flex-column flex-md-row justify-content-around align-items-center">
                    <obituary-container-component :obituary="obituary" :category="true" v-for="obituary in obituaryList"></obituary-container-component>
                </div>
                <div class="banner w-100">
                    <img :src="'/files/' + ad.fileId" class="w-100" />
                </div>
                <page-navigation-component :page="obituaryPage" :page-item-number="10" :fetch-method="obituaryPaging" v-on:fetch="obituaryPaging"></page-navigation-component>
            </div>
            <div class="tab-personnel tab-pane fade" :class="{' show active' : '${type}' == 'personnel'}" id="personnel" role="tabpanel" aria-labelledby="contact-tab">
                <list-article-component :article-list="personnelList" :detail-url="'/familyEvent/personnel/'"></list-article-component>
                <page-navigation-component :page="personnelPage" :page-item-number="10" :fetch-method="personnelPaging" v-on:fetch="personnelPaging"></page-navigation-component>
            </div>
        </div>
    </div>
</div>
<script>
    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'sub-header-component': subHeaderComponent,
            'list-article-component': listArticleComponent,
            'page-navigation-component': pageNavigationComponent,
            'obituary-container-component': obituaryContainerComponent,
            'wedding-container-component': weddingContainerComponent,
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            subHeaderInfo:{
                title:"우리지역 경조사 소식",
                category: '경조사',
                formYn: false,
                writeFormUrl: '/familyEvent/form'
            },

            weddingList:[],
            weddingPage:{
                first: true,
                last:false,
                totalPages: 11,
                totalCount: 115,
                number: 0,
                locationHost: 'familyEvent/wedding',
            },
            weddingBanner:{
                id: 1,
                url: "https://www.naver.com",
                file:{
                    id: 1,
                    src: "/resources/img/sub/wedding_banner_sample.png"
                }
            },

            obituaryList:[],
            obituaryPage:{
                first: true,
                last:false,
                totalPages: 11,
                totalCount: 115,
                number: 5,
                locationHost: 'familyEvent/obituary',
            },
            obituaryBanner:{
                id: 1,
                url: "https://www.naver.com",
                file:{
                    id: 1,
                    src: "/resources/img/sub/obituary_banner_sample.png"
                }
            },

            personnelList:[],
            personnelPage:{
                first: true,
                last:false,
                totalPages: 11,
                totalCount: 115,
                number: 5,
                locationHost: 'familyEvent/personnel',
            },
            personnelBanner:{
                id: 1,
                url: "https://www.naver.com",
                file:{
                    id: 1,
                    src: "/resources/img/sub/wedding_banner_sample.png"
                }
            },
            size : 4,
            ad:{},
        },
        computed: {

        },
        watch: {

        },
        updated: function(){

        },
        methods: {
            init: function(){
                this.fetchByWedding();
                this.fetchByDeath();
                this.fetchByPerson();
                this.fetchByAd();
            },
            fetchByWedding: function (page) {
                var self = this;
                axios.get("/familyEvent/wedding/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.setWeddingPage(data.data);
                    self.weddingList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByDeath: function (page) {
                var self = this;
                axios.get("/familyEvent/death/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.setDeathPage(data.data);
                    self.obituaryList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByPerson: function (page) {
                var self = this;
                axios.get("/familyEvent/person/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.setPersonPage(data.data);
                    self.personnelList = self.getPersonList(data.data.content);
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByAd: function (page) {
                var self = this;
                axios.get("/banner/side" , {data: {}}).then(function (data) {
                    self.ad = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            weddingPaging: function (pageNumber) {
                this.fetchByWedding(pageNumber);
            },
            obituaryPaging: function (pageNumber) {
                this.fetchByDeath(pageNumber);
            },
            personnelPaging: function (pageNumber) {
                this.fetchByPerson(pageNumber);
            },
            getParam : function(page){
                if(page === undefined)
                    page = 0;

                return '?page=' + page + '&size=' + Number(this.size);
            },
            setWeddingPage : function(page){
                this.weddingPage = {
                    first: page.first,
                    last:page.last,
                    totalPages: page.totalPages,
                    totalCount: page.totalElements,
                    number: page.number,
                    locationHost: 'familyEvent/wedding',
                }
            },
            setDeathPage : function(page){
                this.obituaryPage = {
                    first: page.first,
                    last:page.last,
                    totalPages: page.totalPages,
                    totalCount: page.totalElements,
                    number: page.number,
                    locationHost: 'familyEvent/death',
                }
            },
            setPersonPage : function(page){
                this.personnelPage = {
                    first: page.first,
                    last:page.last,
                    totalPages: page.totalPages,
                    totalCount: page.totalElements,
                    number: page.number,
                    locationHost: 'familyEvent/person',
                }
            },
            getPersonList : function(data){

                return data.map(item => {
                    return {
                        id: item.id,
                        detailUrl: '/familyEvent/person/' + item.id,
                        title: item.title,
                        fileId: item.fileId,
                        preview: item.content.substr(0,140),
                        createdDate: dateFormat(item.createdDate, 'YYYY.MM.DD'),
                        createBy: item.createdName
                    }
                });

            },
        }
    });

</script>
