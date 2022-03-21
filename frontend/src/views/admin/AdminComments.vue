<template>
  <div class="admin-comments">
    <div class="rowflex">
      <AdminNavbar current="comments"/>
      <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'
import Navbar from "@/components/Navbar";

export default {
  name: "Comments",
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
          label: "Post ID",
          key: 'POSTID'
        },
        {
          label: "User ID",
          key: 'USERID'
        },

      ],
      tableValues: [
        {
          ID: 1,
          CONTENT: "good post",
          TIMESTAMP: "2021-05-01 15:00:00",
          POSTID: "1212",
          USERID: "5464",
        },
        {
          ID: 2,
          CONTENT: "go off queen",
          TIMESTAMP: "2021-11-21 19:00:00",
          POSTID: "4786",
          USERID: "7485",
        }
      ]
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/comment/all`)
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