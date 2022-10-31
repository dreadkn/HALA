<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/19
  Time: 16:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="sub-header-component">
    <div class="sub-header d-flex flex-column justify-content-center">
        <span class="sub-title fw-bold d-block text-center">{{subHeaderInfo.category}}</span>
        <div class="sub-description text-center">
            <span class="description-title fw-bold font-size-25 px-1">{{subHeaderInfo.title}}</span>
            <ul class="description-list text-start">
                <li class="word-keep-all font-size-18">굿모닝 제주 플랫폼의 {{subHeaderInfo.category}} 콘텐츠는 회원 여러분들의 참여로 우리 지역의 새로운 소식을 공유하는 공간입니다.</li>
                <li class="font-size-18">우리동네 소식을 작성하여 여러분도 뉴스 기자가 될 수 있습니다.</li>
            </ul>
            <ul class="write-process text-start" v-if="subHeaderInfo.formYn">
                <li class="fw-bolder font-size-20 mt-0 mb-3">우리지역 {{subHeaderInfo.category}} 등록 절차</li>
                <li>굿모닝 제주 플랫폼에서 새로운 콘텐츠를 작성하여 등록해주세요.</li>
                <li>등록된 콘텐츠는 콘텐츠 담당자가 검수하여 승인이 되면 바로 플랫폼에서 확인하실 수 있습니다.</li>
                <li>반려된 경우 마이페이지 > 콘텐츠 등록 내역에서 검토의견 반영 후 다시 등록하시면 됩니다.</li>
            </ul>
        </div>
        <a :href="subHeaderInfo.writeFormUrl" v-if="!subHeaderInfo.formYn" class="btn-outline-circle-common px-3 py-2 align-self-end">{{subHeaderInfo.category}} 작성하기 <span class="color-deep-blue">+</span></a>
    </div>
</script>


<script>
    var subHeaderComponent = {
        template: '#sub-header-component',
        mounted: function () {

        },
        watch: {},
        computed: {},
        props: ["subHeaderInfo"],
        data: function () {
            return {
            }
        },
        methods: {    }
    }
</script>
