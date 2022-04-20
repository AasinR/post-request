<template>
  <div class="admin-groups">
    <div class="rowflex">
      <AdminNavbar current="groups"/>
      <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'
import Navbar from "@/components/Navbar";

export default {
  name: "Groups",
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
          label: "Name",
          key: "NAME"
        },
        {
          label: "Logo",
          key: "LOGO"
        },
        {
          label: "Owner ID",
          key: 'OWNERID'
        },

      ],
      tableValues: []
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/group/all`)
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