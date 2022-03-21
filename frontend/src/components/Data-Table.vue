<template>
  <div class="table">
    <table>
      <tr>
        <th v-for="(tableHeader, index) of tableHeaders" :key="index">{{tableHeader.label}}</th>
      </tr>
      <tr v-for="tableValue of tableValues">
        <td v-for="(tableHeader, index) of tableHeaders" :key="index" >
            {{tableValue[tableHeader.key]}}
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  name: "Data-Table",
  props: {
    tableHeaders: Array,
    tableValues: Array,
  }
}
</script>

<style scoped lang="scss">
.table{
  table{
    width: 48.5vw;
    background-color: var(--light-bg-color);
    table-layout: fixed;
  }
  table, tr, th, td {
    border: 2px solid white;
    border-collapse: collapse;
  }
  tr, th, td {
    width: 10%;
    padding: 10px;
    text-align: center;
  }

  tr:hover, th{
    background-color: var(--accent-color);
  }

  td {
    word-wrap: break-word;
  }
}
</style>