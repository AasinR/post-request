<template>
  <router-link :to="{name: 'Profile', params: {userID: activeMembers ? user.ID : user.USERID}}" class="friend">
    <div class="profile-picture-container" :class="ownerId === (activeMembers ? user.ID : user.USERID) ? 'owner' : ''">
      <img class="pfp" :src="pfp || require('@/assets/pfp-default.png')" alt="profile picture"/>
    </div>
    <p class="name">{{ user.FIRSTNAME }} {{ user.LASTNAME }}</p>
  </router-link>
</template>

<script>
export default {
  name: "Group-Member-Profile",
  props: {
    user: Object,
    ownerId: Number | String,
    activeMembers: Boolean,
  },
  data(){
    return {
      pfp: this.user.PROFILEPICTURE,
    }
  },
  methods: {
    async initPfp(){
      if(this.activeMembers){
        try {
          const response = await this.axios.get(`${this.$root.requestURL}/user/data/get/${this.user.ID}`);
          this.pfp = response.data.result.PROFILEPICTURE;
        } catch (err) {
        }
      }
    },
  },
  mounted() {
    this.initPfp();
  }
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

    &.owner {
      border: solid 2px var(--accent-color);
    }
  }

  .name {
    font-size: 16px;
    color: var(--font-color);
  }

}

</style>