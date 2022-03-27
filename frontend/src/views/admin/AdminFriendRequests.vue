<template>
  <div class="admin-friend-requests">
    <div class="rowflex">
      <AdminNavbar current="friend_requests"/>
      <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'
import Navbar from "@/components/Navbar";

export default {
  name: "FriendRequests",
  components: {
    Navbar,
    DataTable,
    AdminNavbar,
  },
  data() {
    return {
      tableHeaders: [
        {
          label: "UserID 1",
          key: "USERID1"
        },
        {
          label: "UserID 2",
          key: "USERID2"
        },
        {
          label: "Approved",
          key: "APPROVED"
        },

      ],
      tableValues: []
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/friendrequests/all`)
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