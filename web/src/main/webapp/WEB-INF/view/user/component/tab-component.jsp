<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/20
  Time: 15:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="tab-component">
    <li class="nav-item" role="presentation">
        <button class="nav-link w-100" :class="{'active' : active}" :id="tabName + '-tab'" data-bs-toggle="tab" :data-bs-target="'#' + tabName" type="button" role="tab" :aria-controls="tabName" aria-selected="true">
            {{tabTitle}}</button>
    </li>
</script>


<script>
    var TabComponent = {
        template: '#tab-component',
        mounted: function () {
        },
        components: {
        },
        watch: {},
        computed: {},
        props: ["tabName", "tabTitle", "active"],
        data: function () {
            return {

            }
        },
        methods: {
            peopleDictionaryPaging: function (pageNumber) {
            },
        }
    }
</script>
