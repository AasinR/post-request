<template>
  <div class="admin-userdata">
    <div class="rowflex">
      <AdminNavbar current="userdata"/>
      <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'
import Navbar from "@/components/Navbar";

export default {
  name: "UserData",
  components: {
    DataTable,
    AdminNavbar,
    Navbar,
  },
  data() {
    return {
      tableHeaders: [
        {
          label: "ID",
          key: "ID"
        },
        {
          label: "Gender",
          key: "GENDER"
        },
        {
          label: "Profile picture",
          key: "PROFILEPICTURE"
        },
        {
          label: "Birthdate",
          key: 'BIRTHDATE'
        },
        {
          label: "Phone Number",
          key: "PHONENUMBER"
        },
        {
          label: "Profession",
          key: "PROFESSION"
        },
        {
          label: "User ID",
          key: "USERID "
        },

      ],
      tableValues: []
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/userdata/all`)
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
.rowflex {
  display: flex;
  flex-direction: row;
  align-items: flex-start;
}
</style>