<template>
  <div class="edit-profile">
    <Header/>
    <Navbar current="profile"/>
    <div class="content">
        <div class="input-fields">
          <p class="error-message" v-if="errorMsg">{{errorMsg}}</p>
          <div class="name-group">
            <div class="input-group firstname">
              <label for="firstname"> First name:</label> <br>
              <div class="input-field">
                <input class="name-input" type="text"  id="firstname" v-model="inputData.firstName">
              </div>
            </div>
            <div class="input-group last-name">
              <label for="lastname"> Last name:</label> <br>
              <div class="input-field">
                <input class="name-input" type="text"  id="lastname" v-model="inputData.lastName" >
              </div>
            </div>
          </div>
          <div class="input-group">
            <label for="email"> E-mail:</label> <br>
            <div class="input-field">
              <input type="email"  id="email" v-model="inputData.email" >
            </div>
          </div>
          <div class="input-group">
            <label for="password"> Password:</label> <br>
            <div class="input-field">
              <input type="password" id="password" v-model="inputData.password" >
            </div>
          </div>
          <div class="input-group">
            <label for="password-again"> Password again:</label> <br>
            <div class="input-field">
              <input type="password" id="password-again" v-model="inputData.passwordAgain" >
            </div>
          </div>
              <div class="input-group">
                <label for="phone-number"> Phone number:</label> <br>
                <div class="input-field">
                  <input type="tel" id="phone-number" v-model="inputData.phoneNumber" >
                </div>
              </div>
              <div class="input-group">
                <label for="profession"> Current workplace/school:</label> <br>
                <div class="input-field">
                  <input type="text" id="profession" v-model="inputData.profession">
                </div>
              </div>
              <div class="input-group">
                <label for="birthdate"> Date of birth:</label> <br>
                <div class="input-field">
                  <input type="date" id="birthdate" v-model="inputData.birthDate">
                </div>
              </div>
              <div class="input-group">
                <p>Gender:</p> <br>
                <div class="input-field radio-field">
                  <input class="radio-input" type="radio" id="male" name="gender" value="Male" v-model="inputData.gender">
                  <label for="male">Male</label>
                  <input class="radio-input" type="radio" id="female"  name="gender" value="Female" v-model="inputData.gender">
                  <label for="female">Female</label>
                  <input class="radio-input" type="radio" id="custom" name="gender" value="Custom" v-model="inputData.gender">
                  <label for="custom">Custom</label>
                </div>
              </div>
            <div class="input-group">
              <label for="pfp"> New profile picture:</label> <br>
              <div class="input-field">
                <input type="file" id="pfp" >
              </div>
            </div>
          <div class="edit-btn">
            <button type="submit" @click="edit">Edit</button>
          </div>
        </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Footer from "@/components/Footer";
import Navbar from "@/components/Navbar";
import Header from "@/components/Header";

export default {
  name: "EditProfile",
  components: {Footer, Navbar, Header},

  data() {
    return {
      inputData: {
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        passwordAgain: '',
        phoneNumber: '',
        profession: '',
        birthDate: '',
        gender: 'Male',
        profilePicture: '',
      },

      errorMsg: '',
    }
  },

  methods: {
    initData(){
      this.initUser();
      this.initUserData();
    },

    async initUser(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/user/get/${this.$cookies.get("UserID")}`);
        this.inputData.firstName = response.data.result.FIRSTNAME;
        this.inputData.lastName = response.data.result.LASTNAME;
        this.inputData.email = response.data.result.EMAIL;
      } catch (err) {
        console.log(err.response.data);
      }

    },

    async initUserData(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/user/data/get/${this.$cookies.get("UserID")}`);
        this.inputData.birthDate = (response.data.result.BIRTHDATE).substring(0, 10);
        this.inputData.gender = response.data.result.GENDER;
        this.inputData.phoneNumber = response.data.result.PHONENUMBER;
        this.inputData.profession = response.data.result.PROFESSION;
        this.inputData.profilePicture = response.data.result.PROFILEPICTURE;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    async edit(){
      if(this.areInputsValid === "OK") {
        try {
          await this.axios.post(`${this.$root.requestURL}/user/save`, {
            firstName: this.inputData.firstName,
            lastName: this.inputData.lastName,
            email: this.inputData.email,
            password: this.inputData.password,
          })
        } catch (err) {
          this.errorMsg = err.response.data;
          console.log(err.response.data);
        }

        try {
          await this.axios.post(`${this.$root.requestURL}/user/data/save`, {
            gender: this.inputData.gender,
            birthDate: this.inputData.birthDate,
            phoneNumber: this.inputData.phoneNumber,
            profession: this.inputData.profession,
          })
        } catch (err) {
          this.errorMsg = err.response.data;
          console.log(err.response.data);
        }
        await this.$router.replace({name: 'Profile'});
      } else {
        this.errorMsg = this.areInputsValid;
      }
    },
  },

  computed: {
    areInputsValid(){
      if(this.inputData.firstName.trim() !== '' && this.inputData.lastName.trim() !== ''){
        if(String(this.inputData.email).toLowerCase().match(/^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)){
          if(String(this.inputData.password).trim() !== '' && this.inputData.password === this.inputData.passwordAgain){
            if(this.inputData.phoneNumber.trim() === '' || this.inputData.phoneNumber.match(/((?:\+?3|0)6)(?:-|\()?(\d{1,2})(?:-|\))?(\d{3})-?(\d{3,4})/)){
              return "OK";
            } else {
              return "Invalid phone number!";
            }
          } else {
            return "Invalid password!";
          }
        } else {
          return "Invalid email!";
        }
      } else {
        return "Please fill in the name fields!";
      }
    }
  },


  mounted() {
    this.initData();
  }

}
</script>

<style lang="scss" scoped>

  .edit-profile{
    padding-top: 8vh;
    padding-bottom: 10vh;
    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;
      font-family: "Cambria", sans-serif;

       .input-fields {
        width: 60%;
        border: solid 2px var(--ouline-color);
        border-radius: 30px;
        padding: 3% 5% 2% 5%;
        font-size: 1rem;
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

            &.radio-field {
              display: flex;
              flex-direction: row;
              align-items: center;

              .radio-input {
                margin: 0 0 0 3%;
                width: 3rem;
              }
            }

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

        .name-group {
          width: 100%;

          .input-group {
            display: inline-block;
            width: 48%;

            &.firstname {
              margin-right: 2%;
            }

            .name-input {
              padding: 2% 2% 2% 3%;
            }
          }
        }

        .edit-btn {
          width: 100%;
          display: flex;
          flex-direction: column;
          align-items: center;

          button {
            width: 50%;
            margin-top: 5%;
            margin-bottom: 3%;
            font-size: 1.6rem;
            height: 3.5rem;
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
        }
      }
    }
  }

</style>