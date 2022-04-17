<template>
  <div @click="chooseFriend" class="friend" :class="currentFriendId.toString() === friend.ID.toString() ? 'current' : ''">
    <div class="profile-picture-container">
      <img class="pfp" :src="friend.PROFILEPICTURE || require('@/assets/pfp-default.png')" alt="profile picture"/>
    </div>
    <p class="name">{{friend.FIRSTNAME}} {{friend.LASTNAME}}</p>
  </div>
</template>

<script>
export default {
  name: "Friend",
  props: {
    friend: Object,
    currentFriendId: Number,
  },
  methods: {
    chooseFriend(){
      this.$emit("chooseFriend", this.friend);
    }
  }
}
</script>

<style lang="scss" scoped>
.friend {
  border-top: solid 1px var(--ouline-color);
  border-bottom: solid 1px var(--ouline-color);
  padding: 1% 3%;
  display: flex;
  flex-direction: row;
  align-items: center;
  width: 90%;
  margin-left: auto;
  margin-right: auto;
  margin-bottom: -1px;
  text-decoration: none;

  &:hover {
    background-color: var(--lighter-bg-color);
    cursor: pointer;
  }

  .profile-picture-container{
    width: 30px;
    height: 30px;
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
      max-width: 30px;
      max-height: 30px;
    }
  }

  .name {
    font-size: 16px;
    color: var(--font-color);
  }

  &.current {
    background-color: var(--light-bg-color);
  }

}
</style>