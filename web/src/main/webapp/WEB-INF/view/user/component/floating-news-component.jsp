<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/19
  Time: 16:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="floating-news-component">
    <div class="floating-news">
        <span class="floating-news-title d-block mb-5 font-size-25 fw-bold">많이본뉴스</span>
        <ul class="floating-news-list">
            <li class="floating-news-article mb-4" v-for="(item,idx) in newsList" >
                <a href="/" class="d-flex justify-content-between">
                    <span class="floating-news-list-index fw-normal font-size-40 pr-3">{{idx+1}}</span>
                    <span class="floating-news-list-title fw-bolder font-size-18 pr-3 w-100" >{{item.title}}</span>
                    <div class="floating-news-list-img">
                        <img :src="getImage(item.fileId)"  class="w-100"/>
                    </div>
                </a>
            </li>
        </ul>
    </div>
</script>


<script>
    var floatingNewsComponent = {
        template: '#floating-news-component',
        mounted: function () {

        },
        watch: {},
        computed: {},
        props: ["newsList"],
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
