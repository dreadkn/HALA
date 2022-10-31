<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<script type="text/x-template" id="group-component">
        <div class="modal fade" id="groupModal" data-backdrop="static" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalFormLabel">주소 그룹 관리</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container-fluid address-group-wrap">
                            <div class="row ">
                                <div class="col-3">
                                    <ul id="group-list" class="list-group ">
                                        <li class="list-group-item">
                                            <span class="btn" @click="addGroup">+ 새그룹 추가</span>
                                        </li>
                                        <li class="list-group-item" @click="selectionGroup(item)" v-for="(item, idx) in groups" :class="'groupli' + item.id">
                                            <div class="form-group d-flex align-items-center mb-0">
                                                <input class="form-control " :class="'group' + item.id" name="groupName" @change="updateGroup(item.id)" v-model="item.groupName"  readonly>
                                                <i class="fas fa-edit ml-1" @click="editMode(item.id)" ></i>
                                                <i class="far fa-times-circle ml-1" @click="deleteGroup(item.id)"></i>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-4 overflow-auto">
                                    <div class="form-group d-flex ">
                                        <input class="form-control w-75" name="keyword" id="keyword1">
                                        <button @click="searchUser" type="button" class="btn btn-sm btn-outline-primary row-detail text-nowrap ml-1">검색</button>
                                    </div>
                                    <ul class="list-group person-list">
                                        <li class="list-group-item" v-for="(item, idx) in members">
                                            <div class="form-group d-flex align-items-baseline mb-0">
                                                <input type="checkbox" class="mr-1" name="userId" :id="'member' + item.id"  value="item.id" v-model="item.chk">
                                                <label :for="'member' + item.id">{{item.name}} {{item.phone}}</label>
                                            </div>
                                        </li>
                                        <li class="list-group-item" v-if="members.length == 0">
                                            <p>조회 결과가 없습니다.</p>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-1 d-flex align-items-center justify-content-center">
                                    <button @click="moveUser" type="button" class="btn btn-sm btn-outline-primary row-detail text-nowrap ">추가 ></button>
                                </div>
                                <div class="col-4 ">
                                    <h5>{{currentGroup.groupName}}</h5>
                                    <ul class="list-group person-list">
                                        <li class="list-group-item" v-for="(item, idx) in groupMembers">
                                            <i class="far fa-times-circle" @click="deleteUser(item.id)"></i>
                                            <span >{{item.name}}</span>
                                            <span >{{item.phone}}</span>
                                        </li>
                                        <li class="list-group-item" v-if="groupMembers.length == 0">
                                            <p>그룹에 사용자가 없습니다.</p>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <div class="col-auto ml-auto">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</script>

