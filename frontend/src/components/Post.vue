<template>
<div class="post">
  <div class="post-header">
    <div class="profile-picture-container">
      <img class="pfp" :src="postData.USER.PROFILEPICTURE || require('@/assets/pfp-default.png')" alt="profile picture"/>
    </div>
    <p id="name">{{postData.USER.FIRSTNAME}} {{postData.USER.LASTNAME}}</p>
    <img v-show="postData.USER.ID.toString() === $cookies.get('UserID').toString()" id="delete-icon" src="@/assets/delete.png" alt="delete-icon" @click="deletePost"/>
  </div>
  <p id="text">{{postData.TEXT}}</p>
  <img v-show="postData.PICTURE" id="picture" :src="postData.PICTURE" alt="post picture"/>
  <div class="post-footer">
    <p id="timestamp">{{postData.TIMESTAMP}}</p>
  </div>
  <hr/>
  <p id="comment-toggle" @click="collapseComments" >View comments</p>
  <div :id="postData.ID" class="comments collapsible">
    <Comment v-for="comment in comments" :comment="comment" :type="type"/>
  </div>
  <div class="new-comment-container">
    <textarea id="comment-input" v-model="newComment.content" placeholder="Write a comment..."></textarea>
    <button id="send-comment-btn" @click="sendComment">Send</button>
  </div>
</div>
</template>

<script>
import Comment from "@/components/Comment";
export default {
  name: "Post",
  components: {Comment},
  props: {
    postData: Object,
    type: String,
  },
  data() {
    return {
      userID: 0,
      comments: [],
      newComment: {
        content: '',
        postID: this.postData.ID,
      },
    }
  },
  methods: {
    async initComments(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/comment/${this.type}/getall/${this.postData.ID}`);
        this.comments = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async deletePost() {
      try {
        await this.axios.get(`${this.$root.requestURL}/post/${this.type}/delete/${this.postData.ID}`);
      } catch (err) {
        console.log(err.response.data);
      }
      await this.$router.go();
    },

    collapseComments(){
      document.getElementById(this.postData.ID).classList.toggle('collapsed');
    },

    async sendComment(){
      if(this.newComment.content.trim() !== '') {
        try {
          await this.axios.post(`${this.$root.requestURL}/comment/${this.type}/create`, {
            postId: this.newComment.postID,
            content: this.newComment.content,
          })
        } catch (err) {
          console.log(err.response.data);
        }
        await this.$router.go();
      }
    },
  },
  mounted() {
    this.initComments();
  }
}


</script>

<style lang="scss" scoped>

  .post {
    border: var(--ouline-color) solid 2px;
    border-radius: 20px;
    padding: 2% 4%;
    margin-bottom: 5%;
    background-color: var(--lighter-bg-color);
    word-wrap: break-word;

    .post-header {
      display: flex;
      flex-direction: row;
      align-items: center;


      #name {
        font-weight: bold;
      }

      #delete-icon {
        width: 25px;
        margin-left: auto;

        &:hover {
          cursor: pointer;
        }
      }

      .profile-picture-container{
        width: 25px;
        height: 25px;
        background-color: var(--ouline-color);
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;

        border-radius: 30px;
        border: solid 2px var(--ouline-color);

        overflow: hidden;
        margin-right: 2%;

        .pfp {
          max-width: 25px;
          max-height: 25px;
        }
      }
    }

    #text {
      margin: 0 0 1.5% 0;
    }

    #picture {
      max-width: 100%;
      display: block;
      margin-left: auto;
      margin-right: auto;
    }

    .post-footer{
      display: flex;
      flex-direction: row;
      align-items: center;

      #timestamp {
        display: block;
        margin-left: auto;
        margin-top: 1.5%;
        margin-bottom: 0;
        font-size: 12px;
      }
    }

    .new-comment-container{
      margin-top: 2%;
      display: flex;
      align-items: center;

      #comment-input {
        width: 80%;
        height: 25px;
        margin-left: 2%;
        border-radius: 15px;
        overflow: hidden;
        padding-left: 2%;
        padding-right: 2%;
        padding-top: 1%;
        font-family: Cambria,serif;
        resize: none;
      }
      #send-comment-btn{
        background-color: var(--accent-color);
        color: var(--font-color);
        border: none;
        border-radius: 20px;
        font-weight: bold;
        font-family: "Cambria", sans-serif;
        padding: 1% 2%;
        margin-left: 1%;

        &:hover {
          cursor: pointer;
          -webkit-filter: brightness(90%);
          transition: all 100ms ease;
        }

      }
    }

    .comments{
      max-height: 0;
      overflow-y: scroll;

      &.collapsed {
        max-height: 400px;
      }

    }

    #comment-toggle {
      &:hover {
        text-decoration: underline;
        cursor: pointer;
      }
    }
  }

</style>