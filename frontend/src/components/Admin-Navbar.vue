<template>
  <div class="admin-navbar">
    <h1 id="data-tables-head">Data tables</h1>
    <div class="navbar-link">
      <router-link :class="current === 'users' ? 'current' : ''" :to="{name: 'AdminUsers'}">Users</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'userdata' ? 'current' : ''" :to="{name: 'AdminUserData'}">User Data</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'public_posts' ? 'current' : ''" :to="{name: 'AdminPublicPosts'}">Public Posts</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'group_posts' ? 'current' : ''" :to="{name: 'AdminGroupPosts'}">Group Posts</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'messages' ? 'current' : ''" :to="{name: 'AdminMessages'}">Messages</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'groups' ? 'current' : ''" :to="{name: 'AdminGroups'}">Groups</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'public_comments' ? 'current' : ''" :to="{name: 'AdminPublicComments'}">Public Comments</router-link>
    </div>
    <div class="navbar-link">
    <router-link :class="current === 'group_comments' ? 'current' : ''" :to="{name: 'AdminGroupComments'}">Group Comments</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'pictures' ? 'current' : ''" :to="{name: 'AdminPictures'}">Pictures</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'albums' ? 'current' : ''" :to="{name: 'AdminAlbums'}">Albums</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'friends' ? 'current' : ''" :to="{name: 'AdminFriends'}">Friends</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'friend_requests' ? 'current' : ''" :to="{name: 'AdminFriendRequests'}">Friend Requests</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'group_members' ? 'current' : ''" :to="{name: 'AdminGroupMembers'}">Group Members</router-link>
    </div>
    <h1 id="statistics-head">Statistics</h1>
    <div class="navbar-link">
      <router-link :class="current === 'activity' ? 'current' : ''" :to="{name: 'AdminUserActivity'}">User activity</router-link>
    </div>
    <div class="navbar-link">
      <router-link :class="current === 'longconvos' ? 'current' : ''" :to="{name: 'AdminLongerConvos'}">Longer convos</router-link>
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
  margin-right: 3%;
  width: 20vh;

  #data-tables-head, #statistics-head{
    font-size: 22px;
    text-decoration: underline;

  }

  .navbar-link {
    margin-bottom: 10%;
    a {
      color: white;
      font-size: 1rem;
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