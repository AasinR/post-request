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
    <p id="timestamp">{{postData.TIMESTAMP.substring(0, 10)}}</p>
  </div>
</div>
</template>

<script>
export default {
  name: "Post",
  props: {
    postData: Object,
  },
  data() {
    return {
      userID: 0,
    }
  },
  methods: {
    async deletePost() {
      try {
        await this.axios.get(`${this.$root.requestURL}/post/public/delete/${this.postData.ID}`);
      } catch (err) {
        console.log(err.response.data);
      }
      await this.$router.go();
    },
  },
}


</script>

<style lang="scss" scoped>

  .post {
    border: var(--ouline-color) solid 2px;
    border-radius: 20px;
    padding: 2% 4%;
    margin-bottom: 5%;
    background-color: var(--lighter-bg-color);

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
      margin: 0 0 3% 0;
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
        margin-top: 0;
        margin-bottom: 0;
        font-size: 12px;
      }
    }

  }

</style>