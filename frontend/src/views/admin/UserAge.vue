<template>
  <div class="admin-users">
    <div class="rowflex">
      <AdminNavbar current="userage"/>
      <div>
        <p>Average age of users: <span>{{this.avgAge}}</span></p>
        <DataTable :table-headers="tableHeaders" :table-values="tableValues" />
      </div>
    </div>
  </div>
</template>

<script>
import DataTable from '@/components/Data-Table'
import AdminNavbar from '@/components/Admin-Navbar'

export default {
  name: "UserAge",
  components: {
    DataTable,
    AdminNavbar,
  },
  data(){
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
          label: "Last name",
          key: "LASTNAME"
        },
        {
          label: "Age",
          key: 'AGE'
        },

      ],
      tableValues: [],
      avgAge: '',
    }
  },
  methods:{
    initTable(){
      this.axios.get(`${this.$root.requestURL}/user/admin/age`)
          .then(({data: {result}}) => {
            this.tableValues = result;
            if(this.tableValues[0] !== undefined && this.tableValues !== null){
              this.avgAge = this.tableValues[0].AVG_AGE;
            }
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
.admin-users {

  .rowflex {
    display: flex;
    flex-direction: row;
    align-items: flex-start;

    p {
      font-size: 20px;

      span {
        font-weight: bold;
      }
    }

  }
}

</style>