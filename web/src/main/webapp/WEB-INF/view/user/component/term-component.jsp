<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/19
  Time: 16:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="term-component">
    <div class="form-terms pb-5">
        <div class="d-flex justify-content-between align-items-center mb-2">
            <div>
                <span class="color-deep-blue">[필수]</span> {{title}}
            </div>
            <span role="button" @click="checkTerm">
                <img src="/resources/img/sub/ico_uncheck.png" class="ico-check-img" v-if="!term" />
                <img src="/resources/img/sub/ico_check.png" class="ico-check-img" v-if="term" />
                동의합니다.
            </span>
        </div>
        <div class="terms-contents color-border-gray p-4" v-html="termContents"></div>
    </div>
</script>


<script>
    var termComponent = {
        template: '#term-component',
        mounted: function () {
        },
        watch: {},
        computed: {},
        props: ["term", "title", "termContents"],
        data: function () {
            return {
            }
        },
        methods: {
            checkTerm: function(){
                this.$emit("term");
            },
        }
    }
</script>
