<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/20
  Time: 15:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/page-navigation-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/people-dictionary-article-component.jsp"/>

<script type="text/x-template" id="tab-contents-component">
    <div :class="['tab-peopleDictionary tab-' + tabName + '-peopleDictionary tab-pane fade', {'show active' : active}]" :id="tabName" role="tabpanel" :aria-labelledby="tabName + '-tab'">
        <div class="peopleDictionary-article-wrapper d-flex flex-wrap flex-column flex-md-row justify-content-around ">
            <template v-for="(peopleDictionary, idx) in peopleDictionaryList">
                <div class="banner w-100" v-if="idx == 2 && peopleDictionaryBanner">
                    <img :src="'/files/' + peopleDictionaryBanner.fileId" class="w-100" />
                </div>
                <people-dictionary-article-component :people-dictionary="peopleDictionary" ></people-dictionary-article-component>
                <div class="w-100" v-if="peopleDictionaryList.length < 3 && peopleDictionaryList.length - 1 == idx && peopleDictionaryBanner">
                    <img :src="'/files/' + peopleDictionaryBanner.fileId" class="w-100" />
                </div>
            </template>
        </div>
        <page-navigation-component :page="peopleDictionaryPage" :page-item-number="10" :fetch-method="peopleDictionaryPaging" v-on:fetch="peopleDictionaryPaging"></page-navigation-component>
    </div>
</script>


<script>
    var tabContentsComponent = {
        template: '#tab-contents-component',
        mounted: function () {
            this.init();
        },
        components: {
            'page-navigation-component': pageNavigationComponent,
            'people-dictionary-article-component': peopleDictionaryArticleComponent,
        },
        watch: {

        },
        computed: {},
        props: ["tabName", "peopleDictionaryBanner", "active"],
        data: function () {
            return {
                peopleDictionaryList:[],
                peopleDictionaryPage:{
                    first: true,
                    last:false,
                    totalPages: 11,
                    totalCount: 115,
                    number: 5,
                    locationHost: 'peopleDictionary',
                },
                size : 4,
            }
        },
        methods: {
            init: function(){
                this.fetch();
            },
            peopleDictionaryPaging: function (pageNumber) {
                this.fetch(pageNumber);
            },
            fetch: function (page) {
                var self = this;
                axios.get("/peopleDictionary/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.setPage(data.data);
                    self.peopleDictionaryList = data.data.content;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            getParam : function(page){
                if(page === undefined)
                    page = 0;

                return '?page=' + page + '&size=' + Number(this.size) + '&tabName=' + this.tabName;
            },
            setPage : function(page){
                this.peopleDictionaryPage = {
                    first: page.first,
                    last:page.last,
                    totalPages: page.totalPages,
                    totalCount: page.totalElements,
                    number: page.number,
                    locationHost: 'peopleDictionary',
                }
            },
        }
    }
</script>
