<template>
<router-link :to="{name: 'Profile', params: {userID: user.ID}}" class="friend">
  <div class="profile-picture-container">
    <img class="pfp" :src="user.PROFILEPICTURE || require('@/assets/pfp-default.png')" alt="profile picture"/>
  </div>
  <p class="name">{{ user.FIRSTNAME }} {{ user.LASTNAME }}</p>
</router-link>
</template>

<script>
export default {
  name: "UserProfile",
  props: {
    user: Object,
  },
}
</script>

<style lang="scss" scoped>
.friend {
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
  text-decoration: none;

  &:hover {
    background-color: var(--lighter-bg-color);
    cursor: pointer;
  }

  .profile-picture-container{
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

  .name {
    font-size: 20px;
    color: var(--font-color);
  }

}
</style>