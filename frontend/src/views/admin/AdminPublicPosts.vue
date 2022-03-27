<template>
  <div class="admin-publicposts">
    <div class="rowflex">
      <AdminNavbar current="public_posts"/>
      <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'
import Navbar from "@/components/Navbar";

export default {
  name: "PublicPosts",
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
          key: "TEXT"
        },
        {
          label: "Time",
          key: "TIMESTAMP"
        },
        {
          label: "Photo ID",
          key: 'PICTURE'
        },
        {
          label: "User ID",
          key: "USERID"
        },

      ],
      tableValues: []
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/post/public/all`)
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