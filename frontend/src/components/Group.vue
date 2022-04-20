<template>
  <div class="group">
    <router-link :to="{name: 'GroupPage', params: {groupID: group.GROUP.ID}}" class="link">
      <div class="logo-container">
        <img class="logo" :src="group.GROUP.LOGO || require('@/assets/pfp-default.png')" alt="group logo"/>
      </div>
      <p class="name">{{group.GROUP.NAME}}</p>
    </router-link>
    <button class="leave-btn" @click="leaveGroup">Leave group</button>
  </div>
</template>

<script>
export default {
  name: "Friend",
  props: {
    group: Object,
  },
  methods: {
    leaveGroup(){

    },
  },
}
</script>

<style lang="scss" scoped>
.group {
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
    .logo-container{
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

      .logo {
        max-width: 40px;
        max-height: 40px;
      }
    }

    .name {
      font-size: 20px;
      color: var(--font-color);
    }

    &:hover {
      cursor: pointer;
    }
  }


  .leave-btn {
    display: block;
    font-size: 16px;
    line-height: 24px;
    background-color: var(--accent-color);
    color: var(--font-color);
    border: none;
    border-radius: 20px;
    font-weight: bold;
    font-family: "Cambria", sans-serif;
    align-self: center;
    margin-left: auto;
    padding-left: 2%;
    padding-right: 2%;

    &:hover {
      cursor: pointer;
      -webkit-filter: brightness(90%);
      transition: all 100ms ease;
    }
  }

}
</style>