<template>
  <div class="profile">
    <Header/>
    <Navbar current="profile"/>
    <div class="content">
      <div class="profile-header">
        <div class="profile-picture-container">
          <img class="profile-picture" src="@/assets/placeholder.png" alt="profile picture"/>
        </div>
        <div class="name-container">
          <p>{{user.firstName}} {{user.lastName}}</p>
        </div>
        <button class="header-edit-btn" @click="editProfile">Edit profile</button>
      </div>
      <div class="profile-content">
        <div class="about-container">
          <h2>About</h2>
          <p>Email: <span>{{user.email}}</span></p>
          <p>Date of birth: <span>{{userdata.birthDate}}</span></p>
          <p>Gender: <span>{{userdata.gender}}</span></p>
          <p>Phone number: <span>{{userdata.phoneNumber}}</span></p>
          <p>Workplace/school: <span>{{userdata.profession}}</span></p>
        </div>
        <div class="posts-container">
          <div class="new-post">
            <h2>Make a new post!</h2>
          </div>
          <div class="posts">
            <h2>Posts</h2>
          </div>
        </div>
      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";

export default {
  name: "Profile",
  components: {
    Footer,
    Navbar,
    Header,
  },

  data() {
    return {
      user: {
        firstName: '',
        lastName: '',
        email: '',
      },
      userdata: {
        birthDate: '',
        gender: '',
        phoneNumber: '',
        profession: '',
        profilePicture: '',
      },

      newPost: {
        userID: '',
        content: '',
        image: '',
      }
    }
  },

  methods: {
    editProfile(){

    },

    initProfile(){
      this.initUser();
      this.initUserData();
    },

    async initUser(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/user/get/${this.$cookies.get("UserID")}`);
        this.user.firstName = response.data.result.FIRSTNAME;
        this.user.lastName = response.data.result.LASTNAME;
        this.user.email = response.data.result.EMAIL;
      } catch (err) {
        console.log(err.response.data);
      }

    },

    async initUserData(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/user/data/get/${this.$cookies.get("UserID")}`);
        this.userdata.birthDate = response.data.result.BIRTHDATE;
        this.userdata.gender = response.data.result.GENDER;
        this.userdata.phoneNumber = response.data.result.PHONENUMBER;
        this.userdata.profession = response.data.result.PROFESSION;
        this.userdata.profilePicture = response.data.result.PROFILEPICTURE;
      } catch (err) {
        console.log(err.response.data);
      }
    }
  },

  mounted() {
    this.initProfile();
  }
}
</script>

<style lang="scss" scoped>

  .profile{
    padding-top: 8vh;
    padding-bottom: 10vh;
    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;
    }
    .profile-header{
      background-color: var(--light-bg-color);
      padding: 2% 5%;
      display: flex;
      flex-direction: row;
      align-items: flex-start;
      margin-bottom: 2%;

      .profile-picture-container{
        width: 150px;
        height: 150px;
        background-color: var(--ouline-color);
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;

        border-radius: 80px;
        border: solid 4px var(--ouline-color);

        overflow: hidden;

        .profile-picture {
          max-width: 150px;
          max-height: 150px;
        }
      }

      .name-container {
        margin-left: 3%;
        width: fit-content;
        margin-top: 3%;

        p {
          font-size: 30px;
          font-family: Cambria,serif;
          font-weight: bold;
          margin: 0;
        }
      }

      .header-edit-btn{
        display: block;
        font-size: 20px;
        line-height: 30px;
        background-color: var(--accent-color);
        color: var(--font-color);
        border: none;
        border-radius: 20px;
        font-weight: bold;
        font-family: "Cambria", sans-serif;
        align-self: flex-end;
        margin-left: auto;
        padding-left: 3%;
        padding-right: 3%;

        &:hover {
          cursor: pointer;
          -webkit-filter: brightness(90%);
          transition: all 100ms ease;
        }
      }

    }

    .profile-content {
      display: flex;
      flex-direction: row;
      align-items: flex-start;

      .about-container {
        background-color: var(--light-bg-color);
        width: 30%;
        padding: 2% 4%;
        line-height: 20px;
        display: flex;
        flex-direction: column;
        align-items: flex-start;


        p {
          margin-left: 7%;

          span {
            font-style: italic;
          }
        }

      }

      .posts-container {
        width: 70%;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        margin-left: 2%;


        .new-post, .posts {
          width: 92%;
          background-color: var(--light-bg-color);
          margin-bottom: 3%;
          padding: 4% 4%;

          h2 {
            margin: 0;
          }
        }

      }
    }
  }

</style>