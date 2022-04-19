<template>
  <div class="search">
    <Header/>
    <Navbar current="search"/>
    <div class="content">
      <div class="search-bar">
        <input id="search-input" type="text" v-model="searchKey">
        <button @click="search" class="search-button">Search</button>
      </div>
      <div v-if="searched" class="users">
        <h2>Users found</h2>
        <UserProfile class="user-found" v-for="(userFound, index) in usersFound" :key="index" :user="userFound"/>
      </div>
      <div v-if="searched" class="groups">
        <h2>Groups found</h2>
        <Group class="group-found" v-for="(groupFound, index) in groupsFound" :key="index" :group="groupFound"/>
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
      searchKey: '',
      searched : false,
    }
  },
  methods: {
    async initUsersFound(){

    },

    async initGroupsFound(){

    },

    search() {
      this.initUsersFound();
      this.initGroupsFound();
      this.searched = true;
    },
  },
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

        .search-button {
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