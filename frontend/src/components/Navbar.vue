<template>
  <div class="navbar">
    <div class="navbar-link">
      <router-link :class="current === 'profile' ? 'current' : ''" :to="{name: 'Profile'}">Profile</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'friends' ? 'current' : ''" :to="{name: 'Friends'}">Friends</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'groups' ? 'current' : ''" :to="{name: 'Groups'}">Groups</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'messages' ? 'current' : ''" :to="{name: 'Messages'}">Messages</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'photos' ? 'current' : ''" :to="{name: 'Photos'}">Photos</router-link>
    </div>
    <div v-if=permission class="navbar-link">
      <router-link :class="current === 'admin' ? 'current' : ''" :to="{name: 'AdminUsers'}">Admin</router-link>
    </div>
    <div class="navbar-link right-align">
      <router-link :class="current === 'search' ? 'current' : ''" :to="{name: 'Search'}">Search</router-link>
    </div>
    <div class="navbar-link ">
      <router-link @click.native="logout" :to="{name: 'Login'}">Log out <img class="logout-icon" src="@/assets/logout.png" alt="logout.png"></router-link> <!--TODO-->
    </div>
  </div>
</template>

<script>
export default {
  name: "Navbar",
  props: {
    current: String,
  },
  data() {
    return {
      permission: 0,
    }
  },
  methods: {
    async logout() {
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/logout`);
        this.$cookies.remove("UserID");
        this.$cookies.remove("sid");

        //console.log(response.data);
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async initPermission() {
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/user/get/${this.$cookies.get("UserID")}`);
        this.permission = response.data.result.PERMISSION;
        //console.log(this.permission);
      } catch (err) {
        console.log(err.response.data);
      }
    },
  },
  mounted(){
    this.initPermission();
  }
}
</script>

<style lang="scss" scoped>

  .navbar {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
    margin-left: auto;
    margin-right: auto;
    margin-bottom: 2%;
    width: 70%;
    border-top: solid 2px;
    border-bottom: solid 2px;
    border-color: var(--ouline-color);
    padding: 0 1%;

    .navbar-link {
      display: flex;
      flex-direction: row;
      align-items: center;
      width: 8rem;
      height: 4rem;

      a {
        display: block;
        width: 100%;
        height: 100%;
        font-size: 1.2rem;
        color: var(--font-color);
        text-decoration: none;
        text-align: center;
        line-height: 4rem;
      }

      .current {
        background-color: var(--light-bg-color);
        border-left: solid 1px;
        border-right: solid 1px;
        border-color: var(--ouline-color);
      }

      .logout-icon {
        display: inline-block;
        width: 1.5rem;
        margin-left: 5%;
        margin-bottom: -2%;
      }
    }

    .navbar-link:hover {
      background-color: var(--light-bg-color);
    }

    .right-align {
      margin-left: auto;
    }

  }

</style>