<template>
  <div class="photos">
    <Header/>
    <Navbar current="photos"/>
    <div class="content">
      <div class="my-albums">
        <div class="my-albums-header">
          <h2>My albums</h2>
          <button @click="createAlbumOpen = true" v-if="!createAlbumOpen" class="create-album-button">+ Create album</button>
          <div v-if="createAlbumOpen" class="create-albums-input">
            <input id="new-album-name" type="text" v-model="newAlbumName" v-on:keydown.enter.exact.prevent="createAlbum" placeholder="Album name">
            <button @click="createAlbum" class="send-album-name">Create</button>
          </div>
        </div>
        <div class="albums-container" >
          <router-link class="album-container" v-for="(album, index) in albums" :key="index" :to="{name: 'AlbumPage', params: {albumID: album.ID}}">
            <div class="cover-container">
              <img class="cover" :src="require('@/assets/default-gallery-cover.png')" alt="album cover"/>
            </div>
            <p class="album-name">{{album.NAME}}</p>
          </router-link>
        </div>
      </div>
      <div class="my-photos">
        <h2>My photos</h2>
        <div class="photos-container">
          <div v-for="(photo, index) in photos" :key="index" class="photo-container">
            <img @click="deleteImg(photo.ID)" class="delete-img" src="@/assets/delete.png" alt="delete"/>
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
  name: "Photos",
  components: {Footer, Navbar, Header},
  data() {
    return {
      photos: [],
      albums: [],
      newAlbumName: '',
      createAlbumOpen: false,
    }
  },
  methods: {
    async initPhotos(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/img/getall/${this.$cookies.get('UserID')}`);
        this.photos = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },
    async initAlbums(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/album/getall/${this.$cookies.get('UserID')}`);
        this.albums = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async deleteImg(photoID) {
      try {
        await this.axios.get(`${this.$root.requestURL}/img/delete/${photoID}`);
      } catch (err) {
        console.log(err.response.data);
      }
      await new Promise(r => setTimeout(r, 300));
      await this.initPhotos();
    },

    async createAlbum(){
      if(this.newAlbumName.trim() !== '') {
        try {
          await this.axios.post(`${this.$root.requestURL}/album/create`, {
            name: this.newAlbumName,
          })
        } catch (err) {
          console.log(err.response.data);
        }
        await this.initAlbums();
        this.createAlbumOpen = false;
        this.newAlbumName = '';
      } else {
        this.createAlbumOpen = false;
      }
    },
  },

  mounted() {
    this.initAlbums();
    this.initPhotos();
  }
}
</script>

<style lang="scss" scoped>

  .photos{
    padding-top: 8vh;
    padding-bottom: 10vh;
    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;

      .my-albums, .my-photos {
        background-color: var(--light-bg-color);
        padding: 2% 5% 3% 5%;
        margin-bottom: 2%;
      }
      .my-photos {

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

            .delete-img {
              position: absolute;
              top: 20px;
              right: 20px;
              width: 17%;
              display: none;
            }

            &:hover {
              -webkit-filter: brightness(90%);
              transition: all 100ms ease;

              .delete-img {
                display: block;

                &:hover {
                  cursor: pointer;
                }
              }
            }
          }
          &::after{
            content: "";
            flex: auto;
          }

        }
      }
      .my-albums {

        .my-albums-header {
          display: flex;
          flex-direction: row;
          align-content: flex-start;
          align-items: center;

          h2{
            display: inline-block;
            margin-right: 2%;
          }

          .create-album-button{
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
          .create-albums-input{
            display: flex;
            flex-direction: row;
            align-content: flex-start;
            align-items: center;

            #new-album-name {
              margin-right: 4%;
              font-size: 16px;
              line-height: 24px;
            }

            .send-album-name{
              font-size: 16px;
              line-height: 24px;
              background-color: var(--accent-color);
              color: var(--font-color);
              border: none;
              border-radius: 20px;
              font-weight: bold;
              font-family: "Cambria", sans-serif;
              padding-left: 4%;
              padding-right: 4%;

              &:hover {
                cursor: pointer;
                -webkit-filter: brightness(85%);
                transition: all 100ms ease;
              }
            }
          }
        }

        .albums-container {
          width: 100%;
          display: grid;
          grid-template-columns: repeat(auto-fill, 230px);
          justify-content: space-evenly;
          grid-gap: 10px;

          .album-container {
            width: 230px;
            height: 260px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;

            .cover-container{
              background-color: var(--ouline-color);
              display: flex;
              flex-direction: column;
              align-items: center;
              justify-content: center;
              overflow: hidden;
              .cover {
                max-width: 235px;
                max-height: 235px;
              }
            }
            .album-name {
              line-height: 20px;
              margin: 10px 0;
              color: var(--font-color);

            }
            &:hover {
              cursor: pointer;
              -webkit-filter: brightness(80%);
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