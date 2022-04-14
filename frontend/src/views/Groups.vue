<template>
  <div class="groups">
    <Header/>
    <Navbar current="groups"/>
    <div class="content">
      <div class="my_groups">
        <div class="my_groups-header">
          <h2>My groups</h2>
          <button @click="createGroup" class="create-group-btn">+ Create group</button>
        </div>
        <Group v-for="group in groups" :group="group"></Group>
      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import Group from "@/components/Group";

export default {
  name: "Groups",
  components: {Footer, Navbar, Header, Group},
  data(){
    return {
      groups: [],
    }
  },
  methods: {
    async initGroups(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/group/getall/${this.$cookies.get('UserID')}`);
        this.groups = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },
    createGroup(){
      this.$router.replace({name: "AddGroup"});
    }
  },

  mounted() {
    this.initGroups();
  }
}
</script>

<style lang="scss" scoped>

  .groups{
    padding-top: 8vh;
    padding-bottom: 10vh;

    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;

      h2{
        display: inline-block;
        margin-right: 2%;
        margin-bottom: 3%;
      }

      .create-group-btn{
        font-size: 16px;
        line-height: 24px;
        background-color: var(--accent-color);
        color: var(--font-color);
        border: none;
        border-radius: 20px;
        font-weight: bold;
        font-family: "Cambria", sans-serif;
        padding-left: 1%;
        padding-right: 1%;

        &:hover {
          cursor: pointer;
          -webkit-filter: brightness(90%);
          transition: all 100ms ease;
        }
      }

      .my_groups{
        background-color: var(--light-bg-color);
        padding: 2% 5% 3% 5%;
        margin-bottom: 2%;
      }
    }
  }

</style>