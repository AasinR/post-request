<template>
  <div class="album-page">
    <Header/>
    <Navbar current="photos"/>
    <div class="content">
      <div v-if="loadedData" class="album">
        <div class="album-header">
          <input @blur="editAlbumName" v-if="editNameOpen" type="text" v-model="albumNewName" class="name-input">
          <h2 v-if="!editNameOpen" class="album-name">{{albumData.name}}</h2>
          <button @click="goToAddPhotos" class="add-photo-btn">+ Add photos to album</button>
          <img @click="showNameEdit" class="edit-icon" src="@/assets/edit.png" alt="edit"/>
          <img @click="deleteAlbum" class="delete-icon" src="@/assets/delete.png" alt="delete"/>
        </div>
        <div v-if="noPictures" class="no-pictures">
          <p>No photos in the album</p>
        </div>
        <div v-if="!noPictures" class="photos-container">
          <div v-for="(photo, index) in albumPictures" :key="index" class="photo-container">
            <img class="photo" :src="photo.CONTENT" alt="photo"/>
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
  name: "AlbumPage",
  components: {Footer, Navbar, Header},
  props: {
    albumID: Number | String,
  },
  data(){
    return {
      albumData: {
        id: '',
        name: '',
        userID: '',
      },
      albumPictures: [],
      noPictures: true,
      loadedData: false,
      albumNewName: '',
      editNameOpen: false,
    }
  },
  methods: {
    async initAlbumData() {
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/album/get/${this.albumID}`);
        this.albumData.id = response.data.result.ID;
        this.albumData.name = response.data.result.NAME;
        this.albumNewName = response.data.result.NAME;
        this.albumData.userID = response.data.result.USERID;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async initAlbumPictures(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/img/getalbum/${this.albumID}`);
        this.albumPictures = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }

      this.noPictures = this.albumPictures[0] === undefined || this.albumPictures[0] === null;
      this.loadedData = true;
    },

    async editAlbumName(){
      if(this.albumNewName.trim() !== '') {
        try {
          await this.axios.post(`${this.$root.requestURL}/album/update/${this.albumID}`, {
            name: this.albumNewName,
          })
        } catch (err) {
          console.log(err.response.data);
        }
        await this.initAlbumData();
      } else {
        this.albumNewName = this.albumData.name;
      }
      this.editNameOpen = false;
    },

    async deleteAlbum(){
      try {
        await this.axios.get(`${this.$root.requestURL}/album/delete/${this.albumID}`);
      } catch (err) {
        console.log(err.response.data);
      }
      await this.$router.replace({name: "Photos"})
    },

    goToAddPhotos(){
      this.$router.replace({name: 'AddPhotosToAlbum', params: {albumID: this.albumID}});
    },

    showNameEdit(){
      this.editNameOpen =  !this.editNameOpen;
    }
  },
  mounted() {
    this.initAlbumData();
    this.initAlbumPictures();
  }
}
</script>

<style lang="scss" scoped>

.album-page{
    padding-top: 8vh;
    padding-bottom: 10vh;

    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;

      .album {
        background-color: var(--light-bg-color);
        padding: 2% 5% 3% 5%;
        margin-bottom: 2%;

        .album-header {
          width: 100%;
          display: flex;
          flex-direction: row;
          align-items: center;
          justify-content: left;

          .album-name{
            margin-right: 2%;

            h2 {
              margin: 0;
            }
          }
          .name-input {
            margin-right: 2%;
            margin-top: 2%;
            margin-bottom: 2%;
            font-size: 20px;
            border-radius: 20px;
            padding-left: 1%;
            padding-right: 1%;
          }

          .add-photo-btn {
            font-size: 16px;
            line-height: 24px;
            background-color: var(--accent-color);
            color: var(--font-color);
            border: none;
            border-radius: 20px;
            font-weight: bold;
            font-family: "Cambria", sans-serif;
            padding-left: 2%;
            padding-right: 2%;

            &:hover {
              cursor: pointer;
              -webkit-filter: brightness(85%);
              transition: all 100ms ease;
            }
          }

          .delete-icon {
            width: 30px;

            &:hover {
              cursor: pointer;
            }
          }

          .edit-icon{
            margin-left: auto;
            margin-right: 1%;
            width: 35px;

            &:hover {
              cursor: pointer;
            }
          }

        }

        .no-pictures {
          color: #89999d;
          display: flex;
          flex-direction: row;
          align-items: center;
          justify-content: center;
          font-size: 20px;
        }

        .photos-container{
          width: 100%;
          display: grid;
          grid-template-columns: repeat(auto-fill, 230px);
          justify-content: space-evenly;
          grid-gap: 10px;

          .photo-container{
            position: relative;
            width: 230px;
            height: 230px;
            background-color: var(--ouline-color);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            margin-bottom: 20px;

            .photo {
              max-width: 235px;
              max-height: 235px;

            }

            &:hover {
              -webkit-filter: brightness(90%);
              transition: all 100ms ease;
            }
          }
          &::after{
            content: "";
            flex: auto;
          }

        }
      }
    }
}

</style>