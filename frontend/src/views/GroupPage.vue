<template>
  <div class="group-page">
    <Header/>
    <Navbar current="groups"/>
    <div class="content">
      <div class="group-header">
        <div class="logo-container">
          <img class="logo" :src="groupData.logo || require('@/assets/grouplogo-default.png')" alt="group logo"/>
        </div>
        <div class="name-container">
          <p>{{groupData.name}}</p>
        </div>
        <div class="header-buttons">
          <button v-if="Number($cookies.get('UserID')) === Number(groupData.ownerID)" class="header-edit-btn" @click="goToEditGroup">Edit group</button>
          <button v-if="!isMember && loadDone" id="join-group-button" @click="joinGroup">Join group</button>
        </div>
      </div>
      <div class="group-content">
        <div class="members-side">
          <div class="members-container">
            <h3>Members </h3>
            <p class="member-count">({{memberCount}})</p>
            <div class="group-members-container">
              <GroupMemberProfile v-for="(member, index) in members" :key="index" :user="member" :owner-id="groupData.ownerID"/>
            </div>
          </div>
          <div class="active-members-container">
            <h3>Most active members</h3>
            <p class="number-of-posts" v-if="activeMemberExists">With number of posts: <span>{{activeMemberExists ? activeMembers[0].GP_COUNT : ''}}</span></p>
            <div class="active-members">
              <GroupMemberProfile v-for="(activeMember, index) in activeMembers" :key="index" :user="activeMember" :owner-id="groupData.ownerID" active-members/>
            </div>
          </div>
        </div>
        <div class="posts-container">
          <div v-if="isMember" class="new-post">
            <h2>Make a new post!</h2>
            <textarea id="newpost-text" v-model="newPost.content" v-on:keydown.enter.exact.prevent="sendNewPost" placeholder="Write your post here..."></textarea>
            <input id="newpost-picture" type="file"  @change="setNewPostImage($event)" ref="imageUpload"><br>
            <button @click="sendNewPost" type="submit" id="new-post-submit" >Post</button>
          </div>
          <div class="posts">
            <h2>Posts</h2>
            <Post v-for="post in posts" :key="post.ID" :post-data="post" type="group" @delete="atPostDelete" @postUpdate="initPosts"></Post>
          </div>
        </div>
      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Footer from "@/components/Footer";
import Navbar from "@/components/Navbar";
import Header from "@/components/Header";
import Post from "@/components/Post";

import FormData from 'form-data';
import GroupMemberProfile from "@/components/Group-Member-Profile";

export default {
  name: "GroupPage",
  components: {
    GroupMemberProfile,
    Footer,
    Navbar,
    Header,
    Post
  },
  props: {
    groupID: Number | String,
  },
  data() {
    return {
      groupData: {
        id: '',
        name: '',
        logo: '',
        ownerID: ''
      },

      members: [],
      posts: [],

      newPost: {
        groupID: this.groupID,
        content: '',
        image: null,
      },

      usersGroups: [],
      loadDone: false,

      activeMembers: [],
      memberCount: '',
    }
  },
  methods: {
    atPostDelete(){
      this.initPosts();
      this.initActiveMembers();
    },

    setNewPostImage(event){
      if(event.target.files.length === 0){
        return;
      }
      this.newPost.image = event.target.files[0]
    },

    async initGroupData(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/group/get/${this.groupID}`);
        this.groupData.id = response.data.result.ID;
        this.groupData.name = response.data.result.NAME;
        this.groupData.logo = response.data.result.LOGO;
        this.groupData.ownerID = response.data.result.OWNERID;
      } catch (err) {
        console.log(err);
      }
    },

    async initMembers(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/group/member/getall/${this.groupID}`);
        this.members = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async initPosts(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/post/group/getall/${this.groupID}`);
        this.posts = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async initUsersGroups(){
      this.loadDone = false;
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/group/getall/${this.$cookies.get('UserID')}`);
        this.usersGroups = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async initActiveMembers(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/group/active/${this.groupID}`);
        this.activeMembers = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async initMemberCount(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/group/member/count/${this.groupID}`);
        this.memberCount = response.data.result.MEMBERCOUNT;
      } catch (err) {
        this.memberCount = 0;
        console.log(err.response.data);
      }
    },

    async sendNewPost(){
      if(this.newPost.content.trim() !== '') {

        const formData = new FormData();
        formData.append('image', this.newPost.image);
        formData.append('text', this.newPost.content);
        formData.append('groupId', this.newPost.groupID);

        try {
          await this.axios.post(
              `${this.$root.requestURL}/post/group/create`,
              formData,
              {
                headers: {
                  'content-type': 'multipart/form-data'
                }
              }
          )
        } catch (err) {
          console.log(err.response.data);
        }

        await new Promise(r => setTimeout(r, 200));
        await this.initPosts();
        await this.initActiveMembers();
        this.newPost.content = '';
        this.newPost.image = null;
        this.$refs.imageUpload.value = null;
      }
    },

    async joinGroup(){
      try {
        await this.axios.get(`${this.$root.requestURL}/group/member/add/${this.groupID}`);
      } catch (err) {
        console.log(err);
      }

      await this.initUsersGroups();
      await this.initMembers();
      await this.initMemberCount();
    },

    goToEditGroup(){
      this.$router.replace({name: 'EditGroup', params:{groupID: this.groupID}});
    },
  },
  computed: {
    isMember() {
      this.loadDone = false;
      for (const usersGroup of this.usersGroups){
        if(Number(usersGroup.GROUP.ID) === Number(this.groupID)){
          this.loadDone = true;
          return true;
        }
      }
      this.loadDone = true;
      return false;
    },

    activeMemberExists(){
      if(this.activeMembers[0] !== undefined && this.activeMembers[0] !== null){
        return true;
      }
      return false;
    },
  },
  mounted() {
    this.initGroupData();
    this.initMembers();
    this.initUsersGroups();
    this.initPosts();
    this.initActiveMembers();
    this.initMemberCount();
  }
}
</script>

