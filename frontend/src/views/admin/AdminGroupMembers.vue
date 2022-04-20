<template>
  <div class="admin-group-members">
    <div class="rowflex">
      <AdminNavbar current="group_members"/>
      <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'
import Navbar from "@/components/Navbar";

export default {
  name: "GroupMembers",
  components: {
    Navbar,
    DataTable,
    AdminNavbar,
  },
  data() {
    return {
      tableHeaders: [
        {
          label: "User ID",
          key: "USERID"
        },
        {
          label: "Group ID",
          key: "GROUPID"
        },

      ],
      tableValues: []
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/groupmembers/all`)
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