<template>
  <div class="admin-messages">
    <div class="rowflex">
      <AdminNavbar current="messages"/>
      <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'
import Navbar from "@/components/Navbar";

export default {
  name: "Messages",
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
          label: "Content",
            key: "CONTENT"
        },
        {
          label: "Time",
          key: "TIMESTAMP"
        },
        {
          label: "To User ID",
          key: 'TOUSER'
        },
        {
          label: "From User ID",
          key: "FROMUSER"
        },

      ],
      tableValues: [
        {
          ID: 1,
          CONTENT: "Hi hello love you",
          TIMESTAMP: "2022-01-01 00:00:00",
          TOUSER: "1234",
          FROMUSER: "1111",
        },
        {
          ID: 2,
          CONTENT: "sliding into the dms",
          TIMESTAMP: "2022-02-20 12:00:00",
          TOUSER: "1485",
          FROMUSER: "2525",
        }
      ]
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/message/all`)
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