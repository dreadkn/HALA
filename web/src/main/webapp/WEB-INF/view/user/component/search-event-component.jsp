<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/20
  Time: 15:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/search-article-component.jsp"/>

<script type="text/x-template" id="search-event-component">
    <div class="category-wrapper pb-5 border-bottom border-2 border-dark">
        <span class="list-title d-block fw-bold font-size-20">
            <span class="color-deep-blue">행사</span> 검색결과
            <span class="font-size-16">({{eventList.length}}건)</span>
        </span>
        <search-article-component :article-list="eventList" detail-url="/event/"></search-article-component>
        <button type="button" class="member-contents-more font-size-22 border px-5 py-3 d-block mx-auto mt-5" @click="open">더보기 <span class="pl-3">+</span></button>
    </div>
</script>


<script>
    var searchEventComponent = {
        template: '#search-event-component',
        components: {
            'search-article-component': searchArticleComponent,
        },
        mounted: function () {},
        watch: {},
        computed: {},
        props: ["eventList"],
        data: function () {
            return {
            }
        },
        methods: {
            open : function(){
                location.href = '/event';
            }
        }
    }
</script>
