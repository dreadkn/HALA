<%--<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>--%>

<%--<script type="text/x-template" id="user-search-component">--%>
<%--        <div class="modal fade" id="userSearchModal" data-backdrop="static" tabindex="-1" role="dialog" aria-hidden="true">--%>
<%--            <div class="modal-dialog modal-dialog-centered modal-lg-dialog">--%>
<%--                <div class="modal-content">--%>
<%--                    <div class="modal-header">--%>
<%--                        <h5 class="modal-title" id="modalFormLabel">주소 그룹</h5>--%>
<%--                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                            <span aria-hidden="true">&times;</span>--%>
<%--                        </button>--%>
<%--                    </div>--%>
<%--                    <div class="modal-body">--%>
<%--                        <div class="container-fluid address-wrap">--%>
<%--                            <div class="row ">--%>
<%--                                <div class="col-3">--%>
<%--                                    <ul class="list-group ">--%>
<%--                                        <li class="list-group-item groupli" @click="selectionPerson" >--%>
<%--                                            <span>개인</span>--%>
<%--                                        </li>--%>
<%--                                        <li class="list-group-item" @click="selectionGroup(item)" v-for="(item, idx) in groups" :class="'groupli' + item.id">--%>
<%--                                            <span>{{item.groupName}}</span>--%>
<%--                                        </li>--%>
<%--                                    </ul>--%>
<%--                                </div>--%>
<%--                                <div class="col-4 overflow-auto">--%>
<%--                                    <div class="form-group d-flex ">--%>
<%--                                        <input class="form-control w-75" name="keyword" id="keyword2">--%>
<%--                                        <button @click="searchUser" type="button" class="btn btn-sm btn-outline-primary row-detail text-nowrap ml-1">검색</button>--%>
<%--                                    </div>--%>
<%--                                    <ul class="list-group person-list">--%>
<%--                                        <li class="list-group-item" >--%>
<%--                                            <div class="form-group d-flex align-items-baseline" v-for="(item, idx) in groupMembers">--%>
<%--                                                <input type="checkbox" class="mr-1" name="userId" :id="'member' + item.id"  value="item.id" v-model="item.chk">--%>
<%--                                                <label :for="'member' + item.id">{{item.name}} {{item.phone}}</label>--%>
<%--                                            </div>--%>
<%--                                        </li>--%>
<%--                                        <li class="list-group-item" v-if="groupMembers.length == 0">--%>
<%--                                            <p>조회 결과가 없습니다.</p>--%>
<%--                                        </li>--%>
<%--                                    </ul>--%>
<%--                                </div>--%>
<%--                                <div class="col-1 d-flex align-items-center justify-content-center">--%>
<%--                                    <button @click="moveUser" type="button" class="btn btn-sm btn-outline-primary row-detail text-nowrap ">추가 ></button>--%>
<%--                                </div>--%>
<%--                                <div class="col-4">--%>
<%--                                    <ul class="list-group person-list">--%>
<%--                                        <li class="list-group-item" v-for="(item, idx) in receivers">--%>
<%--                                            <i class="far fa-times-circle" @click="deleteUser(item.id)"></i>--%>
<%--                                            <span>{{item.name}}</span>--%>
<%--                                            <span>{{item.phone}}</span>--%>
<%--                                        </li>--%>
<%--                                        <li class="list-group-item" v-if="receivers.length == 0">--%>
<%--                                            <p>조회 결과가 없습니다.</p>--%>
<%--                                        </li>--%>
<%--                                    </ul>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="modal-footer justify-content-between">--%>
<%--                        <div class="col-auto ml-auto">--%>
<%--                            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>--%>
<%--                            <button type="button" class="btn btn-primary" @click="addUser">확인</button>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--</script>--%>

