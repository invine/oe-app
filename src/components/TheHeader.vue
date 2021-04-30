<template>
  <div class="order-header">
    <h1>Table Order Entry</h1>
    <span>Catalog Version</span>
    <select
      v-bind:value="value"
      v-on:change="$emit('input', $event.target.value)"
    >
      <option v-for="v in versions" v-bind:key="v">
        {{ v }}
      </option>
    </select>
    <button v-on:click="$emit('reloadCatalog')">Reload Catalog</button>
    <button v-on:click="$emit('clearOrder')">Clear</button>
  </div>
</template>

<script>
export default {
  name: "TheHeader",
  props: {
    value: String,
    catalogSnapshot: Array,
  },
  computed: {
    versions: function () {
      return this.catalogSnapshot.map((el) => el.majorVersion);
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.order-header {
  padding: 10px;
  margin: 0;
  background: black;
  color: white;
}
</style>