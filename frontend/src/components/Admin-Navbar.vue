<template>
  <div class="admin-navbar">
    <div class="navbar-link">
      <router-link :class="current === 'users' ? 'current' : ''" :to="{name: 'AdminUsers'}">Users</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'posts' ? 'current' : ''" :to="{name: 'AdminPosts'}">Posts</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'messages' ? 'current' : ''" :to="{name: 'AdminMessages'}">Messages</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'groups' ? 'current' : ''" :to="{name: 'AdminGroups'}">Groups</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'comments' ? 'current' : ''" :to="{name: 'AdminComments'}">Comments</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'albums' ? 'current' : ''" :to="{name: 'AdminAlbums'}">Albums</router-link>
    </div>
  </div>
</template>

<script>
export default {
  name: "Admin-Navbar",
  props: {
    current: String,
  }
}
</script>

<style scoped lang="scss">
.admin-navbar{
  margin-bottom: 2%;
  margin-right: 10%;
  .navbar-link {
    margin-bottom: 10%;
    a {
      color: white;
      font-size: 1.5rem;
      text-decoration: none;

      &:hover{
        color: var(--accent-color);
      }
    }

    .current {
      color: var(--accent-color)
    }

    margin-left: 2%;
  }
}
</style>