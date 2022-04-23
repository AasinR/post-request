<template>
<div class="comment">
  <div class="comment-header">
    <div class="profile-picture-container">
      <img class="pfp" :src="comment.USER.PROFILEPICTURE || require('@/assets/pfp-default.png')" alt="profile picture"/>
    </div>
    <p class="name">{{comment.USER.FIRSTNAME}} {{comment.USER.LASTNAME}}</p>
    <div v-if="!editMode" class="icons">
      <img v-show="comment.USER.ID.toString() === $cookies.get('UserID').toString()" id="edit-icon" src="@/assets/edit.png" alt="edit-icon" @click="editModeOn"/>
      <img v-show="comment.USER.ID.toString() === $cookies.get('UserID').toString()" id="delete-icon" src="@/assets/delete.png" alt="delete-icon" @click="deleteComment"/>
    </div>
<!--    <div class="edit-buttons">-->
      <button id="edit-button" v-if="editMode" @click="editComment">Edit</button>
      <button id="cancel-button" v-if="editMode" @click="editModeOff">Cancel</button>
<!--    </div>-->
  </div>
  <p class="comment-content" v-if="!editMode">{{comment.CONTENT}}</p>
  <textarea id="edit-comment-input" v-if="editMode" v-model="editedCommentContent"></textarea>
  <div class="comment-footer">
    <p id="timestamp">{{comment.TIMESTAMP}}</p>
  </div>
</div>
</template>

<script>
export default {
  name: "Comment",
  props:{
    comment: Object,
    type: String,
  },
  data(){
    return {
      editMode: false,
      editedCommentContent: '',
    }
  },
  methods: {
    editModeOn(){
      this.editedCommentContent = this.comment.CONTENT;
      this.editMode = true;
    },

    editModeOff(){
      this.editMode = false;
      this.editedCommentContent = '';
    },

    async editComment(){
      if(this.editedCommentContent.trim() !== '') {
        try {
          await this.axios.post(`${this.$root.requestURL}/comment/${this.type}/update/${this.comment.ID}`, {
            content: this.editedCommentContent,
          })
        } catch (err) {
          console.log(err.response.data);
        }
        this.$emit("edit");
        this.editModeOff();
      }
    },

    async deleteComment(){
      try {
        await this.axios.get(`${this.$root.requestURL}/comment/${this.type}/delete/${this.comment.ID}`);
      } catch (err) {
        console.log(err.response.data);
      }
      this.$emit('delete');
    },
  },
}
</script>

<style lang="scss" scoped>
.comment {
  border: solid 1px var(--ouline-color);
  margin-bottom: 2%;
  margin-right: 5%;
  border-radius: 20px;
  padding: 1% 4%;
  background-color: var(--light-bg-color);
  word-wrap: break-word;

  .comment-header {
    display: flex;
    flex-direction: row;
    align-items: center;
    margin-top: 2%;

    .profile-picture-container {
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

    .name {
      display: inline-block;
      margin: 0;
      font-weight: bold;
    }

    .icons {
      margin-left: auto;
      display: flex;
      align-items: center;

      #edit-icon {
        width: 30px;
        margin-right: 15%;
        margin-left: -15%;

        &:hover {
          cursor: pointer;
        }
      }

      #delete-icon {
        width: 25px;

        &:hover {
          cursor: pointer;
        }
      }
    }

    #edit-button {
      margin-left: auto;
      margin-right: 2%;
    }

    #cancel-button, #edit-button {
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
  }


  .comment-content{
    margin-bottom: 0;
  }

  #edit-comment-input {
    display: block;
    width: 90%;
    height: 32px;
    margin: 2% auto;
    font-family: Cambria,serif;
    font-size: 16px;
    resize: none;
    border-radius: 15px;
    padding: 1% 2%;
  }

  .comment-footer{
    display: flex;
    flex-direction: row;
    align-items: center;

    #timestamp {
      display: block;
      margin-left: auto;
      margin-top: 0;
      margin-bottom: 0;
      font-size: 12px;
    }
  }

}
</style>