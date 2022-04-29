<template>
  <div class="edit-group">
    <Header/>
    <Navbar current="groups"/>
    <div class="content">
      <div class="input-fields">
        <button id="delete-group-button" @click="deleteGroup">Delete group</button>
        <p class="error-message" v-if="errorMsg">{{errorMsg}}</p>
        <div class="input-group">
          <label for="name">Name:</label> <br>
          <div class="input-field">
            <input class="name-input" type="text"  id="name" v-model="inputData.name">
          </div>
        </div>
        <div class="input-group">
          <label for="logo">Group logo:</label> <br>
          <div class="input-field">
            <input type="file" id="logo" @change="setLogoImage($event)">
          </div>
        </div>
        <button @click="onEditGroup" class="edit-group">Edit group</button>
      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import FormData from "form-data";
export default {
  name: "EditGroup",
  components: {Footer, Navbar, Header},
  props: {
    groupID: Number | String,
  },

  data(){
    return{
      errorMsg: '',
      inputData: {
        name: '',
        logo: '',
      },
    }
  },
  methods: {
    setLogoImage(event){
      if(event.target.files.length === 0){
        return;
      }
      this.inputData.logo = event.target.files[0];
    },

    async initInputFields(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/group/get/${this.groupID}`);
        this.inputData.name = response.data.result.NAME;
      } catch (err) {
        console.log(err);
      }
    },

    async onEditGroup(){
      this.errorMsg = '';
      if(this.areInputsValid === "OK"){
        const formData = new FormData();
        formData.append('image', this.inputData.logo);
        formData.append('name', this.inputData.name);

        try {
          await this.axios.post(
              `${this.$root.requestURL}/group/edit/${this.groupID}`,
              formData,
              {
                headers: {
                  'content-type': 'multipart/form-data'
                }
              }
          );
          await new Promise(r => setTimeout(r, 1000));
          await this.$router.replace({name: 'GroupPage', params: {groupID: this.groupID}});
        } catch (err) {
          console.log(err);
        }

      } else {
        this.errorMsg = this.areInputsValid;
      }
    },

    async deleteGroup(){
      try {
        await this.axios.post(`${this.$root.requestURL}/group/delete/${this.groupID}`);
      } catch (err) {
        console.log(err.response.data);
      }
      await new Promise(r => setTimeout(r, 1000));
      await this.$router.replace({name: 'Groups'});
    },
  },
  computed: {
    areInputsValid(){
      if(this.inputData.name.trim() !== ''){
        return "OK";
      } else {
        return "Please give the group a name!";
      }
    }
  },
  mounted() {
    this.initInputFields();
  }
}
</script>

<style lang="scss" scoped>

.edit-group {
  padding-top: 8vh;
  padding-bottom: 10vh;

  .content {
    margin-left: auto;
    margin-right: auto;
    width: 60%;

    .input-fields {
      width: 60%;
      border: solid 2px var(--ouline-color);
      border-radius: 30px;
      padding: 3% 5% 2% 5%;
      font-size: 18px;
      display: flex;
      flex-direction: column;
      align-items: center;
      box-shadow: 10px 10px var(--ouline-color);
      margin-left: auto;
      margin-right: auto;

      .error-message {
        color: var(--accent-color);
        font-weight: bold;
        margin-bottom: 2%;
      }

      .input-group {
        width: 100%;
        margin: 2% 0 2% 0;

        .input-field {
          display: flex;
          flex-direction: column;
          align-items: center;

          input {
            width: 96%;
            font-size: 1rem;
            margin-top: 2%;
            padding: 1% 2% 1% 2%;
            border: none;
            border-radius: 20px;
          }

        }
      }
      button {
        margin-top: 5%;
        margin-bottom: 3%;
        font-size: 20px;
        padding: 1% 3%;
        background-color: var(--accent-color);
        color: var(--font-color);
        border: none;
        border-radius: 20px;
        font-weight: bold;
        font-family: "Cambria", sans-serif;

        &:hover {
          cursor: pointer;
          -webkit-filter: brightness(90%);
          transition: all 100ms ease;
        }
      }

      #delete-group-button {
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
        align-self: flex-end;
        margin-top: 0;
        margin-bottom: 0;

        &:hover {
          cursor: pointer;
          -webkit-filter: brightness(85%);
          transition: all 100ms ease;
        }
      }
    }
  }
}
</style>