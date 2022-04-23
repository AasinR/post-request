<template>
<div class="friend-request">
  <router-link :to="{name: 'Profile', params: {userID: friendRequest.ID}}" class="link">
    <div class="profile-picture-container">
      <img class="pfp" :src="friendRequest.PROFILEPICTURE || require('@/assets/pfp-default.png')" alt="profile picture"/>
    </div>
    <p class="name">{{friendRequest.FIRSTNAME}} {{friendRequest.LASTNAME}}</p>
  </router-link>
  <div class="accept-buttons">
    <img @click="accept" class="accept-img" src="@/assets/accept.png" alt="accept-img">
    <img @click="reject" class="reject-img" src="@/assets/reject.png" alt="reject-img">
  </div>
</div>
</template>

<script>
export default {
  name: "Friend-Request",
  props: {
    friendRequest: Object,
  },
  methods: {
    async accept(){
      try {
        await this.axios.get(`${this.$root.requestURL}/friend/request/accept/${this.friendRequest.ID}`);
      } catch (err) {
        console.log(err.response.data);
      }
      this.$emit("accept");
    },
    async reject(){
      try {
        await this.axios.get(`${this.$root.requestURL}/friend/request/reject/${this.friendRequest.ID}`);
      } catch (err) {
        console.log(err.response.data);
      }
      this.$emit("reject");
    },
  }
}
</script>

<style lang="scss" scoped>
.friend-request {
  border-top: solid 2px var(--ouline-color);
  border-bottom: solid 2px var(--ouline-color);
  padding: 1% 3%;
  display: flex;
  flex-direction: row;
  align-items: center;
  width: 90%;
  margin-left: auto;
  margin-right: auto;
  margin-bottom: -2px;

  &:hover {
    background-color: var(--lighter-bg-color);
  }

  .link {
    display: flex;
    flex-direction: row;
    align-items: center;
    width: 80%;
    text-decoration: none;

    .profile-picture-container {
      width: 40px;
      height: 40px;
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
        max-width: 40px;
        max-height: 40px;
      }
    }
  }

  .name {
    font-size: 20px;
    color: var(--font-color);
  }

  .accept-buttons {
    margin-left: auto;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: right;

    .accept-img {
      margin-right: 15%;

      &:hover {
        cursor: pointer;
        -webkit-filter: brightness(80%);
        transition: all 100ms ease;
      }
    }

    .reject-img {

      &:hover {
        cursor: pointer;
        -webkit-filter: brightness(80%);
        transition: all 100ms ease;
      }
    }

  }
}
</style>