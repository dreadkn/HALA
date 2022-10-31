<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/20
  Time: 15:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="page-navigation-component">
    <div class="page-navigation">

        <ul class="pagination d-flex justify-content-center align-items-center">
            <li class="page-item" :class="{'disabled': page.first}">
                <a href="#" class="page-link" @click="movePage(0)">
                    <img src="/resources/img/sub/ico_page_prev.png"/>
                </a>
            </li>
            <li class="page-item" :class="{'active': n-1 == page.number}" v-for="n in range">
                <a href="#" class="page-link font-size-20" @click.prevent="movePage(n-1)">{{n}}</a>
            </li>
            <li class="page-item" :class="{'disabled': page.last}">
                <a href="#" class="page-link" @click="movePage(page.totalPages-1)">
                    <img src="/resources/img/sub/ico_page_next.png"/>
                </a>
            </li>
        </ul>
    </div>
</script>


<script>
    var pageNavigationComponent = {
        template: '#page-navigation-component',
        mounted: function () {
        },
        watch: {},
        props: ["page", "pageItemNumber", "fetchMethod"],
        computed: {
            range: function () {
                return _.range(this.start(), this.end() + 1);
            },
        },
        data: function () {
            return {
                itemPerPage: window.innerWidth <= 576 ? 5 : this.pageItemNumber
            }
        },
        methods: {
            start: function () {
                var startCalc = (this.page.number+1) % this.itemPerPage == 0 ? 1 : 0;
                return (((Math.floor((this.page.number+1) / this.itemPerPage) - startCalc) * this.itemPerPage) + 1);
            },
            end: function () {
                var rangeMax = this.start() + this.itemPerPage - 1;
                return rangeMax <= this.page.totalPages ? rangeMax : this.page.totalPages;
            },
            movePage: function (pageNumber) {

                if(this.fetchMethod){
                    if (pageNumber !== this.page.number) {
                        this.$emit('fetch', pageNumber);
                        //this.fetchMethod(pageNumber);
                    }
                }else{
                    location.href='/' + this.page.locationHost + '/' + pageNumber;
                }

            }
        }
    }
</script>
