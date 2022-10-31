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
<jsp:include page="/WEB-INF/view/user/component/obituary-container-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/wedding-container-component.jsp"/>

<script type="text/x-template" id="search-family-event-component">
    <div>
        <div class="category-wrapper pb-5 border-bottom border-2 border-dark">
            <span class="list-title d-block fw-bold font-size-20">
                <span class="color-deep-blue">화촉</span> 검색결과
                <span class="font-size-16">({{weddingList.length}}건)</span>
            </span>
            <div class="wedding-article-wrapper d-flex flex-wrap flex-column flex-md-row justify-content-around align-items-center">
                <wedding-container-component :wedding="wedding":key="wedding.id"  v-for="(wedding, idx) in weddingList"></wedding-container-component>
            </div>
            <button type="button" class="member-contents-more font-size-22 border px-5 py-3 d-block mx-auto mt-5" @click="open('wedding')">더보기 <span class="pl-3">+</span></button>
        </div>

        <div class="category-wrapper pb-5 border-bottom border-2 border-dark">
            <span class="list-title d-block fw-bold font-size-20">
                <span class="color-deep-blue">부고</span> 검색결과
                <span class="font-size-16">({{obituaryList.length}}건)</span>
            </span>
            <div class="d-flex flex-wrap flex-column flex-md-row justify-content-around align-items-center">
                <obituary-container-component :obituary="obituary" :key="obituary.id" v-for="(obituary, idx) in obituaryList"></obituary-container-component>
            </div>
            <button type="button" class="member-contents-more font-size-22 border px-5 py-3 d-block mx-auto mt-5" @click="open('death')">더보기 <span class="pl-3">+</span></button>
        </div>

        <div class="category-wrapper pb-5 border-bottom border-2 border-dark">
            <span class="list-title d-block fw-bold font-size-20">
                <span class="color-deep-blue">인사</span> 검색결과
                <span class="font-size-16">({{personnelList.length}}건)</span>
            </span>
                <search-article-component :article-list="personnelList" detail-url="/familyEvent/personnel/"></search-article-component>
            <button type="button" class="member-contents-more font-size-22 border px-5 py-3 d-block mx-auto mt-5" @click="open('person')">더보기 <span class="pl-3">+</span></button>
        </div>
    </div>

</script>


<script>
    var searchFamilyEventComponent = {
        template: '#search-family-event-component',
        components: {
            'search-article-component': searchArticleComponent,
            'obituary-container-component': obituaryContainerComponent,
            'wedding-container-component': weddingContainerComponent,
        },
        mounted: function () {},
        watch: {},
        computed: {},
        props: ["weddingList", "obituaryList", "personnelList"],
        data: function () {
            return {
            }
        },
        methods: {
            open : function(type){
                switch (type)
                {
                    case 'wedding':
                        location.href = '/familyEvent/wedding';
                        break;
                    case 'death':
                        location.href = '/familyEvent/obituary';
                        break;
                    case 'person':
                        location.href = '/familyEvent/personnel';
                        break;
                }

            }
        }
    }
</script>
