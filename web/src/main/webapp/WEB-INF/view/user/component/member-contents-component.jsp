<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/19
  Time: 16:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="member-contents-component">
    <div>
        <ul class="mt-5 pb-1">
            <li class="d-flex flex-column flex-sm-row border-top border-bottom my-3" v-for="(content, idx) in page.content">
                <div class="member-contents-info">
                    <div class="d-flex py-3 pl-3">
                        <div class="member-contents-img-wrapper">
                            <img :src="'/files/' + getContent(content).fileId" v-if="getContent(content).fileId != null"/>
                        </div>
                        <div class="ml-4 w-100 d-grid">
                            <div class="d-flex justify-content-between align-items-baseline">
                                <span class="category font-size-18 fw-bolder">{{getContent(content).contentType.value}}</span>
                                <span class="btn-outline-circle-danger mr-2" v-if="getContent(content).inspectionStatus.code == 'REJECT'">반려</span>
                                <span class="btn-outline-circle-primary mr-2" v-if="getContent(content).inspectionStatus.code == 'INSPECTION'">검수중</span>
                                <span class="btn-outline-circle-warning mr-2" v-if="getContent(content).inspectionStatus.code == 'WAIT'">검수대기</span>
                                <span class="btn-outline-circle-success mr-2" v-if="getContent(content).inspectionStatus.code == 'APPROVE'">승인</span>
                            </div>
                            <span class="member-contents-title font-size-20 fw-bolder" >{{getContent(content).title}}</span>
                            <span class="fw-bolder align-self-end">{{getContent(content).createdDate}}</span>
                        </div>
                    </div>
                    <div class="reject-reason border-top py-3 pl-3" v-html="getContent(content).inspectionOpinion" v-if="getContent(content).inspectionStatus.code == 'REJECT'">
                    </div>
                </div>
                <div class="member-contents-btn-wrapper d-flex flex-sm-column justify-content-center align-items-sm-end p-3">
                    <template v-if="getContent(content).inspectionStatus.code == 'REJECT'">
                        <button type="button" class="bg-light-gray d-block border py-3 mb-sm-3 mr-3 mr-sm-0" @click="remove(content)">삭제</button>
                        <button type="button" class="bg-light-gray d-block border py-3" @click="update(content)">수정</button>
                    </template>

                    <template v-if="getContent(content).inspectionStatus.code == 'INSPECTION'">
                        <button type="button" class="bg-light-gray d-block border py-3" @click="confirm(content)">콘텐츠확인</button>
                    </template>

                    <template v-if="getContent(content).inspectionStatus.code == 'WAIT'">
                        <button type="button" class="bg-light-gray d-block border py-3 mb-sm-3 mr-3 mr-sm-0" @click="cancel(content)">등록취소</button>
                        <button type="button" class="bg-light-gray d-block border py-3">수정</button>
                    </template>

                    <template v-if="getContent(content).inspectionStatus.code == 'APPROVE'">
                        <button type="button" class="bg-light-gray d-block border py-3" @click="confirm(content)">콘텐츠확인</button>
                    </template>
                </div>
            </li>
            <li class="d-flex flex-column flex-sm-row border-top border-bottom my-3" v-if="page.content.length == 0">
                <div class="member-contents-info">
                    <div class="reject-reason border-top py-3 pl-3" >
                        <span>등록 된 콘텐츠가 없습니다.</span>
                    </div>
                </div>
            </li>
        </ul>
        <template v-if="page.totalPages > page.number">
            <button type="button" class="member-contents-more font-size-22 border px-5 py-3 d-block mx-auto mt-5">더보기 <span class="pl-3">+</span></button>
        </template>
<%--        <div class="member-contents-more text-center">--%>
<%--            <button type="button" class="font-size-22 border py-3 w-100">더보기 <span class="pl-3">+</span></button>--%>
<%--        </div>--%>
    </div>
</script>


<script>
    var memberContentsComponent = {
        template: '#member-contents-component',
        mounted: function () {
            this.fetch();
        },
        watch: {},
        computed: {},
        props: [],
        data: function () {
            return {
                page:{},
                size : 5,
            }
        },
        methods: {
            fetch: function (page) {
                var self = this;
                axios.get("/member/content/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.page = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByAppend: function (page) {
                var self = this;
                axios.get("/member/content/list" + this.getParam(page), {data: {}}).then(function (data) {
                    self.page = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            getParam : function(page){
                if(page === undefined)
                    page = 0;

                return '?page=' + page + '&size=' + Number(this.size);
            },
            getContent : function(content){

                let title = '';
                let createdDate = '';
                let fileId = '';

                switch (content.contentType.code)
                {
                    case 'NEWS':
                        title = content.newsTitle;
                        createdDate = content.newsCreatedDate;
                        fileId = content.newsFildId;
                        break;
                    case 'CONGRATULATIONS':
                        title = content.congratulationsTitle;
                        createdDate = content.congratulationsCreatedDate;
                        fileId = content.congratulationsFildId;
                        break;
                    case 'EVENT':
                        title = content.eventTitle;
                        createdDate = content.eventCreatedDate;
                        fileId = content.eventFildId;
                        break;
                    case 'HUMAN':
                        title = content.humanTitle;
                        createdDate = content.humanCreatedDate;
                        fileId = content.humanFildId;
                        break;
                }

                return {
                    title : title,
                    createdDate : createdDate,
                    fileId : fileId,
                    contentType : content.contentType,
                    inspectionStatus : content.inspectionStatus,
                    inspectionOpinion : content.inspectionOpinion,
                }
            },
            /**
             * todo : content update
             */
            update : function(){

            },
            remove : function(){

            },
            confirm : function(){

            },
            cancel : function(){

            },
        }
    }
</script>
