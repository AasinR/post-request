<template>
  <div class="search">
    <Header/>
    <Navbar current="search"/>
    <div class="content">
      <div class="search-bar">
        <input id="search-input" type="text" v-model="searchKey" v-on:keydown.enter.exact.prevent="search">
        <button @click="search" class="search-button">Search</button>
        <button @click="showPopularGroups" class="popular-groups-button">Show popular groups</button>
      </div>
      <div v-if="searched" class="users">
        <h2>Users found</h2>
        <UserProfile class="user-found" v-for="(userFound, index) in usersFound" :key="index" :user="userFound" v-if="userMatch(userFound)"/>
      </div>
      <div v-if="searched" class="groups">
        <h2>Groups found</h2>
        <Group class="group-found" v-for="(groupFound, index) in groupsFound" :key="index" :group="groupFound" search v-if="groupMatch(groupFound)"/>
      </div>
      <div v-if="showPopularOn && !searched" class="groups">
        <h2>Popular groups</h2>
        <Group class="group-found" v-for="(popularGroup, index) in popularGroups" :key="index" :group="popularGroup" search/>
      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import UserProfile from "@/components/User-Profile";
import Group from "@/components/Group";

export default {
  name: "Search",
  components: {Footer, Navbar, Header, UserProfile, Group},
  data() {
    return {
      usersFound: [],
      groupsFound: [],
      popularGroups: [],
      searchKey: '',
      searched : false,
      showPopularOn: false,
    }
  },
  methods: {
    async initUsersFound(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/user/all`);
        this.usersFound = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async initGroupsFound(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/group/all`);
        this.groupsFound = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async initPopularGroups(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/group/popular`);
        this.popularGroups = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    search() {
      this.showPopularOn = false;
      this.searched = true;
    },

    userMatch(user){
      let name = user.FIRSTNAME + " " + user.LASTNAME;
      return (name.toLowerCase()).includes(this.searchKey.toLowerCase());

    },

    groupMatch(group){
      return (group.NAME.toLowerCase()).includes(this.searchKey.toLowerCase());

    },

    showPopularGroups(){
      this.searched = false;
      this.showPopularOn = true;

      this.initPopularGroups();
    },
  },
  mounted() {
    this.initUsersFound();
    this.initGroupsFound();
  }
}
</script>

<style lang="scss" scoped>

  .search{
    padding-top: 8vh;
    padding-bottom: 10vh;
    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;

      .search-bar {
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 2%;

        #search-input {
          font-size: 20px;
          border-radius: 20px;
          padding: 0.5% 1%;
          width: 40%;
          margin-right: 1%;
        }

        .search-button, .popular-groups-button {
          font-size: 20px;
          line-height: 32px;
          background-color: var(--accent-color);
          color: var(--font-color);
          border: none;
          border-radius: 20px;
          font-weight: bold;
          font-family: "Cambria", sans-serif;
          padding-left: 2%;
          padding-right: 2%;
          margin-right: 1%;

          &:hover {
            cursor: pointer;
            -webkit-filter: brightness(85%);
            transition: all 100ms ease;
          }
        }
      }

      .users, .groups {
        background-color: var(--light-bg-color);
        padding: 2% 5% 3% 5%;
        margin-bottom: 2%;
      }

    }
}

</style>