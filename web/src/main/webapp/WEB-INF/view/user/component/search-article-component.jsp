<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/20
  Time: 15:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="search-article-component">
    <ul class="article-list">
        <template v-for="(article, idx) in articleList">
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
        </template>
    </ul>
</script>


<script>
    var searchArticleComponent = {
        template: '#search-article-component',
        mounted: function () {},
        watch: {},
        computed: {},
        props: ["articleList", "detailUrl"],
        data: function () {
            return {
            }
        },
        methods: {
            getImage : function(id){
                return id == null ? '/resources/img/common/no-image.png' : '/files/' + id;
            },
        }
    }
</script>
