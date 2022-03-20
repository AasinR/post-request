<template>
  <div class="users">
    <AdminNavbar current="users"/>
    <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'

export default {
  name: "Users",
  components: {
    DataTable,
    AdminNavbar,
  },
  data(){
    return {
      tableHeaders: [
        {
          label: "ID",
          key: "ID"
        },
        {
          label: "First name",
          key: "FIRSTNAME"
        },
        {
          label: "Last name",
          key: "LASTNAME"
        },
        {
          label: "Password",
          key: 'PASSWORD'
        },
        {
          label: "Email",
          key: "EMAIL"
        },
        {
          label: "Permission",
          key: "PERMISSION"
        },

      ],
      tableValues: [
        {
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },
        {
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },
        {
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },
        {
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },
        {
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },
        {
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },
        {
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },
        {
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },
        {
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },
        {
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },{
          ID: 1,
          FIRSTNAME: "Szia",
          LASTNAME: "Uram",
          PASSWORD: "1234",
          EMAIL: "hahahahahahahahaha@gmail.com",
          PERMISSION: "1"
        },
        {
          ID: 2,
          FIRSTNAME: "Heló",
          LASTNAME: "Hölgyem",
          PASSWORD: "jelszó",
          EMAIL: "hehe@gmail.com",
          PERMISSION: "0"
        },












      ]
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/user/all`)
          .then(({data: {result}}) => {
            this.tableValues = result;
          })
          .catch((error) => {
            console.log('Hiba a lekereskor:' + error);
          });
      }
    },
    mounted() {
      this.initTable();
    }
}
</script>

<style lang="scss" scoped>
  .users {
    display: flex;
    flex-direction: row;
    align-items: flex-start;

  }

</style>