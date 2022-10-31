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

<script type="text/x-template" id="search-boards-component">
    <div>
        <div class="category-wrapper pb-5 border-bottom border-2 border-dark">
            <span class="list-title d-block fw-bold font-size-20">
                <span class="color-deep-blue">공지사항</span> 검색결과
                <span class="font-size-16">({{noticeList.length}}건)</span>
            </span>
            <div class="board-list">
                <ul class="notice-list">
                    <li v-for="(notice, idx) in noticeList">
                        <a href="/boards/notice/detail" class="d-flex align-items-center border-bottom p-4">
                            <div class="created-date">
                            <span class="color-border-gray">
                                {{notice.createdDateY}}
                            </span>
                                <span class="d-block font-size-35">{{notice.createdDateMd}}</span>
                            </div>
                            <div>
                                <span class="title font-size-25">{{notice.title}}</span>
                                <div class="d-none d-md-block mt-4 font-size-15 color-gray">
                                    {{notice.preview}}
                                </div>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <button type="button" class="member-contents-more font-size-22 border px-5 py-3 d-block mx-auto mt-5" @click="open('notice')">더보기 <span class="pl-3">+</span></button>
        </div>

        <div class="category-wrapper pb-5 border-bottom border-2 border-dark">
            <span class="list-title d-block fw-bold font-size-20">
                <span class="color-deep-blue">FAQ</span> 검색결과
                <span class="font-size-16">({{faqList.length}}건)</span>
            </span>
            <div class="board-list">
                <div class="accordion faq-list" id="accordionExample">
                    <div class="accordion-item" v-for="(faq, idx) in faqList">
                        <h2 class="accordion-header" :id="'faq' + faq.id">
                            <button class="accordion-button collapsed bg-white color-black font-size-20 fw-lighter" type="button" data-bs-toggle="collapse" :data-bs-target="'#faq-contents' + faq.id" aria-expanded="false" :aria-controls="'faq-contents' + faq.id">
                                <img src="/resources/img/sub/ico_faq_list.png" class="mr-5"> {{faq.title}}
                            </button>
                        </h2>
                        <div :id="'faq-contents' + faq.id" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                            <div class="accordion-body border-left-0 border-right-0" v-html="faq.contents"></div>
                        </div>
                    </div>
                </div>
            </div>
            <button type="button" class="member-contents-more font-size-22 border px-5 py-3 d-block mx-auto mt-5" @click="open('faq')">더보기 <span class="pl-3">+</span></button>
        </div>
    </div>

</script>


<script>
    var searchBoardsComponent = {
        template: '#search-boards-component',
        components: {
        },
        mounted: function () {},
        watch: {},
        computed: {},
        props: ["noticeList", "faqList"],
        data: function () {
            return {
            }
        },
        methods: {
            open : function(type){
                switch (type)
                {
                    case 'faq':
                        location.href = '/boards/faq';
                        break;
                    case 'notice':
                        location.href = '/boards/notice';
                        break;
                }

            }
        }
    }
</script>
