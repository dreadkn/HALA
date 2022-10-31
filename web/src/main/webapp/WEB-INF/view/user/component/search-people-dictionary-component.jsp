<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/20
  Time: 15:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/people-dictionary-article-component.jsp"/>

<script type="text/x-template" id="search-people-dictionary-component">
    <div class="category-wrapper pb-5 border-bottom border-2 border-dark">
            <span class="list-title d-block fw-bold font-size-20">
                <span class="color-deep-blue">제주인명</span> 검색결과
                <span class="font-size-16">({{peopleDictionaryList.length}}건)</span>
            </span>
        <div class="peopleDictionary-article-wrapper d-flex flex-wrap flex-column flex-md-row justify-content-around align-items-center">
            <template v-for="(peopleDictionary, idx) in peopleDictionaryList">
                <people-dictionary-article-component :people-dictionary="peopleDictionary" ></people-dictionary-article-component>
            </template>
        </div>
        <button type="button" class="member-contents-more font-size-22 border px-5 py-3 d-block mx-auto mt-5" @click="open">더보기 <span class="pl-3">+</span></button>
    </div>
</script>


<script>
    var searchPeopleDictionaryComponent = {
        template: '#search-people-dictionary-component',
        components: {
            'people-dictionary-article-component': peopleDictionaryArticleComponent,
        },
        mounted: function () {},
        watch: {},
        computed: {},
        props: ["peopleDictionaryList"],
        data: function () {
            return {
            }
        },
        methods: {
            open : function(){
                location.href = '/peopleDictionary';
            }
        }
    }
</script>
