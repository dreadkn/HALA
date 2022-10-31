<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<style>
    .indent {
        /*margin-left: 2rem;*/
        padding-left: 4rem;
    }

    .handle {
        cursor: grab;
    }

    .handle:active {
        cursor: grabbing;
    }

    .nested-sortable {
        margin-top: 10px;
    }

    .nested-1 {
        background-color: #f8f9fa;
    }

    .nested-2 {
        background-color: #e8e8e8;
    }

    .nested-3 {
        background-color: #dbdbdb;
    }
</style>

<script type="text/x-template" id="code-component">
    <div :id="type + '_CODE'">
        <div class="row justify-content-end mr-1">
            <auth:authorize method="C">
                <button type="button" class="btn btn-primary" @click="createCode(null)">코드 추가</button>
            </auth:authorize>
        </div>
        <div class="row">
            <div class="list-group col nested-sortable" data-parent-id="">
                <div v-for="(item, idx) in codes" class="list-group-item nested-1 " :data-id="item.id">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <i class="mr-3 fas fa-arrows-alt handle"></i>
                            <i class="nav-icon"></i><%--[{{item.code}}]--%> {{item.name}}
                        </div>
                        <div>
                            <span class="badge badge-primary badge-pill">{{item.childCodes.length}}</span>
                            <auth:authorize method="C">
                                <button class="btn btn-sm btn-outline-primary" @click="createCode(item.id)">하위항목 추가</button>
                            </auth:authorize>
                            <auth:authorize method="U">
                                <button class="btn btn-sm btn-outline-primary" @click="updateCode(item)">수정</button>
                            </auth:authorize>
                        </div>
                    </div>

                    <div v-if="item.childCodes.length > 0" class="list-group nested-sortable" :data-parent-id="item.id">
                        <div v-for="(item2, idx2) in item.childCodes" class="list-group-item nested-2"
                             :data-id="item2.id">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="mr-3 fas fa-arrows-alt handle"></i>
                                    <i class="nav-icon"></i><%--[{{item2.code}}]--%> {{item2.name}}
                                </div>
                                <div>
                                    <span class="badge badge-primary badge-pill">{{item2.childCodes.length}}</span>
                                    <auth:authorize method="C">
                                        <button class="btn btn-sm btn-outline-primary" @click="createCode(item2.id)">하위코드 추가</button>
                                    </auth:authorize>
                                    <auth:authorize method="U">
                                        <button class="btn btn-sm btn-outline-primary" @click="updateCode(item2)">수정</button>
                                    </auth:authorize>
                                </div>
                            </div>

                            <div v-if="item2.childCodes.length > 0" class="list-group nested-sortable"
                                 :data-parent-id="item2.id">
                                <div v-for="(item3, idx3) in item2.childCodes" class="list-group-item nested-3"
                                     :data-id="item3.id">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="mr-3 fas fa-arrows-alt handle"></i>
                                            <i class="nav-icon"></i><%--[{{item3.code}}]--%> {{item3.name}}
                                        </div>
                                        <div>
                                            <button class="btn btn-sm btn-outline-primary" @click="updateCode(item3)">
                                                수정
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--<div class="card">
        <div class="card-header">
            <h3 class="card-title"></h3>
            <div class="card-tools">
                <auth:authorize method="C">
                <button type="button" class="btn btn-primary" @click="createCode(null)">코드 추가</button>
                </auth:authorize>
            </div>
        </div>
        <div class="card-body" :id="type + '_CODE'">

        </div>
    </div>--%>
</script>

<script>
    var codeComponent = {
        template: '#code-component',
        props: ["type"],
        mounted: function () {
            this.fetchCodeList();
        },
        updated: function () {
            this.initSortable();
        },
        data: function () {
            return {
                codes: []
            }
        },
        methods: {
            fetchCodeList: function () {
                var self = this;
                self.codes = [];
                jQuery.ajax(contextPath + "/admin/system/codes?type=" + self.type, {
                    method: 'GET',
                    contentType: 'application/json'
                })
                .done(function (data) {
                    self.codes = data;
                })
                .fail(function (data) {
                    errorToastr("메뉴 목록 조회중 오류가 발생하였습니다.");
                })
            },
            createCode: function (parentId) {
                this.$emit('create-code', parentId, this.type, this.fetchCodeList);
            },
            updateCode: function (codeData) {
                this.$emit('update-code', codeData, this.fetchCodeList);
            },
            initSortable: function () {
                var self = this;

                var nestedSortables = [].slice.call(
                    document.querySelectorAll('#' + self.type + '_CODE .nested-sortable'));

                for (var i = 0; i < nestedSortables.length; i++) {
                    new Sortable(nestedSortables[i], {
                        group: 'nested',
                        animation: 150,
                        fallbackOnBody: true,
                        swapThreshold: 0.65,
                        handle: '.handle', // handle's class
                        onSort: function (evt) {
                            self.sort($(evt.item).data('id'), $(evt.item).parent('div').data('parent-id'),
                                evt.newIndex, self.type);
                        }
                    });
                }
            },
            sort: function (id, parentId, orderNumber, type) {
                var self = this;
                jQuery.ajax(
                    contextPath + "/admin/system/codes/" + id + "?parentId=" + parentId + "&orderNumber=" + orderNumber
                    + "&type=" + type, {
                        method: 'PATCH',
                        contentType: 'application/json'
                    })
                .done(function (data) {
                    self.fetchCodeList();
                })
                .fail(function (data) {
                    errorToastr("코드 정렬중 오류가 발생하였습니다.");
                })
            }
        }
    };

</script>
