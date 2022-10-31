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

<script type="text/x-template" id="menu-component">
    <div class="card">
        <div class="card-header">
            {{type}}
            <h3 class="card-title"></h3>
            <div class="card-tools">
                <auth:authorize method="C">
                <button type="button" class="btn btn-primary" @click="createMenu(null)">메뉴 추가</button>
                </auth:authorize>
            </div>
        </div>
        <div class="card-body" :id="type + '_MENU'">
            <div id="nestedDemo" class="list-group col nested-sortable" data-parent-id="">
                <div v-for="(item, idx) in menus" class="list-group-item nested-1 " :data-id="item.id">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <i class="mr-3 fas fa-arrows-alt handle"></i>
                            <i class="nav-icon" :class="[item.icon]"></i> {{item.name}}
                            <small class="text-muted">{{item.url}}</small>
                        </div>
                        <div>
                            <span class="badge badge-primary badge-pill">{{item.childMenu.length}}</span>
                            <auth:authorize method="C">
                            <button class="btn btn-sm btn-outline-primary" @click="createMenu(item.id)">하위항목 추가</button>
                            </auth:authorize>
                            <auth:authorize method="U">
                            <button class="btn btn-sm btn-outline-primary" @click="updateMenu(item)">수정</button>
                            </auth:authorize>
                        </div>
                    </div>

                    <div v-if="item.childMenu.length > 0" class="list-group nested-sortable" :data-parent-id="item.id">
                        <div v-for="(item2, idx2) in item.childMenu" class="list-group-item nested-2"
                             :data-id="item2.id">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <i class="mr-3 fas fa-arrows-alt handle"></i>
                                    <i class="nav-icon" :class="[item2.icon]"></i> {{item2.name}}
                                    <small class="text-muted">{{item2.url}}</small>
                                </div>
                                <div>
                                    <span class="badge badge-primary badge-pill">{{item2.childMenu.length}}</span>
                                    <auth:authorize method="C">
                                    <button class="btn btn-sm btn-outline-primary" @click="createMenu(item2.id)">하위항목 추가</button>
                                    </auth:authorize>
                                    <auth:authorize method="U">
                                    <button class="btn btn-sm btn-outline-primary" @click="updateMenu(item2)">수정</button>
                                    </auth:authorize>
                                </div>
                            </div>

                            <div v-if="item2.childMenu.length > 0" class="list-group nested-sortable"
                                 :data-parent-id="item2.id">
                                <div v-for="(item3, idx3) in item2.childMenu" class="list-group-item nested-3"
                                     :data-id="item3.id">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="mr-3 fas fa-arrows-alt handle"></i>
                                            <i class="nav-icon" :class="[item3.icon]"></i> {{item3.name}}
                                            <small class="text-muted">{{item3.url}}</small>
                                        </div>
                                        <div>
                                            <%--                                                            <span class="badge badge-primary badge-pill">{{item3.childMenu.length}}</span>--%>
                                            <%--                                                            <button class="btn btn-sm btn-outline-primary" @click="createMenu(item3.id)">하위항목 추가</button>--%>
                                            <button class="btn btn-sm btn-outline-primary" @click="updateMenu(item3)">
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
</script>

<script>
    var menuComponent = {
        template: '#menu-component',
        props: ["type"],
        mounted: function () {
            this.fetchMenuList();
        },
        updated: function () {
            this.initSortable();
        },
        data: function () {
            return {
                menus: []
            }
        },
        methods: {
            fetchMenuList: function () {
                var self = this;
                self.menus = [];
                jQuery.ajax(contextPath + "/admin/system/menu?type=" + self.type, {
                    method: 'GET',
                    contentType: 'application/json'
                })
                .done(function (data) {
                    self.menus = data;
                })
                .fail(function (data) {
                    errorToastr("메뉴 목록 조회중 오류가 발생하였습니다.");
                })
            },
            createMenu: function (parentId) {
                this.$emit('create-menu', parentId, this.type, this.fetchMenuList);
            },
            updateMenu: function (menuData) {
                this.$emit('update-menu', menuData, this.fetchMenuList);
            },
            initSortable: function () {
                var self = this;

                var nestedSortables = [].slice.call(
                    document.querySelectorAll('#' + self.type + '_MENU .nested-sortable'));
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
                    contextPath + "/admin/system/menu/" + id + "?parentId=" + parentId + "&orderNumber=" + orderNumber
                    + "&type=" + type, {
                        method: 'PATCH',
                        contentType: 'application/json'
                    })
                .done(function (data) {
                    self.fetchMenuList();
                })
                .fail(function (data) {
                    errorToastr("메뉴 정렬중 오류가 발생하였습니다.");
                })
            }
        }
    };

</script>
