<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/sub-header-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/list-article-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/page-navigation-component.jsp"/>

<div id="vue-app" class="sub news container">
    <sub-header-component :sub-header-info="subHeaderInfo"></sub-header-component>
    <div class="contents-list border-top border-2 border-dark">
        <span class="list-title d-block fw-bold font-size-25">최신기사</span>
        <list-article-component :article-list="articleList" :detail-url="'/news/'"></list-article-component>
    </div>
    <page-navigation-component :page="page" :page-item-number="10" :fetch-method="true" @fetch="fetch"></page-navigation-component>
</div>
<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'sub-header-component': subHeaderComponent,
            'list-article-component': listArticleComponent,
            'page-navigation-component': pageNavigationComponent
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            subHeaderInfo:{
                title:"내가 만드는 우리지역 뉴스",
                category: '뉴스',
                formYn: false,
                writeFormUrl: '/news/form'
            },
            articleList:[],
            page:{
                first: true,
                last:false,
                totalPages: 31,
                totalCount: 314,
                number: 0,
                locationHost: 'news',
            },
            response : {},
            size : 7,
        },
        computed: {

        },
        watch: {
            response : function(){
                this.initList();
            }
        },
        updated: function(){

        },
        methods: {
            init: function(){
                this.fetch();
            },
            fetch: function (page) {
                var self = this;
                axios.get("/news/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.response = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            initList : function(){
                this.page = {
                    first: this.response.first,
                    last:this.response.last,
                    totalPages: this.response.totalPages,
                    totalCount: this.response.totalElements,
                    number: this.response.number,
                    locationHost: 'news',
                }

                this.articleList = this.response.content.map(item => {
                    return {
                        id: item.id,
                        detailUrl: '/news/' + item.id,
                        title: item.title,
                        fileId: item.fileId,
                        preview: item.content.substr(0,140),
                        createdDate: dateFormat(item.createdDate, 'YYYY.MM.DD'),
                        createBy: item.name
                    }
                });
            },
            getParam : function(page){
                if(page === undefined)
                    page = 0;

                return '?page=' + page + '&size=' + Number(this.size);
            }
        }
    });

</script>
