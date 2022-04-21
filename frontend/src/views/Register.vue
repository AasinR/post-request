<template>
  <div class="register">
    <WelcomeBar/>
    <div class="register-form">
      <div class="register-title">
        <h1>Registration</h1>
      </div>
      <div class="input-fields">
        <p class="error-message" v-if="errorMsg">{{errorMsg}}</p>
        <div class="name-group">
          <div class="input-group firstname">
            <label for="firstname"> First name:</label> <br>
            <div class="input-field">
              <input type="text"  id="firstname" v-model="inputData.firstName" v-on:keydown.enter.exact.prevent="register">
            </div>
          </div>
          <div class="input-group last-name">
            <label for="lastname"> Last name:</label> <br>
            <div class="input-field">
              <input type="text"  id="lastname" v-model="inputData.lastName" v-on:keydown.enter.exact.prevent="register" >
            </div>
          </div>
        </div>
        <div class="input-group">
          <label for="email"> E-mail:</label> <br>
          <div class="input-field">
            <input type="email"  id="email" v-model="inputData.email" v-on:keydown.enter.exact.prevent="register" >
          </div>
        </div>
        <div class="input-group">
          <label for="password"> Password:</label> <br>
          <div class="input-field">
            <input type="password" id="password" v-model="inputData.password" v-on:keydown.enter.exact.prevent="register" >
          </div>
        </div>
        <div class="input-group">
          <label for="password-again"> Password again:</label> <br>
          <div class="input-field">
            <input type="password" id="password-again" v-model="inputData.passwordAgain" v-on:keydown.enter.exact.prevent="register" >
          </div>
        </div>
        <div class="register-btn">
          <button type="submit" @click="register">Sign up</button>
        </div>
        <div class="send-to-login">
          <p>
            Already have an account?
            <br>
            <router-link class="login-link" :to="{name: 'Login'}">Log in here!</router-link>
          </p>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
import WelcomeBar from "@/components/Welcome-Bar";
export default {
  name: "Register",
  components: {
    WelcomeBar
  },

  data() {
    return {
      inputData: {
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        passwordAgain: '',
      },

      errorMsg: '',
    }
  },
  methods: {
    async register(){
      this.errorMsg = '';
      if(this.areInputsValid === "OK") {
        try {
          await this.axios.post(`${this.$root.requestURL}/register`, {
            firstName: this.inputData.firstName,
            lastName: this.inputData.lastName,
            email: this.inputData.email,
            password: this.inputData.password,
          })
          await this.$router.replace({name: 'Login'});
        } catch (err) {
          this.errorMsg = err.response.data;
          console.log(err.response.data);
        }
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
            return "OK";
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

}
</script>

<style lang="scss" scoped>

.register {
  height: 100%;

  .register-form {
    position: absolute;
    top: 0;
    right: 0;
    height: 100vh;
    width: 55%;
    background-color: var(--light-bg-color);
    display: flex;
    flex-direction: column;
    align-items: center;
    font-family: "Cambria", sans-serif;


    .input-fields {
      width: 40%;
      border: solid 2px var(--ouline-color);
      border-radius: 30px;
      padding: 3% 5% 2% 5%;
      font-size: 1.2rem;
      display: flex;
      flex-direction: column;
      align-items: center;
      box-shadow: 10px 10px var(--ouline-color);

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

          //&.radio-field {
          //  display: flex;
          //  flex-direction: row;
          //  align-items: center;
          //
          //  .radio-input {
          //    margin: 0 0 0 3%;
          //    width: 3rem;
          //  }
          //}

          input {
            width: 95%;
            font-size: 1rem;
            margin-top: 2%;
            padding: 2% 2% 2% 3%;
            border: none;
            border-radius: 20px;
          }

        }

      }

      .send-to-login {
        p {
          font-size: 1rem;
          text-align: center;

          .login-link {
            color: var(--font-color);;
          }
        }
      }

      p {
        margin: 0;
      }


      .name-group {
        width: 100%;

        .input-group {
          display: inline-block;
          width: 48%;

          &.firstname {
            margin-right: 2%;
          }

          input {
            padding: 4% 2% 4% 3%;
          }
        }
      }

      .register-btn {
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

    .register-title {
      width: 50%;
      h1 {
        text-align: left;
        font-size: 2.5rem;
        margin-top: 15%;
        margin-bottom: 15%
      }
    }

  }
}

</style>