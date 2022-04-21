<template>
  <div class="admin-users">
    <div class="rowflex">
      <AdminNavbar current="users"/>
      <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'
import Navbar from "@/components/Navbar";

export default {
  name: "Users",
  components: {
    Navbar,
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
      tableValues: []
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/user/admin/all`)
          .then(({data: {result}}) => {
            this.tableValues = result;
          })
          .catch((error) => {
            console.log('Hiba a lekereskor:' + error.response.data);

          });
      }
    },
    mounted() {
      this.initTable();
    }
}
</script>

<style lang="scss" scoped>
  .admin-users {

    .rowflex {
      display: flex;
      flex-direction: row;
      align-items: flex-start;

    }
  }

</style>