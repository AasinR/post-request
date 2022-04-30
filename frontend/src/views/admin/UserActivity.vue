<template>
  <div class="admin-user-activity">
    <div class="rowflex">
      <AdminNavbar current="activity"/>
      <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'

export default {
  name: "UserActivity",
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
          label: "First name",
          key: "FIRSTNAME"
        },
        {
          label: "Public posts",
          key: "PP_COUNT"
        },
        {
          label: "Public comments",
          key: 'PC_COUNT'
        },
        {
          label: "Group posts",
          key: "GP_COUNT"
        },
        {
          label: "Group comments",
          key: "GC_COUNT"
        },

      ],
      tableValues: []
    }
  },
  methods: {
    initTable(){
      this.axios.get(`${this.$root.requestURL}/user/admin/stat`)
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

.admin-user-activity {

  .rowflex {
    display: flex;
    flex-direction: row;
    align-items: flex-start;

  }
}

</style>