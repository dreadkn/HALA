<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/14
  Time: 10:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="wedding-container-component">
    <div class="wedding-article-container">
        <a :href="'/familyEvent/wedding/' + wedding.id" class="wedding-article d-block">
            <div class="wedding-info">
                <span class="wedding-title d-block font-size-25 fw-bolder text-center">화촉</span>
                <span class="wedding-couple d-block font-size-20 fw-bolder text-center mt-4">{{wedding.groom}}군 ♥ {{wedding.bride}}양</span>
                <ul class="wedding-groom">
                    <li>신랑 : {{wedding.groom}} 군{{wedding.groomJob != null ? '('+wedding.groomJob+')' : ''}}</li>
                    <li v-if="wedding.groomFather">신랑 부 : {{wedding.groomFather}}</li>
                    <li v-if="wedding.groomMother">신랑 모 : {{wedding.groomMother}}</li>
                </ul>
                <ul class="wedding-bride">
                    <li>신부 : {{wedding.bride}} 군{{wedding.brideJob != null ? '('+wedding.brideJob+')' : ''}}</li>
                    <li v-if="wedding.brideFather">신부 부 : {{wedding.brideFather}}</li>
                    <li v-if="wedding.brideMother">신부 모 : {{wedding.brideMother}}</li>
                </ul>
                <ul class="wedding-location mt-5">
                    <li>■ 일시 : {{wedding.weddingDate}}</li>
                    <li>■ 장소 : {{wedding.place}}</li>
                </ul>
                <div class="wedding-reception wedding-reception-ymd">
                    <span class="d-block">피로연 일시</span>
                    <span>{{wedding.partyDate}}</span>
                </div>
                <div class="wedding-reception wedding-reception-location mt-3">
                    <span class="d-block">피로연 장소</span>
                    <span>{{wedding.partyPlace}}</span>
                </div>
            </div>
        </a>
    </div>
</script>


<script>
    var weddingContainerComponent = {
        template: '#wedding-container-component',
        mounted: function () {},
        watch: {
        },
        computed: {},
        props: ["wedding"],
        data: function () {
            return {
            }
        },
        methods: {    }
    }
</script>
