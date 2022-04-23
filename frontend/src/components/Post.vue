<template>
<div class="post">
  <div class="post-header">
    <div class="profile-picture-container">
      <img class="pfp" :src="postData.USER.PROFILEPICTURE || require('@/assets/pfp-default.png')" alt="profile picture"/>
    </div>
    <p id="name">{{postData.USER.FIRSTNAME}} {{postData.USER.LASTNAME}}</p>
    <div class="icons">
      <img v-show="postData.USER.ID.toString() === $cookies.get('UserID').toString()" id="edit-icon" src="@/assets/edit.png" alt="edit-icon" @click="editModeOn" v-if="!editMode"/>
      <img v-show="postData.USER.ID.toString() === $cookies.get('UserID').toString()" id="delete-icon" src="@/assets/delete.png" alt="delete-icon" @click="deletePost" v-if="!editMode"/>
    </div>
    <button id="cancelEditButton" @click="editModeOff" v-if="editMode">Cancel</button>
  </div>
  <p id="text" v-if="!editMode">{{postData.TEXT}}</p>

  <textarea id="updateText" v-model="editedPostData.text" v-if="editMode"></textarea>
  <label id="upload-new-picture-label" for="upload-new-picture" v-if="editMode">Upload a new picture:</label>
  <input id="upload-new-picture" type="file" v-if="editMode"  @change="setUpdateImage($event)" ref="imageUpload"><br>
  <div  v-if="editMode" class="edit-post-buttons">
    <button id="send-edit-button" @click="onEditPost">Edit post</button>
    <button id="send-edit-and-delete-button" @click="onEditPostWithDelete" :disabled="imageDeleteDisabled">Delete image and edit post</button>
  </div>

  <img v-show="postData.PICTURE" id="picture" :src="postData.PICTURE" alt="post picture"/>
  <div class="post-footer">
    <p id="timestamp">{{postData.TIMESTAMP}}</p>
  </div>
  <hr/>
  <p id="comment-toggle" @click="collapseComments" >{{commentCollapsed ? 'View comments' : 'Hide comments'}}</p>
  <div :id="postData.ID" class="comments collapsible">
    <Comment :key="index" v-for="(comment, index) in comments" :comment="comment" :type="type" @delete="initComments" @edit="initComments"/>
  </div>
  <div class="new-comment-container">
    <textarea id="comment-input" v-model="newComment.content" rows="1" v-on:keydown.enter.exact.prevent="sendComment" placeholder="Write a comment..."></textarea>
    <button id="send-comment-btn" @click="sendComment">Send</button>
  </div>
</div>
</template>

