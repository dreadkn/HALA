<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/sub-header-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/people-dictionary-article-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/tab-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/tab-contents-component.jsp"/>


<div id="vue-app" class="sub peopleDictionary container">
    <sub-header-component :sub-header-info="subHeaderInfo"></sub-header-component>
    <div class="contents-list">
        <ul class="tab-list nav nav-tabs border-bottom-0" role="tablist">
            <tab-component :tab-name="'all'" :tab-title="'전체'" :active="true"></tab-component>
            <tab-component :tab-name="'index1'" :tab-title="'강-권씨'" :active="false"></tab-component>
            <tab-component :tab-name="'index2'" :tab-title="'권-김씨'" :active="false"></tab-component>
            <tab-component :tab-name="'index3'" :tab-title="'나-심씨'" :active="false"></tab-component>
            <tab-component :tab-name="'index4'" :tab-title="'안-임씨'" :active="false"></tab-component>
            <tab-component :tab-name="'index5'" :tab-title="'장-황씨'" :active="false"></tab-component>

        </ul>
        <div class="tab-content">
            <tab-contents-component :tab-name="'all'" :people-dictionary-banner="peopleDictionaryBanner"  :active="true"></tab-contents-component>
            <tab-contents-component :tab-name="'index1'" :people-dictionary-banner="peopleDictionaryBanner" :active="false"></tab-contents-component>
            <tab-contents-component :tab-name="'index2'" :people-dictionary-banner="peopleDictionaryBanner" :active="false"></tab-contents-component>
            <tab-contents-component :tab-name="'index3'" :people-dictionary-banner="peopleDictionaryBanner" :active="false"></tab-contents-component>
            <tab-contents-component :tab-name="'index4'" :people-dictionary-banner="peopleDictionaryBanner" :active="false"></tab-contents-component>
            <tab-contents-component :tab-name="'index5'" :people-dictionary-banner="peopleDictionaryBanner" :active="false"></tab-contents-component>
        </div>
    </div>
</div>
<script>
    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'sub-header-component': subHeaderComponent,
            'people-dictionary-article-component': peopleDictionaryArticleComponent,
            'tab-component': TabComponent,
            'tab-contents-component': tabContentsComponent,
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            subHeaderInfo:{
                title:"제주인명사전",
                category: '제주인명',
                formYn: false,
                writeFormUrl: '/peopleDictionary/form'
            },

            peopleDictionaryBanner:{},
        },
        computed: {

        },
        watch: {

        },
        updated: function(){

        },
        methods: {
            init: function(){
                this.fetchByAd();
            },
            fetchByAd: function (page) {
                var self = this;
                axios.get("/banner/side" , {data: {}}).then(function (data) {
                    self.peopleDictionaryBanner = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
        }
    });

</script>
