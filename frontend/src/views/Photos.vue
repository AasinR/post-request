<template>
  <div class="photos">
    <Header/>
    <Navbar current="photos"/>
    <div class="content">
      <div class="my-albums">
        <h2>My albums</h2>
      </div>
      <div class="my-photos">
        <h2>My photos</h2>
        <div class="photos-container-with-delete">
          <div class="photos-container">
            <div v-for="(photo, index) in photos" :key="index" class="photo-container">
              <img @click="deleteImg(photo.ID)" class="delete-img" src="@/assets/delete.png" alt="delete"/>
              <img class="photo" :src="photo.CONTENT" alt="photo"/>
            </div>
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
      await this.initPhotos();
    }
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
    }
  }

</style>