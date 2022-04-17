<template>
  <div class="friends">
    <Header/>
    <Navbar current="friends"/>
    <div class="content">
      <div class="friend-requests">
        <h2>Friend requests</h2>
        <FriendRequest :key="index" v-for="(friendRequest, index) in friendRequests" :friend-request="friendRequest"/>
      </div>
      <div class="my-friends">
        <h2>My friends</h2>
        <Friend :key="index" v-for="(friend, index) in friends" :friend="friend"/>
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
import Friend from "@/components/Friend";

export default {
  name: "Friends",
  components: {
    Friend,
    FriendRequest,
    Header,
    Navbar,
    Footer,
  },
   data(){
    return {
      friendRequests: [
        {
          ID: 1114,
          FIRSTNAME: "Gordon",
          LASTNAME: "Niro",
          PROFILEPICTURE: ""
        },
        {
          ID: 1129,
          FIRSTNAME: "Abdul-Aziz",
          LASTNAME: "Blazey",
          PROFILEPICTURE: ""
        },
        {
          ID: 1125,
          FIRSTNAME: "Jaxson",
          LASTNAME: "Marios",
          PROFILEPICTURE: ""
        },
        {
          ID: 1000,
          FIRSTNAME: "Admin",
          LASTNAME: "User",
          PROFILEPICTURE: ""
        },
      ],
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
    }
  },

  mounted() {
    this.initFriends();
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