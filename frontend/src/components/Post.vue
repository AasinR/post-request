<template>
<div class="post">
  <div class="post-header">
    <div class="profile-picture-container">
      <img class="pfp" :src="profilePicture || require('@/assets/pfp-default.png')" alt="profile picture"/>
    </div>
    <p id="name">{{name}}</p>
    <p id="timestamp">{{postData.TIMESTAMP.substring(0, 10)}}</p>
  </div>

  <p id="text">{{postData.TEXT}}</p>
  <img v-show="postData.PICTURE" id="picture" :src="postData.PICTURE" alt="post picture"/>
</div>
</template>

<script>
export default {
  name: "Post",
  props: {
    postData: Array,
    name: String,
    profilePicture: String
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

    .post-header {
      display: flex;
      flex-direction: row;
      align-items: center;

      #timestamp {
        margin-left: auto;
        font-size: 12px;
      }

      #name {
        font-weight: bold;
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
  }

</style>