<%--<script>--%>
<%--    var userSearchComponent = {--%>
<%--        template: '#user-search-component',--%>
<%--        mounted: function () {--%>
<%--        },--%>
<%--        data: function () {--%>
<%--            return {--%>
<%--                groups: [],--%>
<%--                groupMembers: [],--%>
<%--                receivers: [],--%>
<%--                originMembers: [],--%>
<%--                currentGroup: {}--%>
<%--            }--%>
<%--        },--%>
<%--        methods: {--%>
<%--            open: function () {--%>
<%--                this.fetch();--%>
<%--                this.fetchMember();--%>
<%--                $('#userSearchModal').modal('show');--%>
<%--                $('.groupli').addClass('bg-secondary');--%>
<%--            },--%>
<%--            fetch: function () {--%>
<%--                var self = this;--%>
<%--                jQuery.ajax(contextPath + "/admin/sms/group", {--%>
<%--                    method: 'GET',--%>
<%--                    contentType: 'application/json'--%>
<%--                }).done(function (data) {--%>
<%--                    self.groups = data;--%>
<%--                })--%>
<%--                .fail(function (data) {--%>
<%--                    errorToastr("그룹 조회 중 오류가 발생하였습니다.");--%>
<%--                });--%>
<%--            },--%>
<%--            fetchMember: function () {--%>
<%--                var self = this;--%>
<%--                jQuery.ajax(contextPath + "/admin/sms/member", {--%>
<%--                    method: 'GET',--%>
<%--                    contentType: 'application/json'--%>
<%--                }).done(function (data) {--%>
<%--                    data = data.map(m => {--%>
<%--                        m.chk = false;--%>
<%--                        return m;--%>
<%--                    });--%>
<%--                    self.groupMembers = data;--%>
<%--                    self.originMembers = data;--%>
<%--                })--%>
<%--                    .fail(function (data) {--%>
<%--                        errorToastr("그룹 조회 중 오류가 발생하였습니다.");--%>
<%--                    });--%>
<%--            },--%>
<%--            searchUser : function(){--%>
<%--                var self = this;--%>
<%--                var keyword = $('#keyword2').val();--%>
<%--                var search = this.currentGroup.id === undefined ? this.originMembers : this.currentGroup.members;--%>
<%--                var searchData = search.filter(function (member) {--%>

<%--                    return member.name.indexOf(keyword) > -1--%>
<%--                        || member.phone.indexOf(keyword) > -1;--%>
<%--                });--%>
<%--                var filter = searchData.filter(function(member){--%>
<%--                    var is = true;--%>
<%--                    $(self.receivers).each(function(){--%>
<%--                        if (this.id == member.id)--%>
<%--                            is = false;--%>
<%--                    });--%>
<%--                    return is;--%>
<%--                });--%>

<%--                this.groupMembers = filter;--%>
<%--            },--%>
<%--            addUser: function () {--%>
<%--                vm.addUserList(this.receivers);--%>
<%--                $('#userSearchModal').modal('hide');--%>
<%--            },--%>
<%--            deleteUser : function(memberId){--%>
<%--                var self = this;--%>
<%--                var filter = this.receivers.filter(function (member) {--%>
<%--                    return member.id != memberId;--%>
<%--                });--%>

<%--                var filterItem = this.receivers.filter(function (member) {--%>
<%--                    return member.id == memberId;--%>
<%--                });--%>

<%--                this.receivers = filter;--%>

<%--                this.groupMembers = $.merge(this.groupMembers, filterItem);--%>
<%--                this.groupMembers.push();--%>

<%--                this.groupMembers.map(m => {--%>
<%--                    m.chk = false;--%>
<%--                    return m;--%>
<%--                });--%>
<%--            },--%>
<%--            moveUser : function(){--%>
<%--                var filter = this.groupMembers.filter(function (member) {--%>
<%--                    return member.chk == true;--%>
<%--                });--%>

<%--                var filterList = this.groupMembers.filter(function (member) {--%>
<%--                    return member.chk != true;--%>
<%--                });--%>

<%--                if(filter.length > 0)--%>
<%--                {--%>
<%--                    filter = filter.filter(function(member){--%>
<%--                        var is = true;--%>
<%--                        $(self.receivers).each(function(){--%>
<%--                            if(member.id == this.id)--%>
<%--                                is = false;--%>
<%--                        })--%>

<%--                        return is;--%>
<%--                    });--%>
<%--                    this.receivers = $.merge(this.receivers, filter);--%>
<%--                    this.receivers.push();--%>

<%--                    this.groupMembers = filterList;--%>

<%--                    this.groupMembers.map(m => {--%>
<%--                        m.chk = false;--%>
<%--                        return m;--%>
<%--                    });--%>
<%--                }--%>
<%--            },--%>
<%--            convGroup : function(group){--%>

<%--                var convGroup = JSON.parse(JSON.stringify(group));--%>
<%--                var memberIds = [];--%>

<%--                $(convGroup.members).each(function(){--%>
<%--                    memberIds.push(this.id === undefined ? this : this.id);--%>
<%--                });--%>
<%--                convGroup.members = memberIds;--%>

<%--                return convGroup;--%>
<%--            },--%>
<%--            selectionGroup : function(group){--%>

<%--                $('.groupli' + group.id).parent().find('> li').removeClass('bg-secondary');--%>
<%--                $('.groupli' + group.id).addClass('bg-secondary');--%>

<%--                var self = this;--%>
<%--                var url = "/admin/sms/member/group";--%>

<%--                var selectionGroup = this.convGroup(group);--%>

<%--                jQuery.ajax(url, {--%>
<%--                    method: 'POST',--%>
<%--                    contentType: 'application/json',--%>
<%--                    data: JSON.stringify(selectionGroup),--%>
<%--                    dataType: 'json'--%>
<%--                }).done(function (data) {--%>
<%--                    self.groupMembers = data;--%>
<%--                    self.currentGroup = group;--%>
<%--                    self.currentGroup.members = data;--%>

<%--                    var filter = self.groupMembers.filter(function(member){--%>
<%--                        var is = true;--%>
<%--                        $(self.receivers).each(function(){--%>
<%--                            if (this.id == member.id)--%>
<%--                                is = false;--%>
<%--                        });--%>
<%--                        return is;--%>
<%--                    });--%>

<%--                    self.groupMembers = filter;--%>

<%--                }).fail(function (data) {--%>
<%--                    displayErrors(data);--%>
<%--                });--%>

<%--            },--%>
<%--            selectionPerson : function(){--%>

<%--                $('.groupli').parent().find('> li').removeClass('bg-secondary');--%>
<%--                $('.groupli').addClass('bg-secondary');--%>

<%--                var self = this;--%>
<%--                this.groupMembers = this.originMembers;--%>

<%--                var filter = this.groupMembers.filter(function(member){--%>
<%--                    var is = true;--%>
<%--                    if (this.id == member.id)--%>
<%--                    $(self.receivers).each(function(){--%>
<%--                            is = false;--%>
<%--                    });--%>
<%--                    return is;--%>
<%--                });--%>

<%--                this.groupMembers = filter;--%>
<%--                this.currentGroup = {};--%>

<%--                this.groupMembers.map(m => {--%>
<%--                    m.chk = false;--%>
<%--                    return m;--%>
<%--                });--%>

<%--            },--%>
<%--            clear: function () {--%>
<%--                this.groups = [];--%>
<%--                this.groupMembers = [];--%>
<%--                this.receivers = [];--%>
<%--                this.originMembers = [];--%>
<%--                this.currentGroup = {};--%>
<%--            }--%>
<%--        }--%>
<%--    }--%>

<%--    $(function () {--%>
<%--        $('#userSearchModal').on('hidden.bs.modal', function (e) {--%>
<%--            vm.$refs.userSearchModal.clear();--%>
<%--        })--%>
<%--    })--%>
<%--</script>--%>
