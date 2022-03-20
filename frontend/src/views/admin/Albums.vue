<template>
  <div class="albums">
    <AdminNavbar current="albums"/>
    <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'

export default {
  name: "Albums",
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
          label: "Name",
          key: "NAME"
        },
        {
          label: "User ID",
          key: "USERID"
        },

      ],
      tableValues: [
        {
          ID: 1,
          NAME: "Holiday",
          USERID: "1845",
        },
        {
          ID: 2,
          NAME: "Graduation",
          USERID: "7952",
        }
      ]
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/album/all`)
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


  .albums {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
  }

</style>