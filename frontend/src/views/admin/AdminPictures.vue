<template>
  <div class="admin-pictures">
    <div class="rowflex">
      <AdminNavbar current="pictures"/>
      <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'
import Navbar from "@/components/Navbar";

export default {
  name: "Pictures",
  components: {
    Navbar,
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
          label: "Link",
          key: "CONTENT"
        },
        {
          label: "Album ID",
          key: "ALBUMID"
        },

      ],
      tableValues: []
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/img/all`)
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

</style>>