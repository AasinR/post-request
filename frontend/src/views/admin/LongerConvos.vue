<template>
  <div class="admin-longer-convos">
    <div class="rowflex">
      <AdminNavbar current="longconvos"/>
      <div>
        <label>Select UserID:
          <select id="select-id" v-model="userID">
            <option v-for="(user, index) in users" :key="index" :value="user.ID">{{user.ID}}</option>
          </select>
        </label>
        <button id="list-button" @click="listConvos">List</button>
        <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
      </div>
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'

export default {
  name: "LongerConvos",
  components: {
    DataTable,
    AdminNavbar,
  },
  data() {
    return {
      tableHeaders: [
        {
          label: "From-ID",
          key: "F_ID"
        },
        {
          label: "From-Firstname",
          key: "F_FIRSTNAME"
        },
        {
          label: "From-Lastname",
          key: "F_LASTNAME"
        },
        {
          label: "To-ID",
          key: "T_ID"
        },
        {
          label: "To-Firstname",
          key: "T_FIRSTNAME"
        },
        {
          label: "To-Lastname",
          key: "T_LASTNAME"
        },
        {
          label: "Message count",
          key: "MSG_COUNT"
        },

      ],
      tableValues: [],
      users: [],
      userID: '',
    }
  },
  methods: {
    initTable(){
      this.axios.get(`${this.$root.requestURL}/message/stat/${this.userID}`)
          .then(({data: {result}}) => {
            this.tableValues = result;
          })
          .catch((error) => {
            console.log('Hiba a lekereskor:' + error.response.data);

          });
    },
    async initUsers(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/user/all`);
        this.users = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }
    },

    listConvos(){
      this.initTable();
    }
  },
  mounted() {
    this.initUsers();
  }
}
</script>

<style lang="scss" scoped>

.admin-longer-convos {

  .rowflex {
    display: flex;
    flex-direction: row;
    align-items: flex-start;

    label{
      font-size: 20px;
      font-weight: bold;
    }

    #select-id {
      margin-left: 2%;
      margin-bottom: 2%;
      font-size: 18px;
      padding: 0.5%;
    }

    #list-button{
      font-size: 18px;
      line-height: 24px;
      background-color: var(--accent-color);
      color: var(--font-color);
      border: none;
      border-radius: 20px;
      font-weight: bold;
      font-family: "Cambria", sans-serif;
      padding-left: 2%;
      padding-right: 2%;
      margin-left: 2%;

      &:hover {
        cursor: pointer;
        -webkit-filter: brightness(85%);
        transition: all 100ms ease;
      }
    }
  }
}

</style>