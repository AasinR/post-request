<template>
  <div class="posts">
    <AdminNavbar current="posts"/>
    <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'

export default {
  name: "Posts",
  components: {
    DataTable,
    AdminNavbar,
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
      tableValues: [
        {
          ID: 1,
          TEXT: "Heló beló",
          TIMESTAMP: "2022-03-20 00:00:00",
          PICTURE: "1234",
          USERID: "1111",
        },
        {
          ID: 2,
          TEXT: "felt cute might delete later",
          TIMESTAMP: "2022-02-20 12:00:00",
          PICTURE: "1485",
          USERID: "2525",
        }
      ]
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/post/all`)
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
  .posts {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
  }
</style>