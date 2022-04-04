<template>
  <div class="login">
    <WelcomeBar/>
    <div class="login-form">
      <div class="login-title">
        <h1>To use this website, you have to log in first!</h1>
      </div>
      <div class="input-fields">
        <div class="input-group">
          <label for="email"> E-mail:</label> <br>
          <div class="input-field">
            <input type="email"  id="email" v-model="inputData.email">
          </div>
        </div>
        <div class="input-group">
          <label for="password"> Password:</label> <br>
          <div class="input-field">
            <input type="password" id="password" v-model="inputData.password">
          </div>
        </div>
        <div class="login-btn">
          <button type="submit" @click="login">Log in</button>
        </div>
        <hr>
        <div class="to-register-btn">
          <button @click="sendToRegister">Create account</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import WelcomeBar from '@/components/Welcome-Bar'

export default {
  name: "Login",
  components: {
    WelcomeBar
  },

  data() {
    return {
      inputData: {
        email: '',
        password: '',
      },
    }
  },

  methods: {
    sendToRegister(){
      this.$router.replace({name: 'Register'});
    },
    async login(){
      try {
        const response = await this.axios.post(`${this.$root.requestURL}/login`,{
          email: this.inputData.email,
          password: this.inputData.password,
        }, {
          withCredentials: false
        })
        //await this.$router.replace({name: 'Profile'});
        console.log(response);
      } catch (err) {
        console.log(err.response);
      }

    }
  },
}
</script>

<style lang="scss" scoped>

.login {
  height: 100%;

  .login-form {
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

      .input-group {
        width: 100%;
        margin: 2% 0 2% 0;

        .input-field {
          display: flex;
          flex-direction: column;
          align-items: center;
        }

        input {
          width: 95%;
          font-size: 1rem;
          margin-top: 2%;
          padding: 2% 2% 2% 3%;
          border: none;
          border-radius: 20px;
        }
      }

      hr {
        width: 100%;
      }

      .to-register-btn, .login-btn {
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

      .login-btn {
        button {
          width: 50%;
        }
      }

      .to-register-btn {
        button {
          width: 70%;
        }
      }

    }

    h1 {
      font-size: 2rem;
      margin-top: 15%;
      margin-bottom: 10%
    }

  }
}

</style>