<style lang="scss" scoped>
.group-page {
  padding-top: 8vh;
  padding-bottom: 10vh;

  .content {
    margin-left: auto;
    margin-right: auto;
    width: 60%;
  }

  .group-header {
    background-color: var(--light-bg-color);
    padding: 2% 5%;
    display: flex;
    flex-direction: row;
    align-items: flex-start;
    margin-bottom: 2%;

    .logo-container {
      width: 150px;
      height: 150px;
      background-color: var(--ouline-color);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;

      border-radius: 80px;
      border: solid 4px var(--ouline-color);

      overflow: hidden;

      .logo {
        max-width: 150px;
        max-height: 150px;
      }
    }

    .name-container {
      margin-left: 3%;
      width: fit-content;
      margin-top: 3%;

      p {
        font-size: 30px;
        font-family: Cambria, serif;
        font-weight: bold;
        margin: 0;
      }
    }

    .header-buttons {
      display: flex;
      align-items: center;
      justify-content: flex-end;
      align-self: flex-end;
      margin-left: auto;
      width: 40%;

      #join-group-button {
        display: block;
        font-size: 20px;
        line-height: 30px;
        background-color: var(--accent-color);
        color: var(--font-color);
        border: none;
        border-radius: 20px;
        font-weight: bold;
        font-family: "Cambria", sans-serif;
        padding-left: 3%;
        padding-right: 3%;
        margin-left: 2%;

        &:hover {
          cursor: pointer;
          -webkit-filter: brightness(90%);
          transition: all 100ms ease;
        }
      }

      .header-edit-btn{
        display: block;
        font-size: 20px;
        line-height: 30px;
        background-color: var(--accent-color);
        color: var(--font-color);
        border: none;
        border-radius: 20px;
        font-weight: bold;
        font-family: "Cambria", sans-serif;
        padding-left: 3%;
        padding-right: 3%;

        &:hover {
          cursor: pointer;
          -webkit-filter: brightness(90%);
          transition: all 100ms ease;
        }
      }
    }

  }

  .group-content {
    display: flex;
    flex-direction: row;
    align-items: flex-start;

    .members-side{
      width: 30%;

      .members-container {
        background-color: var(--light-bg-color);
        padding: 9% 9%;

        h3 {
          margin: 0 0 5% 0;
          display: inline-block;
        }

        .member-count {
          display: inline-block;
          margin-left: 2%;
          margin-top: 0;
          font-size: 14px;
        }

        .group-members-container {
          max-height: 30vh;
          height: 30vh;
          overflow-y: auto;
          overflow-x: hidden;
        }
      }

      .active-members-container {
        background-color: var(--light-bg-color);
        padding: 9% 9%;
        margin-top: 7%;

        h3 {
          margin: 0 0 5% 0;
        }

        .number-of-posts{
          font-style: italic;
          margin-left: 5%;

          span {
            font-weight: bold;
          }
        }

        .active-members {
          max-height: 30vh;
          height: 15vh;
          overflow-y: auto;
          overflow-x: hidden;
        }
      }
    }

    .posts-container {
      width: 70%;
      display: flex;
      flex-direction: column;
      align-items: flex-start;
      margin-left: 2%;


      .new-post, .posts {
        width: 92%;
        background-color: var(--light-bg-color);
        margin-bottom: 3%;
        padding: 4% 4%;

        h2 {
          margin: 0 0 5% 0;
        }
      }

      .new-post {
        #newpost-text {
          display: block;
          width: 80%;
          height: 48px;
          margin-bottom: 2%;
          font-family: Cambria,serif;
          font-size: 16px;
          resize: none;
          border-radius: 15px;
          padding: 1% 2%;
        }

        #new-post-submit {
          display: block;
          font-size: 20px;
          line-height: 30px;
          background-color: var(--accent-color);
          color: var(--font-color);
          border: none;
          border-radius: 20px;
          font-weight: bold;
          font-family: "Cambria", sans-serif;
          margin-left: auto;
          padding-left: 3%;
          padding-right: 3%;
          margin-top: 2%;

          &:hover {
            cursor: pointer;
            -webkit-filter: brightness(90%);
            transition: all 100ms ease;
          }

        }
      }

    }
  }
}
</style>