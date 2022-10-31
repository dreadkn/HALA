<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/20
  Time: 15:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="list-article-component">
    <ul class="article-list">
        <template v-for="(article, idx) in articleList">
            <li v-if="idx == 2">
                <a :href="ad.url" target="_blank" class="article-list-banner d-block p-0">
                    <img :src="'/files/' + ad.fileId" class="img-fluid"/>
                </a>
            </li>
            <li class="border-bottom">
                <a :href="detailUrl + article.id" class="d-flex justify-content-between align-self-center py-4">
                    <div class="article-img-wrap">
                        <img :src="getImage(article.fileId)" class="img-fluid"/>
                    </div>
                    <ul class="d-flex flex-column">
                        <li class="article-title fw-bolder font-size-25">{{article.title}}</li>
                        <li class="preview font-size-20 mt-2">{{article.preview}}</li>
                        <li class="created-date font-size-20 d-flex flex-grow-1 align-items-end"><span class="separator-right">{{article.createdDate}}</span> {{article.createBy}}</li>
                    </ul>
                </a>
            </li>
            <li v-if="articleList.length < 3 && articleList.length - 1 == idx">
                <a :href="ad.url" target="_blank" class="article-list-banner d-block p-0">
                    <img :src="'/files/' + ad.fileId" class="img-fluid"/>
                </a>
            </li>
        </template>
    </ul>
</script>


<script>
    var listArticleComponent = {
        template: '#list-article-component',
        mounted: function () {
            this.fetchByAd();
        },
        watch: {},
        computed: {},
        props: ["articleList", 'detailUrl'],
        data: function () {
            return {
                ad:{},
            }
        },
        methods: {
            getImage : function(id){
                return id == null ? '/resources/img/common/no-image.png' : '/files/' + id;
            },
            fetchByAd: function (page) {
                var self = this;
                axios.get("/banner/side" , {data: {}}).then(function (data) {
                    self.ad = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
        }
    }
</script>
