<template>
  <div class="friends">
    <Header/>
    <Navbar current="friends"/>
    <div class="content">
      <div class="friend-requests">
        <h2>Friend requests</h2>
        <FriendRequest :key="index" v-for="(friendRequest, index) in friendRequests" :friend-request="friendRequest" @accept="initPage" @reject="initFriendRequests"/>
      </div>
      <div class="my-friends">
        <h2>My friends</h2>
        <UserProfile :key="index" v-for="(friend, index) in friends" :user="friend"/>
      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import FriendRequest from "@/components/Friend-Request";
import UserProfile from "@/components/User-Profile";

export default {
  name: "Friends",
  components: {
    UserProfile,
    FriendRequest,
    Header,
    Navbar,
    Footer,
  },
   data(){
    return {
      friendRequests: [],
      friends: [],
    }
   },
  methods: {
    async initFriends(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/friend/getall/${this.$cookies.get('UserID')}`);
        this.friends = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async initFriendRequests(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/friend/request/getall/${this.$cookies.get('UserID')}`);
        this.friendRequests = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    initPage(){
      this.initFriendRequests();
      this.initFriends();
    }
  },

  mounted() {
    this.initPage();
  }
}
</script>

<style lang="scss" scoped>

  .friends{
    padding-top: 8vh;
    padding-bottom: 10vh;

    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;

      .friend-requests, .my-friends {
        background-color: var(--light-bg-color);
        padding: 2% 5% 3% 5%;
        margin-bottom: 2%;
      }
    }
  }

</style>