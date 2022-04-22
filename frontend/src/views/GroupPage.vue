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
<!--        <button v-if="$cookies.get('UserID') === userID" class="header-edit-btn" @click="editProfile">Edit profile</button>        TODO-->
      </div>
      <div class="group-content">
        <div class="members-container">
          <h2>Members</h2>
        </div>
        <div class="posts-container">
          <div v-if="isMember" class="new-post">
            <h2>Make a new post!</h2>
            <textarea id="newpost-text" v-model="newPost.content"></textarea>
            <input id="newpost-picture" type="file" @change="setNewPostImage($event)" ref="imageUpload"><br>
            <button @click="sendNewPost" type="submit" id="new-post-submit" >Post</button>
          </div>
          <div class="posts">
            <h2>Posts</h2>
            <Post v-for="post in posts" :key="post.ID" :post-data="post" type="group" @delete="initPosts" @postUpdate="initPosts"></Post>
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

export default {
  name: "GroupPage",
  components: {
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
        name: 'Owly Owls',
        logo: '',
      },
      posts: [],

      newPost: {
        groupID: this.groupID,
        content: '',
        image: null,
      },

      usersGroups: [],
    }
  },
  methods: {
    setNewPostImage(event){
      if(event.target.files.length === 0){
        return;
      }
      this.newPost.image = event.target.files[0]
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
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/group/getall/${this.$cookies.get('UserID')}`);
        this.usersGroups = response.data.result;
      } catch (err) {
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
        this.newPost.content = '';
        this.newPost.image = null;
        this.$refs.imageUpload.value = null;
      }
    },
  },
  computed: {
    isMember() {
      for (const usersGroup of this.usersGroups){
        if(Number(usersGroup.GROUP.ID) === Number(this.groupID)){
          return true;
        }
      }
      return false;
    }
  },
  mounted() {
    this.initUsersGroups();
    this.initPosts();
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

    //.header-edit-btn{
    //  display: block;
    //  font-size: 20px;
    //  line-height: 30px;
    //  background-color: var(--accent-color);
    //  color: var(--font-color);
    //  border: none;
    //  border-radius: 20px;
    //  font-weight: bold;
    //  font-family: "Cambria", sans-serif;
    //  align-self: flex-end;
    //  margin-left: auto;
    //  padding-left: 3%;
    //  padding-right: 3%;
    //
    //  &:hover {
    //    cursor: pointer;
    //    -webkit-filter: brightness(90%);
    //    transition: all 100ms ease;
    //  }
    //}

  }

  .group-content {
    display: flex;
    flex-direction: row;
    align-items: flex-start;

    .members-container {
      background-color: var(--light-bg-color);
      width: 30%;
      padding: 3% 3%;

      h2 {
        margin: 0 0 5% 0;
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
          font-family: Cambria, serif;
          font-size: 16px;
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