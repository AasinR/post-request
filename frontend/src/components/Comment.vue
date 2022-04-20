<template>
<div class="comment">
  <div class="comment-header">
    <div class="profile-picture-container">
      <img class="pfp" :src="comment.USER.PROFILEPICTURE || require('@/assets/pfp-default.png')" alt="profile picture"/>
    </div>
    <p class="name">{{comment.USER.FIRSTNAME}} {{comment.USER.LASTNAME}}</p>
    <img v-show="comment.USER.ID.toString() === $cookies.get('UserID').toString()" id="delete-icon" src="@/assets/delete.png" alt="delete-icon" @click="deleteComment"/>
  </div>
<p class="comment-content">{{comment.CONTENT}}</p>
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
  methods: {
    async deleteComment(){
      try {
        await this.axios.get(`${this.$root.requestURL}/comment/${this.type}/delete/${this.comment.ID}`);
      } catch (err) {
        console.log(err.response.data);
      }
      await this.$router.go();
    },
  },
}
</script>

<style lang="scss" scoped>
.comment{
  border: solid 1px var(--ouline-color);
  margin-bottom: 2%;
  margin-right: 5%;
  border-radius: 20px;
  padding: 1% 4%;
  background-color: var(--light-bg-color);
  word-wrap: break-word;

  .comment-header{
    display: flex;
    flex-direction: row;
    align-items: center;
    margin-top: 2%;

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

    .name {
      display: inline-block;
      margin: 0;
      font-weight: bold;
    }

    #delete-icon {
      width: 25px;
      margin-left: auto;

      &:hover {
        cursor: pointer;
      }
    }
  }

  .comment-content{
    margin-bottom: 0;
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