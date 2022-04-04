<template>
  <div class="profile">
    <Header/>
    <Navbar current="profile"/>
    <div class="content">
      <div class="profile-header">
        <div class="profile-picture-container">
          <img class="profile-picture" :src="require(`@/assets/${userdata.profilePicture}.png`)" alt="profile picture"/>
        </div>
        <div class="name-container">
          <p>{{user.firstName}} {{user.lastName}}</p>
        </div>
        <button class="header-edit-btn" @click="editAbout">Edit</button>
      </div>
      <div class="profile-content">
        <div class="about-container">
          <h2>About</h2>
          <p>Email: <span>{{user.email}}</span></p>
          <p>Date of birth: <span>{{userdata.birthDate}}</span></p>
          <p>Gender: <span>{{userdata.gender === '1' ? "Male" : "Female"}}</span></p>
          <p>Phone number: <span>{{userdata.phoneNumber}}</span></p>
          <p>Workplace/school: <span>{{userdata.profession}}</span></p>
          <button class="about-edit-btn" @click="editHeader">Edit</button>
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
        firstName: 'Teszt',
        lastName: 'Elek',
        email: 'valaki@gmail.com',
      },
      userdata: {
        birthDate: '1969.04.20',
        gender: '1',
        phoneNumber: '+36204875222',
        profession: 'Szegedi Tudományegyetem Programtervező Informatika Kar ',
        profilePicture: 'placeholder',
      },

      newPost: {
        userID: '',
        content: '',
        image: '',
      }
    }
  },

  methods: {
    editHeader(){

    },

    editAbout(){

    },
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

        .about-edit-btn {
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
          margin-top: 5%;
          padding-left: 9%;
          padding-right: 9%;

          &:hover {
            cursor: pointer;
            -webkit-filter: brightness(90%);
            transition: all 100ms ease;
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