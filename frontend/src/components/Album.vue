<template>
  <router-link class="album-container"  :to="{name: 'AlbumPage', params: {albumID: album.ID}}">
    <div class="cover-container">
      <img class="cover" :src=" cover || require('@/assets/default-gallery-cover.png')" alt="album cover"/>
    </div>
    <p class="album-name">{{album.NAME}} ({{album.IMG_COUNT}})</p>
  </router-link>
</template>

<script>
export default {
  name: "Album",
  props: {
    album: Object,
  },
  data(){
    return {
      cover: '',
    }
  },
  methods: {
    async initAlbumCover(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/img/latest/${this.album.ID}`);
        if(response.data.result[0] !== undefined && response.data.result[0] !== null){
          this.cover =  response.data.result[0].CONTENT;
        } else {
          this.cover = null;
        }
      } catch (err) {
        console.log(err.response.data);
      }
    },
  },
  mounted() {
    this.initAlbumCover();
  }
}
</script>

<style lang="scss" scoped>
.album-container {
  width: 230px;
  height: 260px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-decoration: none;

  .cover-container{
    background-color: var(--ouline-color);
    width: 230px;
    height: 230px;
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

</style>