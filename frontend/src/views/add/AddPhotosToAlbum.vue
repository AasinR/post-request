<template>
  <div class="add-photos">
    <Header/>
    <Navbar current="photos"/>
    <div class="content">
      <div class="my-photos">
        <button class="add-button" @click="addSelected">Add selected</button>
        <div class="photos-container">
          <label v-for="(photo, index) in photos" :key="index" class="photo-container">
            <img class="photo" :src="photo.CONTENT" alt="photo"/>
            <input class="checkbox"  type="checkbox" v-model="newPhotos" :value="photo.ID"/>
            <span class="checkmark"></span>
          </label>
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
  name: "AddPhotosToAlbum",
  components: {Footer, Navbar, Header},
  props: {
    albumID: Number | String,
  },
  data(){
    return {
      photos: [],
      newPhotos: [],
    }
  },
  methods: {
    async initPhotos() {
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/img/getall/${this.$cookies.get('UserID')}`);
        this.photos = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async addSelected(){
      for(const newPhoto of this.newPhotos){
        try {
          await this.axios.post(`${this.$root.requestURL}/img/add/${newPhoto}`, {
            albumId: this.albumID,
          })
        } catch (err) {
          console.log(err.response.data);
        }
      }
      await this.$router.replace({name: 'AlbumPage', params: {albumID: this.albumID}});
    },
  },
  mounted() {
    this.initPhotos();
  }
}
</script>

<style lang="scss" scoped>

.add-photos{
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

      .add-button{
        display: block;
        margin: 2% auto 3%;
        font-size: 24px;
        line-height: 32px;
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
          -webkit-user-select: none;
          -moz-user-select: none;
          -ms-user-select: none;
          user-select: none;

          .photo {
            max-width: 235px;
            max-height: 235px;

          }

          input {
            position: absolute;
            opacity: 0;
            cursor: pointer;
            height: 0;
            width: 0;
          }

          input:checked ~ .checkmark {
            background-color: var(--accent-color);
          }

          input:checked ~ .checkmark:after {
            display: block;
          }

          .checkmark {
            position: absolute;
            top: 10px;
            left: 10px;
            height: 25px;
            width: 25px;
            background-color: white;
            border: solid 2px var(--accent-color);
            border-radius: 20px;
          }

          .checkmark:after {
            content: "";
            position: absolute;
            display: none;
          }

          .checkmark:after {
            left: 9px;
            top: 5px;
            width: 5px;
            height: 10px;
            border: solid var(--ouline-color);
            border-width: 0 3px 3px 0;
            -webkit-transform: rotate(45deg);
            -ms-transform: rotate(45deg);
            transform: rotate(45deg);
          }


          &:hover {
            -webkit-filter: brightness(90%);
            transition: all 100ms ease;
            cursor: pointer;
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