<script>
import Comment from "@/components/Comment";
import FormData from "form-data";
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
      commentCollapsed: true,
      editMode: false,
      editedPostData: {
        text: '',
        picture: null,
      }
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
      this.$emit('delete');
    },

    collapseComments(){
      document.getElementById(this.postData.ID).classList.toggle('collapsed');
      this.commentCollapsed = !this.commentCollapsed;
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
        await this.initComments();
        this.newComment.content = '';
        this.collapseComments();
      }
    },

    editModeOn(){
      this.editedPostData.text = this.postData.TEXT;
      this.editMode = true;
    },
    editModeOff(){
      this.editMode = false;
      this.editedPostData.text = '';
      this.editedPostData.picture = '';
      this.editedPostData.picture = null;
      this.$refs.imageUpload.value = null;
    },

    setUpdateImage(event){
      if(event.target.files.length === 0){
        return;
      }
      this.editedPostData.picture = event.target.files[0];
    },

    async onEditPost(){
      if((this.editedPostData.picture !== undefined && this.editedPostData.picture !== null && this.editedPostData.picture !== '') ||
          (this.postData.PICTURE !== undefined && this.postData.PICTURE !== null && this.postData.PICTURE !== '') ||
          (this.editedPostData.text.trim() !== '')){

        const formData = new FormData();

        if(this.editedPostData.picture !== undefined && this.editedPostData.picture !== null && this.editedPostData.picture !== ''){
          formData.append('image', this.editedPostData.picture);
          formData.append('text', this.editedPostData.text);
        } else {
          formData.append('text', this.editedPostData.text);
        }

        try {
          await this.axios.post(
              `${this.$root.requestURL}/post/${this.type}/update/${this.postData.ID}`,
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
        await new Promise(r => setTimeout(r, 1000));
        this.$emit("postUpdate");
        this.editModeOff();
      }
    },

    async onEditPostWithDelete(){
      if(this.editedPostData.text.trim() !== '') {

        const formData = new FormData();
        formData.append('text', this.editedPostData.text);
        formData.append('removeImg', "yes");

        try {
          await this.axios.post(
              `${this.$root.requestURL}/post/${this.type}/update/${this.postData.ID}`,
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
        await new Promise(r => setTimeout(r, 1000));
        this.$emit("postUpdate");
        this.editModeOff();
      }
    },
  },
  computed: {
    imageDeleteDisabled(){
      return !((this.postData.PICTURE !== undefined && this.postData.PICTURE !== null && this.postData.PICTURE !== '') &&
          (this.editedPostData.picture === undefined || this.editedPostData.picture === null || this.editedPostData.picture === ''));
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

      .icons {
        margin-left: auto;
        display: flex;
        align-items: center;

        #delete-icon {
          width: 25px;

          &:hover {
            cursor: pointer;
          }

        }

        #edit-icon {
          width: 30px;
          margin-right: 15%;
          margin-left: -15%;

          &:hover {
            cursor: pointer;
          }

        }
      }

      #cancelEditButton {
        margin-left: auto;
        font-size: 16px;
        line-height: 24px;
        background-color: var(--accent-color);
        color: var(--font-color);
        border: none;
        border-radius: 20px;
        font-weight: bold;
        font-family: "Cambria", sans-serif;
        padding-left: 2%;
        padding-right: 2%;

        &:hover {
          cursor: pointer;
          -webkit-filter: brightness(85%);
          transition: all 100ms ease;
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

    #updateText {
      display: block;
      margin-left: auto;
      margin-right: auto;
      width: 90%;
      height: 48px;
      margin-bottom: 2%;
      font-family: Cambria,serif;
      font-size: 16px;
      resize: none;
      border-radius: 15px;
      padding: 1% 2%;
    }

    #upload-new-picture-label {
      margin-left: 3%;
    }

    #upload-new-picture {
      margin-bottom: 3%;
      margin-left: 2%;
      margin-top: 2%;
    }

    .edit-post-buttons {
      display: flex;
      justify-content: right;
      margin-bottom: 2%;

      #send-edit-button, #send-edit-and-delete-button {
        font-size: 16px;
        line-height: 24px;
        background-color: var(--accent-color);
        color: var(--font-color);
        border: none;
        border-radius: 20px;
        font-weight: bold;
        font-family: "Cambria", sans-serif;
        padding-left: 2%;
        padding-right: 2%;

        &:hover {
          cursor: pointer;
          -webkit-filter: brightness(85%);
          transition: all 100ms ease;
        }

        &:disabled {
          -webkit-filter: brightness(40%);
          cursor: auto;
        }
      }

      #send-edit-button {
        margin-right: 2%;
      }

    }



    #picture {
      width: 100%;
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
        margin-left: 2%;
        border-radius: 15px;
        overflow: hidden;
        padding: 1% 2%;
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

    ::-webkit-scrollbar {
      width: 10px;
    }

    /* Track */
    ::-webkit-scrollbar-track {
      box-shadow: inset 0 0 5px var(--ouline-color);
      border-radius: 10px;
    }

    /* Handle */
    ::-webkit-scrollbar-thumb {
      background: var(--ouline-color);
      border-radius: 10px;
    }
    /* Handle on hover */
    ::-webkit-scrollbar-thumb:hover {
      background: #85a3b0;
    }

    .comments{
      max-height: 0;
      overflow-y: auto;

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