<script>
    var groupComponent = {
        template: '#group-component',
        mounted: function () {
        },
        data: function () {
            return {
                groups: [],
                members: [],
                originMembers: [],
                groupMembers: [],
                currentGroup: {
                    groupName : '그룹 미선택'
                },
                isSelection: false,
                data : {
                    groupName : ''
                }
            }
        },
        methods: {
            open: function () {
                this.fetch();
                this.fetchMember();
                $('#groupModal').modal('show');
            },
            fetch: function () {
                var self = this;
                jQuery.ajax(contextPath + "/admin/sms/group", {
                    method: 'GET',
                    contentType: 'application/json'
                }).done(function (data) {
                    self.groups = data;
                })
                .fail(function (data) {
                    errorToastr("그룹 조회 중 오류가 발생하였습니다.");
                });
            },
            fetchMember: function () {
                var self = this;
                jQuery.ajax(contextPath + "/admin/sms/member", {
                    method: 'GET',
                    contentType: 'application/json'
                }).done(function (data) {
                    data = data.map(m => {
                        m.chk = false;
                        return m;
                    });

                    self.members = data;
                    self.originMembers = data;
                })
                .fail(function (data) {
                    errorToastr("멤버 조회 중 오류가 발생하였습니다.");
                });
            },
            convGroup : function(group){

                var convGroup = JSON.parse(JSON.stringify(group));
                var memberIds = [];

                $(convGroup.members).each(function(){
                    memberIds.push(this.id === undefined ? this : this.id);
                });
                convGroup.members = memberIds;

                return convGroup;
            },
            searchUser : function(){
                console.log('a')
                var self = this;
                var keyword = $('#keyword1').val();
                var searchData = this.originMembers.filter(function (member) {

                    return member.name.indexOf(keyword) > -1
                        || member.phone.indexOf(keyword) > -1;
                });

                var filter = searchData.filter(function(member){
                    var is = true;
                    $(self.groupMembers).each(function(){
                        if (this.id == member.id)
                            is = false;
                    });
                    return is;
                });

                this.members = filter;
            },
            saveUser: function (group) {
                var self = this;
                var url = "/admin/sms/group";

                var selectionGroup = this.convGroup(group);

                jQuery.ajax(url, {
                    method: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(selectionGroup),
                    dataType: 'json'
                }).done(function (data) {

                }).fail(function (data) {
                    displayErrors(data);
                });

            },
            deleteUser : function(memberId){
                var self = this;
                var filter = this.groupMembers.filter(function (member) {
                    return member.id != memberId;
                });

                var filterItem = this.groupMembers.filter(function (member) {
                    return member.id == memberId;
                });

                this.groupMembers = filter;
                this.currentGroup.members = filter;

                this.members = $.merge(this.members, filterItem);
                this.members.push();

                this.members.map(m => {
                    m.chk = false;
                    return m;
                });

                this.currentGroup.members = this.groupMembers;
                this.saveUser(this.currentGroup);
            },
            moveUser : function(){
                if (this.isSelection)
                {
                    var filter = this.members.filter(function (member) {
                        return member.chk == true;
                    });

                    var filterList = this.members.filter(function (member) {
                        return member.chk != true;
                    });

                    if(filter.length > 0)
                    {
                        this.groupMembers = $.merge(this.groupMembers, filter);
                        this.groupMembers.push();

                        this.members = filterList;

                        this.currentGroup.members = this.groupMembers;
                        this.saveUser(this.currentGroup);
                    }
                }
                else
                    alertWarning("그룹을 선택하세요.");
            },
            editMode : function(groupId){
                $('.group' + groupId).prop('readonly', !$('.group' + groupId).is('[readonly]'));
            },
            addGroup : function(){
                var self = this;
                var url = "/admin/sms/group";

                var groupNm = '그룹명' + $('#group-list li').length;

                var data = {
                    groupName : groupNm
                };

                jQuery.ajax(url, {
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(data),
                    dataType: 'json'
                }).done(function (data) {
                    var callback = function (isConfirm) {
                        self.fetch();
                    }
                    alertSuccessAfterCallback(callback, "등록되었습니다!");
                }).fail(function (data) {
                    displayErrors(data);
                });
            },
            updateGroup : function(groupId){
                var self = this;
                var url = "/admin/sms/group/" + groupId;

                var selectionGroup = this.convGroup(this.currentGroup);
                selectionGroup.groupName = $('.group' + groupId).val();

                jQuery.ajax(url, {
                    method: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(selectionGroup),
                    dataType: 'json'
                }).done(function (data) {
                    var callback = function (isConfirm) {
                        $('.group' + groupId).prop('readonly', true);
                    }
                    alertUpdatedAfterCallback(callback);
                }).fail(function (data) {
                    displayErrors(data);
                    $('.group' + groupId).prop('readonly', true);
                });
            },
            deleteGroup : function(groupId){
                var self = this;

                var callback = function (isConfirm) {
                    if (isConfirm) {
                        var url = "/admin/sms/group/" + groupId;
                        jQuery.ajax(url, {
                            method: 'DELETE',
                            contentType: 'application/json',
                            dataType: 'json'
                        }).done(function (data) {
                            var callback = function (isConfirm) {
                                self.fetch();
                            }
                            alertDeletedAfterCallback(callback);
                        }).fail(function (data) {
                            displayErrors(data);
                        });
                    }
                }
                deleteConfirm(callback);
            },
            selectionGroup : function(group){
                var self = this;
                var url = "/admin/sms/member/group";

                $('.groupli' + group.id).parent().find('> li').removeClass('bg-secondary');
                $('.groupli' + group.id).addClass('bg-secondary');

                var selectionGroup = this.convGroup(group);

                jQuery.ajax(url, {
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(selectionGroup),
                    dataType: 'json'
                }).done(function (data) {
                    self.groupMembers = data;
                    self.currentGroup = group;
                    self.isSelection = true;

                    var filter = self.originMembers.filter(function(member){
                        var is = true;
                        $(data).each(function(){
                            if (this.id == member.id)
                                is = false;
                        });
                        return is;
                    });

                    self.members = filter;

                    self.members.map(m => {
                        m.chk = false;
                        return m;
                    });

                }).fail(function (data) {
                    displayErrors(data);
                });

            },
            clear: function () {
                this.groups = [];
                this.members = [];
                this.originMembers = [];
                this.groupMembers = [];
                this.currentGroup = {
                    groupName : '그룹 미선택'
                };
                this.isSelection = false
                this.data = {
                    groupName : ''
                };
            }
        }
    }

    $(function () {
        $('#groupModal').on('hidden.bs.modal', function (e) {
            vm.$refs.groupModal.clear();
        })
    })
</script>
